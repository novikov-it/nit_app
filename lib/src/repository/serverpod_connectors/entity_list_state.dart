import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';

final entityListStateProviders = <Type,
    AsyncNotifierProviderFamily<EntityListState, List<dynamic>,
        EntityListConfig>>{};

AsyncNotifierProviderFamily<EntityListState<Entity>, List<Entity>,
        EntityListConfig<Entity>>
    entityListStateProvider<Entity extends SerializableModel>() {
  if (entityListStateProviders[Entity] == null) {
    entityListStateProviders[Entity] = AsyncNotifierProviderFamily<
        EntityListState<Entity>, List<Entity>, EntityListConfig<Entity>>(
      EntityListState<Entity>.new,
    );
  }

  return entityListStateProviders[Entity] as AsyncNotifierProviderFamily<
      EntityListState<Entity>, List<Entity>, EntityListConfig<Entity>>;
}

class EntityListState<Entity extends SerializableModel>
    extends FamilyAsyncNotifier<List<Entity>, EntityListConfig<Entity>>
// implements EntityManagerInterface<Entity>
{
  late int _offset;

  @override
  Future<List<Entity>> build(EntityListConfig<Entity> config) async {
    ref.onDispose(
      () => NitRepository.removeUpdatesListener<Entity>(
        config.customUpdatesListener ?? _updatesListener,
      ),
    );

    _offset = 0;

    final globalTimestamp = ref.watch(globalRefreshTriggerProvider);

    debugPrint(
      "Building entity list state for ${NitRepository.typeName<Entity>()} with timestamp $globalTimestamp",
    );

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
    // Collect all IDs from the incoming updates to identify what's new or changed
    final ids = wrappedModelUpdates.map((e) => e.modelId).toSet();

    // If a custom sorting method is provided, sort the updates accordingly
    if (arg.updatesSortingMethod != null) {
      wrappedModelUpdates.sort(
        (a, b) =>
            arg.updatesSortingMethod!(a.model as Entity, b.model as Entity),
      );
    }

    // Wait for the current state to be loaded from the future
    final current = await future;

    // Keep only those current items that are not affected by updates (matching modelId)
    final currentList = current
        .where((e) => !ids.contains((e as dynamic).id)) // filter by id match
        .cast<Entity>() // cast to the correct type
        .toList(); // convert to list

    final res = <Entity>[]; // Final merged result list

    int i = 0; // index for currentList
    int j = 0; // index for wrappedModelUpdates

    // Merge both lists in a single pass using sorted order if provided
    while (i < currentList.length || j < wrappedModelUpdates.length) {
      // Safely get current entity or null if out of bounds
      final Entity? currentEntity =
          i < currentList.length ? currentList[i] : null;

      // Safely get next update or null if out of bounds
      final ObjectWrapper? update =
          j < wrappedModelUpdates.length ? wrappedModelUpdates[j] : null;

      // If no more updates, just add remaining current entities
      if (update == null) {
        res.add(currentEntity!);
        i++;
        continue;
      }

      // If no more current entities, just add valid updates
      if (currentEntity == null) {
        if (!update.isDeleted && // not marked for deletion
            (arg.backendFilter == null || // passes backend filter
                arg.backendFilter!.filterUpdate(update.jsonSerialization))) {
          res.add(update.model as Entity);
        }
        j++;
        continue;
      }

      // Compare order: update vs current entity using sorting method (or default to insert update first)
      final cmp = arg.updatesSortingMethod
              ?.call(update.model as Entity, currentEntity) ??
          -1;

      if (cmp <= 0) {
        // Insert update if not deleted and passes filter
        if (!update.isDeleted &&
            (arg.backendFilter == null ||
                arg.backendFilter!.filterUpdate(update.jsonSerialization))) {
          res.add(update.model as Entity);
        }
        j++; // move to next update
      } else {
        res.add(currentEntity); // insert current entity
        i++; // move to next current
      }
    }

    // Push the merged list to state
    state = AsyncValue.data(res);
  }

  // void _updatesListener(List<ObjectWrapper> wrappedModelUpdates) async {
  //   final ids = wrappedModelUpdates.map((e) => e.modelId).toSet();

  //   if (arg.updatesSortingMethod != null) {
  //     wrappedModelUpdates
  //         .sort((a, b) => arg.updatesSortingMethod!(a.model, b.model));
  //   }

  //   return await future.then((currentState) async {
  //     currentState.removeWhere((e) => !ids.contains((e as dynamic).id));

  //     final res = <Entity>[];

  //     int currentIndex = 0;
  //     int updatesIndex = 0;

  //     while (currentIndex < currentState.length ||
  //         updatesIndex < wrappedModelUpdates.length) {
  //       if (arg.updatesSortingMethod == null ||
  //           arg.updatesSortingMethod!(wrappedModelUpdates[updatesIndex].model,
  //                   currentState[currentIndex]) <=
  //               0) {
  //         if (!wrappedModelUpdates[updatesIndex].isDeleted &&
  //             (arg.backendFilter == null ||
  //                 arg.backendFilter!.filterUpdate(
  //                     wrappedModelUpdates[updatesIndex].jsonSerialization))) {
  //           res.add(wrappedModelUpdates[updatesIndex].model as Entity);
  //         }

  //         updatesIndex++;
  //       } else {
  //         res.add(currentState[currentIndex++]);
  //       }
  //     }

  //     state = AsyncValue.data(res);

  //     // state = AsyncValue.data([
  //     //   ...wrappedModelUpdates
  //     //       .where((e) =>
  //     //           !e.isDeleted &&
  //     //           (arg.backendFilter == null ||
  //     //               arg.backendFilter!.filterUpdate(e.jsonSerialization)))
  //     //       .map((e) => e.model as Entity),
  //     //   ...value.where((e) => !ids.contains((e as dynamic).id)),
  //     // ]);
  //   });
  // }
}
