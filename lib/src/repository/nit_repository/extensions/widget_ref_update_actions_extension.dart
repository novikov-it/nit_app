import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_riverpod_notifications/nit_riverpod_notifications.dart';

extension WidgetRefUpdateActionsExtension on WidgetRef {
  Future<int?> saveModel<T extends SerializableModel>(T model) async {
    return saveModels([model]).then(
      (ids) => ids?.first,
    );
  }

  Future<List<int>?> saveModels(List<SerializableModel> models) async {
    return await nitToolsCaller!.nitCrud
        .saveModels(
          wrappedModels:
              models.map((model) => ObjectWrapper.wrap(model: model)).toList(),
        )
        .then(
          (response) => processApiResponse<List<int>>(response),
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
          className: ObjectWrapper.getClassNameForObject(model).split('.').last,
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
      updateRepository(
        response.updatedEntities ?? [],
        updateListeners: updateListeners,
      );
    }
    return response.value;
  }

  updateFromStream(ObjectWrapper update) {
    if (update.modelId != null) {
      updateRepository([update]);
    }
  }
  // Future<int?> saveModel<T extends SerializableModel>(T model) async {
  //   final wrapper = ObjectWrapper.wrap(model: model);
  //   final response = await nitToolsCaller!.nitCrud.saveModel(
  //     wrappedModel: wrapper,
  //   );

  //   final id = processApiResponse<int>(response);

  //   // if (id != null) {
  //   //   NitRepository.updateListeningStates(
  //   //     className: wrapper.nitMappingClassname,
  //   //     modelId: id,
  //   //   );
  //   // }

  //   return id;
  // }

  // Future<List<int>?> saveModels(List<SerializableModel> models) async {
  //   return await nitToolsCaller!.nitCrud
  //       .saveModels(
  //         wrappedModels:
  //             models.map((model) => ObjectWrapper.wrap(model: model)).toList(),
  //       )
  //       .then(
  //         (response) => processApiResponse<List<int>>(response),
  //       );
  // }

  // _updateRepository(
  //   List<ObjectWrapper> wrappedModels, {
  //   bool updateListeners = true,
  // }) {
  //   for (var wrapper in wrappedModels) {
  //     for (var repo in NitRepository.getAllModelProviders(wrapper)) {
  //       read(repo.notifier).state = wrapper.model;

  //       if (updateListeners) {
  //         NitRepository.updateListeningStates(
  //           wrappedModel: wrapper,
  //         );
  //       }
  //     }
  //   }
  // }

  // K? processApiResponse<K>(ApiResponse<K> response) {
  //   debugPrint(response.toJson().toString());
  //   if (response.error != null || response.warning != null) {
  //     notifyUser(
  //       response.error != null
  //           ? NitNotification.error(response.error!)
  //           : NitNotification.warning(response.warning!),
  //     );
  //   }

  //   if ((response.updatedEntities ?? []).isNotEmpty) {
  //     _updateRepository(response.updatedEntities ?? []);
  //   }
  //   return response.value;
  // }

  // updateFromStream(ObjectWrapper update) {
  //   _updateRepository([update]);

  //   // NitRepository.updateListeningStates(
  //   //   className: update.nitMappingClassname,
  //   //   modelId: update.modelId!,
  //   // );
  // }
}
