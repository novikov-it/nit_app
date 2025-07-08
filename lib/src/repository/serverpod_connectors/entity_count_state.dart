import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';

import 'entity_count_config.dart';

final entityCountStateProviders = <Type,
    AsyncNotifierProviderFamily<EntityCountState, int, EntityCountConfig>>{};

AsyncNotifierProviderFamily<EntityCountState<T>, int, EntityCountConfig>
    entityCountStateProvider<T extends SerializableModel>() {
  if (entityCountStateProviders[T] == null) {
    entityCountStateProviders[T] = AsyncNotifierProviderFamily<
        EntityCountState<T>, int, EntityCountConfig>(
      EntityCountState<T>.new,
    );
  }

  return entityCountStateProviders[T] as AsyncNotifierProviderFamily<
      EntityCountState<T>, int, EntityCountConfig>;
}

class EntityCountState<Entity extends SerializableModel>
    extends FamilyAsyncNotifier<int, EntityCountConfig>
// implements EntityManagerInterface<Entity>
{
  @override
  Future<int> build(EntityCountConfig config) async {
    ref.onDispose(
      () => NitRepository.removeUpdatesListener<Entity>(
        config.customUpdatesListener ?? _updatesListener,
      ),
    );

    final globalTimestamp = ref.watch(globalRefreshTriggerProvider);

    debugPrint(
      "Building entity count state for ${NitRepository.typeName<Entity>()} with timestamp $globalTimestamp",
    );

    final result = await nitToolsCaller!.nitCrud
        // TODO: Изменить, toString() не работает на Web release из-за minification
        .getCount(
          className: NitRepository.typeName<Entity>(),
          filter: arg.backendFilter,
        )
        .then(
          (response) => ref.processApiResponse<int>(
            response,
            updateListeners: false,
          ),
        );

    NitRepository.addUpdatesListener<Entity>(
      config.customUpdatesListener ?? _updatesListener,
    );

    return result!;
  }

  void _updatesListener(List<ObjectWrapper> wrappedModelUpdates) async {
    final filteredUpdates = wrappedModelUpdates
        .where((e) => (arg.backendFilter == null ||
            arg.backendFilter!.filterUpdate(e.jsonSerialization)))
        .toList();

    return await future.then((value) async {
      state = AsyncValue.data(value +
          filteredUpdates.where((e) => !e.isDeleted).length -
          filteredUpdates.where((e) => e.isDeleted).length);
    });
  }
}
