import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_tools_client/nit_tools_client.dart';
import 'entity_list_config.dart';
import 'entity_manager_interface.dart';
import 'repository.dart';

late final Caller? nitToolsCaller;

final entityManagerProviders = <Type,
    AsyncNotifierProviderFamily<EntityManagerState, List<int>,
        EntityListConfig>>{};

AsyncNotifierProviderFamily<EntityManagerState<T>, List<int>, EntityListConfig>
    entityManagerStateProvider<T extends SerializableModel>() {
  if (entityManagerProviders[T] == null) {
    entityManagerProviders[T] = AsyncNotifierProviderFamily<
        EntityManagerState<T>, List<int>, EntityListConfig>(
      EntityManagerState<T>.new,
    );
  }

  return entityManagerProviders[T] as AsyncNotifierProviderFamily<
      EntityManagerState<T>, List<int>, EntityListConfig>;
}

class EntityManagerState<Entity extends SerializableModel>
    extends FamilyAsyncNotifier<List<int>, EntityListConfig>
    implements EntityManagerInterface<Entity> {
  @override
  Future<List<int>> build(EntityListConfig config) async {
    ref.onDispose(
      () => ref
          // .read(nitSessionStateProvider.notifier)
          .removeUpdatesListener<Entity>(
        _updatesListener,
      ),
    );

    // TODO: Изменить, toString() не работает на Web release из-за minification
    debugPrint("Building state for ${Entity.toString()}");

    final result = await nitToolsCaller!.crud
        // TODO: Изменить, toString() не работает на Web release из-за minification
        .getAll(
          className: Entity.toString(),
          filters: config.backendFilters,
        )
        .then(
          (response) => ref.processApiResponse<List<int>>(response),
        )
        .then(
          (res) => res ?? <int>[],
        );

    ref
        // .read(nitSessionStateProvider.notifier)
        .addUpdatesListener<Entity>(_updatesListener);

    return result;
  }

  void _updatesListener(int id, SerializableModel updatedEntity) async {
    return await future.then(
      (value) async {
        state = AsyncValue.data(
          [
            id,
            ...value.whereNot((e) => e == id),
          ],
        );
      },
    );
  }

  void manualInsert(int modelId, Entity model) async {
    return await future.then((value) async {
      ref.manualUpdate(modelId, model);

      state = AsyncValue.data(
        [
          modelId,
          ...value.whereNot((e) => e == modelId),
        ],
      );
    });
  }

  @override
  Future<int?> save(
    Entity model, {
    bool andRemoveFromList = false,
  }) async {
    return await future.then(
      (value) async => await nitToolsCaller!.crud
          .saveModel(
            wrappedModel: ObjectWrapper.wrap(model: model),
          )
          .then((response) => ref.processApiResponse<int>(response))
          .then(
        (res) {
          if (res == null) return null;

          state = AsyncValue.data([
            if (!andRemoveFromList) res,
            ...value.whereNot((e) => e == res)
          ]);
          debugPrint("Updated value = ${state.value}");
          return res;
        },
      ),
    );
  }

  @override
  Future<bool> delete(int modelId) async {
    return await future.then(
      (value) async => await nitToolsCaller!.crud
          .delete(
            // TODO: Изменить, toString() не работает на Web release из-за minification
            className: Entity.toString(), modelId: modelId,
          )
          .then((response) => ref.processApiResponse<bool>(response))
          .then(
        (res) {
          if (res == true) {
            state = AsyncValue.data([...value.whereNot((e) => e == modelId)]);
            debugPrint("Updated value = ${state.value}");
          }
          return res ?? false;
        },
      ),
    );
  }
}
