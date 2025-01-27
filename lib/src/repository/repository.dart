import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_riverpod_notifications/nit_riverpod_notifications.dart';
import 'package:nit_router/nit_router.dart';
import 'package:nit_tools_client/nit_tools_client.dart';
import 'entity_list_config.dart';
import 'entity_manager_state.dart';
import 'single_item_custom_provider.dart';
import 'single_item_custom_provider_config.dart';
import 'single_item_provider.dart';

final Map<String, StateProviderFamily<SerializableModel?, int>> _repository =
    {};
final Map<String, List<Function(int, SerializableModel)>> _updateListeners = {};

StateProviderFamily<SerializableModel?, int> initRepository(String className) {
  _repository[className] =
      StateProvider.family<SerializableModel?, int>((ref, id) => null);

  return _repository[className] as StateProviderFamily<SerializableModel?, int>;
}

StateProviderFamily<SerializableModel?, int> modelProvider(String className) {
  final rep = _repository[className];

  if (rep == null) return initRepository(className);

  return rep;
}

_filter<T>(T? model, bool Function(T model) filter) =>
    model != null ? filter(model) : false;

extension WidgetRefRepositoryExtension on WidgetRef {
  T? watchModel<T extends SerializableModel>(int id) =>
      // TODO: Изменить, toString() не работает на Web release из-за minification
      watch(modelProvider(T.toString())(id)) as T?;
  T? readModel<T extends SerializableModel>(int id) =>
      // TODO: Изменить, toString() не работает на Web release из-за minification
      read(modelProvider(T.toString())(id)) as T?;

  Future<T> watchOrFetchModel<T extends SerializableModel>(int id) async {
    T? model = watchModel<T>(id);

    if (model == null) await watch(singleItemProvider<T>()(id).future);

    return watchModel<T>(id)!;
  }

  AsyncValue<T?> watchOrFetchModelAsync<T extends SerializableModel>(int id) {
    T? model = watchModel<T>(id);

    return model != null
        ? AsyncData(model)
        : watch(singleItemProvider<T>()(id)).whenData((_) => watchModel<T>(id));
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

  int? get getIdFromPath => CommonNavigationParameters.id.get(
        watch(navigationPathParametersProvider),
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
    return await nitToolsCaller!.crud
        .saveModel(
          wrappedModel: ObjectWrapper.wrap(model: model),
        )
        .then(
          (response) => _processApiResponse<int>(response),
        );
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

  _updateRepository(List<ObjectWrapper> newModels) {
    for (var e in newModels) {
      if (_repository[e.nitMappingClassname] == null) {
        debugPrint("Initializing repo for ${e.nitMappingClassname}");
        initRepository(e.nitMappingClassname);
      }
      read(_repository[e.nitMappingClassname]!(e.modelId!).notifier).state =
          e.model;
    }
  }
}

extension RefRepositoryExtension on Ref {
  T? watchModel<T extends SerializableModel>(int id) =>
      watch(modelProvider(T.toString())(id)) as T?;
  T? readModel<T extends SerializableModel>(int id) =>
      read(modelProvider(T.toString())(id)) as T?;

  Future<T?> watchOrFetchModel<T extends SerializableModel>(int id) async {
    T? model = watchModel<T>(id);

    if (model == null) await watch(singleItemProvider<T>()(id).future);

    return watchModel<T>(id);
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
    return await nitToolsCaller!.crud
        .saveModel(
          wrappedModel: ObjectWrapper.wrap(model: model),
        )
        .then(
          (response) => processApiResponse<int>(response),
        );
  }

  Future<List<int>?> saveModels(List<SerializableModel> models) async {
    return await nitToolsCaller!.crud
        .saveModels(
          wrappedModels:
              models.map((model) => ObjectWrapper.wrap(model: model)).toList(),
        )
        .then(
          (response) => processApiResponse<List<int>>(response),
        );
  }

  _updateRepository(List<ObjectWrapper> newModels) {
    for (var e in newModels) {
      if (_repository[e.nitMappingClassname] == null) {
        debugPrint("Initializing repo for ${e.nitMappingClassname}");
        initRepository(e.nitMappingClassname);
      }
      read(_repository[e.nitMappingClassname]!(e.modelId!).notifier).state =
          e.model;
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
    for (var listener in _updateListeners[update.nitMappingClassname] ?? []) {
      listener(update.modelId, update.model);
    }
  }

  addUpdatesListener<T extends SerializableModel>(
      Function(
        int id,
        SerializableModel entity,
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
        SerializableModel entity,
      ) listener) {
    // TODO: Изменить, toString() не работает на Web release из-за minification
    if (_updateListeners[T.toString()] != null) {
      _updateListeners[T.toString()]!.remove(listener);
    }
  }
}
