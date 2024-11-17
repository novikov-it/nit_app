import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_router/nit_router.dart';
import 'package:nit_tools_client/nit_tools_client.dart';
import 'entity_manager_config.dart';
import 'entity_manager_state.dart';
import 'single_item_provider.dart';

final Map<Type, StateProviderFamily<dynamic, int>> repository = {};

StateProviderFamily<T?, int> initRepository<T>() {
  repository[T] = StateProvider.family<T?, int>((ref, id) => null);

  return repository[T] as StateProviderFamily<T?, int>;
}

StateProviderFamily<T?, int> modelProvider<T>() {
  final rep = repository[T];

  if (rep == null) return initRepository<T>();

  return rep as StateProviderFamily<T?, int>;
}

_filter<T>(T? model, bool Function(T model) filter) =>
    model != null ? filter(model) : false;

extension WidgetRefRepositoryExtension on WidgetRef {
  T? watchModel<T extends SerializableModel>(int id) {
    final p = modelProvider<T>();

    final t = watch(p(id));

    return t;
  }

  // watch((id));
  T? readModel<T extends SerializableModel>(int id) =>
      read(modelProvider<T>()(id));

  AsyncValue<T?> watchEntityState<T extends SerializableModel>(int id) =>
      watch(singleItemProvider<T>()(id))
          .whenData((value) => value == null ? null : watchModel<T>(value));

  int? get getIdFromPath => CommonNavigationParameters.id.get(
        watch(navigationPathParametersProvider),
      );
  //(value) => value?.model as T);

  static const _defaultConfig = EntityListConfig();

  AsyncValue<List<int>> watchEntityListState<T extends SerializableModel>({
    // List<NitBackendFilter>? backendFilters,
    EntityListConfig? backendConfig,
    bool Function(T model)? frontendFilter,
  }) =>
      watch(
        entityManagerStateProvider<T>()(backendConfig ?? _defaultConfig
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
  T? watchModel<T>(int id) => watch(modelProvider<T>()(id));
  T? readModel<T>(int id) => read(modelProvider<T>()(id));

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

  _updateRepository<T>(List<ObjectWrapper> newModels) {
    if (repository[T] == null) {
      debugPrint("Initializing repo for $T");
      initRepository<T>();
    }

    print(T.toString());

    for (var e in newModels) {
      read(repository[T]!(e.modelId!).notifier).state = e.model as T;
    }
  }

  K? processApiResponse<K, T>(ApiResponse<K> response) {
    if ((response.updatedEntities ?? []).isNotEmpty) {
      _updateRepository<T>(response.updatedEntities ?? []);
    }
    return response.value;
  }
}
