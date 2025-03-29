import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_riverpod_notifications/nit_riverpod_notifications.dart';

extension RefUpdateActionsExtension on Ref {
  Future<int?> saveModel<T extends SerializableModel>(T model) async {
    final wrapper = ObjectWrapper.wrap(model: model);
    final response = await nitToolsCaller!.nitCrud.saveModel(
      wrappedModel: wrapper,
    );

    final id = processApiResponse<int>(response);

    if (id != null) {
      NitRepository.updateListeningStates(
        className: wrapper.nitMappingClassname,
        modelId: id,
      );
    }

    return id;
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

  updateRepository(List<ObjectWrapper> wrappedModels) {
    for (var wrapper in wrappedModels) {
      for (var repo in NitRepository.getAllModelProviders(wrapper)) {
        read(repo.notifier).state = wrapper.model;
      }
    }
  }

  K? processApiResponse<K>(ApiResponse<K> response) {
    debugPrint(response.toJson().toString());
    if (response.error != null || response.warning != null) {
      notifyUser(
        response.error != null
            ? NitNotification.error(response.error!)
            : NitNotification.warning(response.warning!),
      );
    }

    if ((response.updatedEntities ?? []).isNotEmpty) {
      updateRepository(response.updatedEntities ?? []);
    }
    return response.value;
  }

  updateFromStream(ObjectWrapper update) {
    if (update.modelId != null) {
      updateRepository([update]);

      NitRepository.updateListeningStates(
        className: update.nitMappingClassname,
        modelId: update.modelId!,
      );
    }
  }
}
