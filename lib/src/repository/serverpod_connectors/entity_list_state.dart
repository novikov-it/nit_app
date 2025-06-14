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
  late int _nextPage;

  @override
  Future<List<Entity>> build(EntityListConfig config) async {
    ref.onDispose(
      () => NitRepository.removeUpdatesListener<Entity>(
        config.customUpdatesListener ?? _updatesListener,
      ),
    );

    _nextPage = 0;

    debugPrint("Building state for ${NitRepository.typeName<Entity>()}");

    final data = await _loadData();

    NitRepository.addUpdatesListener<Entity>(
      config.customUpdatesListener ?? _updatesListener,
    );

    return _processData(data).toList();
  }

  void loadNextPage() async {
    await future.then(
      (currentState) async {
        final data = await _loadData();

        state = AsyncValue.data(
          <Entity>[
            ...currentState,
            ..._processData(data),
          ],
        );
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
          offset: arg.pageSize != null ? _nextPage++ : null,
        )
        .then(
          (response) => ref.processApiResponse<List<ObjectWrapper>>(
            response,
            updateListeners: false,
          ),
        );

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
    // return await future.then(
    //   (value) async {
    //     print((state.value ?? []).map((e) => (e as dynamic).id));
    //     print(wrappedModel.modelId);
    //     print(wrappedModel.isDeleted);
    //     state = AsyncValue.data(
    //       [
    //         if (!wrappedModel.isDeleted) wrappedModel.model as Entity,
    //         ...value.where((e) => (e as dynamic).id != wrappedModel.modelId!),
    //       ],
    //     );
    //     print((state.value ?? []).map((e) => (e as dynamic).id));
    //   },
    // );
  }

  // void manualInsert(int modelId, Entity model) async {
  //   return await future.then((value) async {
  //     ref.manualUpdate(modelId, model);

  //     state = AsyncValue.data(
  //       [
  //         modelId,
  //         ...value.whereNot((e) => e == modelId),
  //       ],
  //     );
  //   });
  // }

  // @override
  // Future<int?> save(
  //   Entity model, {
  //   bool andRemoveFromList = false,
  // }) async {
  //   return await future.then(
  //     (value) async => await nitToolsCaller!.nitCrud
  //         .saveModel(
  //           wrappedModel: ObjectWrapper.wrap(model: model),
  //         )
  //         .then((response) => ref.processApiResponse<int>(response))
  //         .then(
  //       (res) {
  //         if (res == null) return null;

  //         state = AsyncValue.data([
  //           if (!andRemoveFromList) res,
  //           ...value.whereNot((e) => e == res)
  //         ]);
  //         debugPrint("Updated value = ${state.value}");
  //         return res;
  //       },
  //     ),
  //   );
  // }

  // @override
  // Future<bool> delete(int modelId) async {
  //   return await future.then(
  //     (value) async => await nitToolsCaller!.nitCrud
  //         .delete(
  //           // TODO: Изменить, toString() не работает на Web release из-за minification
  //           className: Entity.toString(), modelId: modelId,
  //         )
  //         .then((response) => ref.processApiResponse<bool>(response))
  //         .then(
  //       (res) {
  //         if (res == true) {
  //           state = AsyncValue.data([...value.whereNot((e) => e == modelId)]);
  //           debugPrint("Updated value = ${state.value}");
  //         }
  //         return res ?? false;
  //       },
  //     ),
  //   );
  // }
}
