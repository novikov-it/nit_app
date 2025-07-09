import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_app/src/repository/serverpod_connectors/entity_list_state.dart';

_filter<T>(T? model, bool Function(T model) filter) =>
    model != null ? filter(model) : false;

extension RefEntityListStateExtension on Ref {
  Future<List<int>> watchEntityListIds<T extends SerializableModel>({
    NitBackendFilter? backendFilter,
    bool Function(T model)? frontendFilter,
  }) async {
    final ids = await watch(
      entityManagerStateProvider<T>()(
        EntityListConfig(
          backendFilter: backendFilter,
        ),
      ).future,
    );

    return frontendFilter == null
        ? ids
        : ids.where((e) => _filter(watchModel<T>(e), frontendFilter)).toList();
  }

  Future<List<T>> watchEntityList<T extends SerializableModel>({
    NitBackendFilter? backendFilter,
    bool Function(T model)? frontendFilter,
  }) async {
    final items = await watch(
      entityListStateProvider<T>()(
        EntityListConfig(
          backendFilter: backendFilter,
        ),
      ).future,
    );

    return frontendFilter == null
        ? items
        : items.where((e) => _filter(e, frontendFilter)).toList();
  }

  AsyncValue<List<int>> watchEntityListIdsAsync<T extends SerializableModel>({
    NitBackendFilter? backendFilter,
    bool Function(T model)? frontendFilter,
  }) =>
      watch(
        entityManagerStateProvider<T>()(
          EntityListConfig(
            backendFilter: backendFilter,
          ),
        ),
      ).whenData(
        (data) => frontendFilter == null
            ? data
            : data
                .where((e) => _filter(watchModel<T>(e), frontendFilter))
                .toList(),
      );

  AsyncValue<List<T>> watchEntityListAsync<T extends SerializableModel>({
    NitBackendFilter? backendFilter,
    bool Function(T model)? frontendFilter,
  }) =>
      watch(
        entityListStateProvider<T>()(
          EntityListConfig(
            backendFilter: backendFilter,
          ),
        ),
      ).whenData(
        (data) => frontendFilter == null
            ? data
            : data.where((e) => _filter(e, frontendFilter)).toList(),
      );

  AsyncValue<List<T>>
      watchEntityListCustomizedAsync<T extends SerializableModel>({
    required EntityListConfig<T> entityListConfig,
    bool Function(T model)? frontendFilter,
  }) =>
          watch(
            entityListStateProvider<T>()(
              entityListConfig,
            ),
          ).whenData(
            (data) => frontendFilter == null
                ? data
                : data.where((e) => _filter(e, frontendFilter)).toList(),
          );

  Future<bool>
      loadNextPageForCustomizedEntityListMore<T extends SerializableModel>({
    required EntityListConfig<T> entityListConfig,
  }) =>
          read(entityListStateProvider<T>()(
            entityListConfig,
          ).notifier)
              .loadNextPage();
}
