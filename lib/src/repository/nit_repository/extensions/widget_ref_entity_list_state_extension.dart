import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_app/src/repository/serverpod_connectors/entity_list_state.dart';

_filter<T>(T? model, bool Function(T model) filter) =>
    model != null ? filter(model) : false;

extension WidgetRefEntityListStateExtensions on WidgetRef {
  AsyncValue<List<int>> watchEntityListState<T extends SerializableModel>({
    EntityListConfig backendConfig = const EntityListConfig(),
    // List<NitBackendFilter>? backendFilters,
    bool Function(T model)? frontendFilter,
  }) =>
      watch(
        entityManagerStateProvider<T>()(
          backendConfig,
          // EntityListConfig(backendFilters: backendFilters),
        ),
      ).whenData(
        (data) => frontendFilter == null
            ? data
            : data
                .where((e) => _filter(watchModel<T>(e), frontendFilter))
                .toList(),
      );

  AsyncValue<List<T>> watchEntityList<T extends SerializableModel>({
    EntityListConfig? backendConfig,
    // List<NitBackendFilter>? backendFilters,
    bool Function(T model)? frontendFilter,
  }) =>
      watch(
        entityListStateProvider<T>()(
          backendConfig ?? const EntityListConfig(),
        ),
      ).whenData(
        (data) => frontendFilter == null
            ? data
            : data.where((e) => _filter(e, frontendFilter)).toList(),
      );
}
