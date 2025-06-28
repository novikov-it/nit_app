import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';

final entityListStateProviders = <Type,
    AsyncNotifierProviderFamily<EntityListState, List<dynamic>,
        EntityListConfig>>{};

AsyncNotifierProviderFamily<EntityListState<T>, List<T>, EntityListConfig>
    entityListStateProvider<T extends SerializableModel>() {
  if (entityListStateProviders[T] == null) {
    entityListStateProviders[T] = AsyncNotifierProviderFamily<
        EntityListState<T>, List<T>, EntityListConfig>(
      EntityListState<T>.new,
    );
  }

  return entityListStateProviders[T] as AsyncNotifierProviderFamily<
      EntityListState<T>, List<T>, EntityListConfig>;
}

class EntityListState<Entity extends SerializableModel>
    extends FamilyAsyncNotifier<List<Entity>, EntityListConfig>
// implements EntityManagerInterface<Entity>
{
  late int _offset;

  @override
  Future<List<Entity>> build(EntityListConfig config) async {
    ref.onDispose(
      () => NitRepository.removeUpdatesListener<Entity>(
        config.customUpdatesListener ?? _updatesListener,
      ),
    );

    _offset = 0;

    debugPrint("Building state for ${NitRepository.typeName<Entity>()}");

    final data = await _loadData();

    NitRepository.addUpdatesListener<Entity>(
      config.customUpdatesListener ?? _updatesListener,
    );

    return _processData(data).toList();
  }

  Future<bool> loadNextPage() async {
    return await future.then(
      (currentState) async {
        final data = await _loadData();

        state = AsyncValue.data(
          <Entity>[
            ...currentState,
            ..._processData(data),
          ],
        );

        return data.length == arg.pageSize;
      },
    );
  }

  _processData(List<ObjectWrapper> data) => data.map((e) => e.model as Entity);

  Future<List<ObjectWrapper>> _loadData() async {
    final result = await nitToolsCaller!.nitCrud
        // TODO: Изменить, toString() не работает на Web release из-за minification
        .getEntityList(
          className: NitRepository.typeName<Entity>(),
          filter: arg.backendFilter,
          limit: arg.pageSize,
          offset: _offset,
        )
        .then(
          (response) => ref.processApiResponse<List<ObjectWrapper>>(
            response,
            updateListeners: false,
          ),
        );

    _offset += arg.pageSize ?? 0;

    if (result == null) return <ObjectWrapper>[];

    ref.updateRepository(result, updateListeners: false);

    return result;
  }

  void _updatesListener(List<ObjectWrapper> wrappedModelUpdates) async {
    final ids = wrappedModelUpdates.map((e) => e.modelId).toSet();

    return await future.then((value) async {
      state = AsyncValue.data([
        ...wrappedModelUpdates
            .where((e) => !e.isDeleted)
            .map((e) => e.model as Entity),
        ...value.where((e) => !ids.contains((e as dynamic).id)),
      ]);
    });
  }
}
