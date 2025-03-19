import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_riverpod_notifications/nit_riverpod_notifications.dart';

final Map<String, StateProviderFamily<SerializableModel?, int>> _repository =
    {};
final Map<String, List<Function(int)>> _updateListeners = {};

StateProviderFamily<SerializableModel?, int> initRepository(String className) {
  debugPrint("Initializing repo for $className");
  return _repository[className] =
      StateProvider.family<SerializableModel?, int>((ref, id) => null);
}

_updateListeningStates({
  required String className,
  required int modelId,
}) {
  debugPrint(
    'Updating Listening State. Active listeners: ${_updateListeners.keys}. Updated id - $modelId for class $className',
  );
  for (var listener in _updateListeners[className] ?? []) {
    listener(
      modelId,
    );
  }
}

//   return _repository[className] as StateProviderFamily<SerializableModel?, int>;
// }

StateProviderFamily<SerializableModel?, int> modelProvider(String className) {
  final rep = _repository[className];

  if (rep == null) return initRepository(className);

  return rep;
}

_filter<T>(T? model, bool Function(T model) filter) =>
    model != null ? filter(model) : false;

extension WidgetRefRepositoryExtension on WidgetRef {
  T defaultModel<T>() => DefaultModelsRepository.get<T>();

  T? watchModelCustom<T extends SerializableModel>(
    int foreignKey,
    RepositoryDescriptor descriptor,
  ) =>
      watch(RepositoryDescriptor.customModelProvider(descriptor)(foreignKey))
          as T?;

  T? watchModel<T extends SerializableModel>(int id) => id ==
          DefaultModelsRepository.mockModelId
      ? DefaultModelsRepository.get<T>()
      :
      // TODO: Изменить, toString() не работает на Web release из-за minification
      watch(modelProvider(T.toString())(id)) as T?;
  T? readModel<T extends SerializableModel>(int id) => id ==
          DefaultModelsRepository.mockModelId
      ? DefaultModelsRepository.get<T>()
      :
      // TODO: Изменить, toString() не работает на Web release из-за minification
      read(modelProvider(T.toString())(id)) as T?;

  Future<T> watchOrFetchModel<T extends SerializableModel>(int id) async {
    T? model = watchModel<T>(id);

    if (model == null) await watch(singleItemProvider<T>()(id).future);

    return watchModel<T>(id)!;
  }

  AsyncValue<T> watchOrFetchModelAsync<T extends SerializableModel>(int id) {
    T? model = watchModel<T>(id);

    return model != null
        ? AsyncData(model)
        : watch(singleItemProvider<T>()(id))
            .whenData((_) => watchModel<T>(id)!);
  }

  Future<T> readOrFetchModel<T extends SerializableModel>(int id) async {
    T? model = readModel<T>(id);

    if (model == null) await watch(singleItemProvider<T>()(id).future);

    return readModel<T>(id)!;
  }

  AsyncValue<T?> watchEntityState<T extends SerializableModel>(int id) =>
      watch(singleItemProvider<T>()(id)).whenData(
        (value) => value == null ? null : watchModel<T>(value),
      );

  AsyncValue<T?> watchEntityCustomState<T extends SerializableModel>(
          SingleItemCustomProviderConfig config) =>
      watch(singleItemCustomProvider<T>()(config)).whenData(
        (value) => value == null ? null : watchModel<T>(value),
      );

  AsyncValue<List<int>> watchEntityListState<T extends SerializableModel>({
    EntityListConfig? backendConfig,
    bool Function(T model)? frontendFilter,
  }) =>
      watch(
        entityManagerStateProvider<T>()(
            backendConfig ?? EntityListConfig.defaultConfig),
      ).whenData(
        (data) => frontendFilter == null
            ? data
            : data
                .where((e) => _filter(watchModel<T>(e), frontendFilter))
                .toList(),
      );

  Future<int?> saveModel(SerializableModel model) async {
    final wrapper = ObjectWrapper.wrap(model: model);
    final response = await nitToolsCaller!.nitCrud.saveModel(
      wrappedModel: wrapper,
    );

    final id = _processApiResponse<int>(response);

    if (id != null) {
      _updateListeningStates(
        className: wrapper.nitMappingClassname,
        modelId: id,
      );
    }

    return id;
  }

  K? _processApiResponse<K>(ApiResponse<K> response) {
    debugPrint(response.toJson().toString());
    if (response.error != null || response.warning != null) {
      notifyUser(
        response.error != null
            ? NitNotification.error(response.error!)
            : NitNotification.warning(response.warning!),
      );
    }

    if ((response.updatedEntities ?? []).isNotEmpty) {
      _updateRepository(response.updatedEntities ?? []);
    }
    return response.value;
  }

  _updateRepository(List<ObjectWrapper> wrappedModels) {
    for (var wrapper in wrappedModels) {
      if (_repository[wrapper.nitMappingClassname] == null) {
        initRepository(wrapper.nitMappingClassname);
      }
      read(_repository[wrapper.nitMappingClassname]!(wrapper.modelId!).notifier)
          .state = wrapper.model;

      for (var descriptor in RepositoryDescriptor.getCustomDescriptors(
        wrapper.nitMappingClassname,
      )) {
        if (wrapper.foreignKeys.containsKey(descriptor.fieldName)) {
          read(RepositoryDescriptor.getCustomRepository(descriptor)(
                      wrapper.foreignKeys[descriptor.fieldName]!)
                  .notifier)
              .state = wrapper.model;
        }
      }
    }
  }
}

extension RefRepositoryExtension on Ref {
  T defaultModel<T>() => DefaultModelsRepository.get<T>();

  T? watchModelCustom<T extends SerializableModel>(
    int foreignKey,
    RepositoryDescriptor descriptor,
  ) =>
      watch(RepositoryDescriptor.customModelProvider(descriptor)(foreignKey))
          as T?;

  T? watchModel<T extends SerializableModel>(int id) =>
      id == DefaultModelsRepository.mockModelId
          ? DefaultModelsRepository.get<T>()
          : watch(modelProvider(T.toString())(id)) as T?;
  T? readModel<T extends SerializableModel>(int id) =>
      id == DefaultModelsRepository.mockModelId
          ? DefaultModelsRepository.get<T>()
          : read(modelProvider(T.toString())(id)) as T?;

  Future<T> watchOrFetchModel<T extends SerializableModel>(int id) async {
    T? model = watchModel<T>(id);

    if (model == null) await watch(singleItemProvider<T>()(id).future);

    return watchModel<T>(id)!;
  }

  Future<T> readOrFetchModel<T extends SerializableModel>(int id) async {
    T? model = readModel<T>(id);

    if (model == null) await watch(singleItemProvider<T>()(id).future);

    return readModel<T>(id)!;
  }

  AsyncValue<T?> watchEntityState<T extends SerializableModel>(int id) =>
      watch(singleItemProvider<T>()(id)).whenData(
        (value) => value == null ? null : watchModel<T>(value),
      );

  AsyncValue<T?> watchEntityCustomState<T extends SerializableModel>(
          SingleItemCustomProviderConfig config) =>
      watch(singleItemCustomProvider<T>()(config)).whenData(
        (value) => value == null ? null : watchModel<T>(value),
      );

  AsyncValue<List<int>> watchEntityListState<T extends SerializableModel>({
    List<NitBackendFilter>? backendFilters,
    bool Function(T model)? frontendFilter,
  }) =>
      watch(
        entityManagerStateProvider<T>()(
          EntityListConfig(backendFilters: backendFilters),
        ),
      ).whenData(
        (data) => frontendFilter == null
            ? data
            : data
                .where((e) => _filter(watchModel<T>(e), frontendFilter))
                .toList(),
      );

  Future<int?> saveModel(SerializableModel model) async {
    final wrapper = ObjectWrapper.wrap(model: model);
    final response = await nitToolsCaller!.nitCrud.saveModel(
      wrappedModel: wrapper,
    );

    final id = processApiResponse<int>(response);

    if (id != null) {
      _updateListeningStates(
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

  // _updateRepository(List<ObjectWrapper> newModels) {
  //   for (var e in newModels) {
  //     if (_repository[e.nitMappingClassname] == null) {
  //       debugPrint("Initializing repo for ${e.nitMappingClassname}");
  //       initRepository(e.nitMappingClassname);
  //     }
  //     read(_repository[e.nitMappingClassname]!(e.modelId!).notifier).state =
  //         e.model;
  //   }

  // }

  _updateRepository(List<ObjectWrapper> wrappedModels) {
    for (var wrapper in wrappedModels) {
      if (_repository[wrapper.nitMappingClassname] == null) {
        initRepository(wrapper.nitMappingClassname);
      }
      read(_repository[wrapper.nitMappingClassname]!(wrapper.modelId!).notifier)
          .state = wrapper.model;

      for (var descriptor in RepositoryDescriptor.getCustomDescriptors(
        wrapper.nitMappingClassname,
      )) {
        if (wrapper.foreignKeys.containsKey(descriptor.fieldName)) {
          read(RepositoryDescriptor.getCustomRepository(descriptor)(
                      wrapper.foreignKeys[descriptor.fieldName]!)
                  .notifier)
              .state = wrapper.model;
        }
      }
    }
  }

  void manualUpdate<K extends SerializableModel>(
    int modelId,
    K model,
  ) {
    // TODO: Изменить, toString() не работает на Web release из-за minification
    final typeName = K.toString();

    if (_repository[typeName] == null) {
      debugPrint("Initializing repo for $typeName");
      initRepository(typeName);
    }
    read(_repository[typeName]!(modelId).notifier).state = model;
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
      _updateRepository(response.updatedEntities ?? []);
    }
    return response.value;
  }

  updateFromStream(ObjectWrapper update) {
    _updateRepository([update]);

    _updateListeningStates(
      className: update.nitMappingClassname,
      modelId: update.modelId!,
    );
  }

  addUpdatesListener<T extends SerializableModel>(
      Function(
        int id,
      ) listener) {
    // TODO: Изменить, toString() не работает на Web release из-за minification
    if (_updateListeners[T.toString()] == null) {
      _updateListeners[T.toString()] = [];
    }
    _updateListeners[T.toString()]!.add(listener);
  }

  removeUpdatesListener<T>(
      Function(
        int id,
      ) listener) {
    // TODO: Изменить, toString() не работает на Web release из-за minification
    if (_updateListeners[T.toString()] != null) {
      _updateListeners[T.toString()]!.remove(listener);
    }
  }
}
