import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';

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
    extends FamilyAsyncNotifier<List<int>, EntityListConfig> {
  @override
  Future<List<int>> build(EntityListConfig arg) async {
    ref.onDispose(
      () => NitRepository.removeUpdatesListener<Entity>(
        arg.customUpdatesListener ?? _updatesListener,
      ),
    );

    final globalTimestamp = ref.watch(globalRefreshTriggerProvider);

    debugPrint(
      "Building entity manager state for ${NitRepository.typeName<Entity>()} with timestamp $globalTimestamp",
    );

    final result = await nitToolsCaller!.nitCrud
        .getAll(
          className: NitRepository.typeName<Entity>(),
          filter: arg.backendFilter,
        )
        .then(
          (response) => ref.processApiResponse<List<int>>(
            response,
            updateListeners: false,
          ),
        )
        .then(
          (res) => res ?? <int>[],
        );

    NitRepository.addUpdatesListener<Entity>(
      arg.customUpdatesListener ?? _updatesListener,
    );

    return result;
  }

  void _updatesListener(List<ObjectWrapper> wrappedModelUpdates) async {
    final ids = wrappedModelUpdates.map((e) => e.modelId).toSet();

    return await future.then((value) async {
      state = AsyncValue.data([
        ...wrappedModelUpdates
            .where((e) =>
                !e.isDeleted &&
                (arg.backendFilter == null ||
                    arg.backendFilter!.filterUpdate(e.jsonSerialization)))
            .map((e) => e.modelId!),
        ...value.where((e) => !ids.contains(e)),
      ]);
    });

    // return await future.then(
    //   (value) async {
    //     state = AsyncValue.data(
    //       [
    //         if (!wrappedModel.isDeleted) wrappedModel.modelId!,
    //         ...value.whereNot(
    //           (e) => e == wrappedModel.modelId!,
    //         ),
    //       ],
    //     );
    //   },
    // );
  }
}
