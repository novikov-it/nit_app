import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_riverpod_notifications/nit_riverpod_notifications.dart';

extension RefUpdateActionsExtension on Ref {
  Future<int> saveModel<T extends SerializableModel>(T model,
      {bool updateListeners = true}) async {
    return saveModels([model], updateListeners: updateListeners).then(
      (ids) => ids.isNotEmpty
          ? ids[0]
          : throw Exception(
              'Failed to save ${NitRepository.typeName<T>()} $model',
            ),
    );
  }

  Future<List<int>> saveModels(List<SerializableModel> models,
      {bool updateListeners = true}) async {
    return await nitToolsCaller!.nitCrud
        .saveModels(
          wrappedModels:
              models.map((model) => ObjectWrapper.wrap(model: model)).toList(),
        )
        .then(
          (response) =>
              processApiResponse<List<int>>(response,
                  updateListeners: updateListeners) ??
              [],
        );
  }

  Future<bool> deleteModel<T extends SerializableModel>(T model) async {
    // TODO: подумать, как сделать это получше, может апи поменять или засылать objectWrapper.deleted просто

    final modelId = model.toJson()['id'];
    if (modelId == null) {
      // notifyUser(NitNotification.warning(
      //   'Мое',
      // ));
      return true;
    }
    return await nitToolsCaller!.nitCrud
        .delete(
          className: ObjectWrapper.getClassNameForObject(model),
          modelId: modelId,
        )
        .then(
          (response) => processApiResponse<bool>(response) ?? false,
        );
  }

  updateRepository(
    List<ObjectWrapper> wrappedModels, {
    bool updateListeners = true,
  }) {
    for (var wrapper in wrappedModels) {
      for (var repo in NitRepository.getAllModelProviders(wrapper)) {
        read(repo.notifier).state = wrapper.isDeleted ? null : wrapper.model;
      }
    }

    if (updateListeners) {
      NitRepository.updateListeningStates(
        wrappedModelUpdates: wrappedModels,
      );
    }
  }

  K? processApiResponse<K>(
    ApiResponse<K> response, {
    bool updateListeners = true,
  }) {
    debugPrint(response.toJson().toString());
    if (response.error != null || response.warning != null) {
      notifyUser(
        response.error != null
            ? NitNotification.error(response.error!)
            : NitNotification.warning(response.warning!),
      );
    }

    if ((response.updatedEntities ?? []).isNotEmpty) {
      updateRepository(response.updatedEntities ?? [],
          updateListeners: updateListeners);
    }
    return response.value;
  }

  updateFromStream(List<ObjectWrapper> updates) {
    // if (update.modelId != null) {
    updateRepository(updates);
    // }
  }
}
