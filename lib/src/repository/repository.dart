import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/src/repository/single_item_custom_provider_config.dart';
import 'package:nit_riverpod_notifications/nit_riverpod_notifications.dart';
import 'package:nit_router/nit_router.dart';
import 'package:nit_tools_client/nit_tools_client.dart';
import 'entity_list_config.dart';
import 'entity_manager_state.dart';
import 'single_item_custom_provider.dart';
import 'single_item_provider.dart';

final Map<String, StateProviderFamily<SerializableModel?, int>> repository = {};

StateProviderFamily<SerializableModel?, int> initRepository(String className) {
  repository[className] =
      StateProvider.family<SerializableModel?, int>((ref, id) => null);

  return repository[className] as StateProviderFamily<SerializableModel?, int>;
}

StateProviderFamily<SerializableModel?, int> modelProvider(String className) {
  final rep = repository[className];

  if (rep == null) return initRepository(className);

  return rep; // as StateProviderFamily<SerializableModel?, int>;
}

_filter<T>(T? model, bool Function(T model) filter) =>
    model != null ? filter(model) : false;

extension WidgetRefRepositoryExtension on WidgetRef {
  // T? watchModel<T extends SerializableModel>(int id) =>
  //     watch(modelProvider<T>()(id));

  // T? readModel<T extends SerializableModel>(int id) =>
  //     read(modelProvider<T>()(id));

  T? watchModel<T extends SerializableModel>(int id) =>
      watch(modelProvider(T.toString())(id)) as T?;
  T? readModel<T extends SerializableModel>(int id) =>
      read(modelProvider(T.toString())(id)) as T?;

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
  //(value) => value?.model as T);

  AsyncValue<List<int>> watchEntityListState<T extends SerializableModel>({
    // List<NitBackendFilter>? backendFilters,
    EntityListConfig? backendConfig,
    bool Function(T model)? frontendFilter,
  }) =>
      watch(
        entityManagerStateProvider<T>()(
            backendConfig ?? EntityListConfig.defaultConfig
            // EntityManagerConfig(backendFilters: backendFilters),
            ),
      ).whenData(
        (data) => frontendFilter == null
            ? data
            : data
                .where((e) => _filter(watchModel<T>(e), frontendFilter))
                .toList(),
      );
}

extension RefRepositoryExtension on Ref {
  T? watchModel<T extends SerializableModel>(int id) =>
      watch(modelProvider(T.toString())(id)) as T?;
  T? readModel<T extends SerializableModel>(int id) =>
      read(modelProvider(T.toString())(id)) as T?;

  AsyncValue<T?> watchEntityState<T extends SerializableModel>(int id) =>
      watch(singleItemProvider<T>()(id)).whenData(
        (value) => value == null ? null : watchModel<T>(value),
      );

  AsyncValue<T?> watchEntityCustomState<T extends SerializableModel>(
          SingleItemCustomProviderConfig config) =>
      watch(singleItemCustomProvider<T>()(config)).whenData(
        (value) => value == null ? null : watchModel<T>(value),
      );

  // AsyncValue<T?> readEntityCustomState<T extends SerializableModel>(
  //         SingleItemCustomProviderConfig config) =>
  //     watch(singleItemCustomProvider<T>()(config)).whenData(
  //       (value) => value == null ? null : readModel<T>(value),
  //     );

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
    return await nitToolsCaller.crud
        .saveModel(
          wrappedModel: ObjectWrapper.wrap(model: model),
        )
        .then(
          (response) => processApiResponse<int>(response),
        );
  }

  Future<List<int>?> saveModels(List<SerializableModel> models) async {
    return await nitToolsCaller.crud
        .saveModels(
          wrappedModels:
              models.map((model) => ObjectWrapper.wrap(model: model)).toList(),
        )
        .then(
          (response) => processApiResponse<List<int>>(response),
        );
  }

  _updateRepository(List<ObjectWrapper> newModels) {
    // if (repository[T.toString()] == null) {
    //   debugPrint("Initializing repo for $T");
    //   initRepository<T>();
    // }

    // print(T.toString());

    for (var e in newModels) {
      if (repository[e.nitMappingClassname] == null) {
        debugPrint("Initializing repo for ${e.nitMappingClassname}");
        initRepository(e.nitMappingClassname);
      }
      read(repository[e.nitMappingClassname]!(e.modelId!).notifier).state =
          e.model;
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
      _updateRepository(response.updatedEntities ?? []);
    }
    return response.value;
  }
}
