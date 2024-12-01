import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/src/repository/entity_list_config.dart';
import 'package:nit_app/src/repository/entity_manager_interface.dart';
import 'package:nit_tools_client/nit_tools_client.dart';
import 'repository.dart';

late final Caller nitToolsCaller;

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
  Future<List<int>> build(EntityListConfig arg) async {
    debugPrint("Building state for ${Entity.toString()}");

    return await nitToolsCaller.crud
        .getAll(className: Entity.toString(), filters: arg.backendFilters)
        .then((response) => ref.processApiResponse<List<int>>(response))
        .then((res) => res ?? []);
  }

  @override
  Future<bool> save(Entity model, int? modelId) async {
    return await future.then(
      (value) async => await nitToolsCaller.crud
          .saveModel(
            wrappedModel: ObjectWrapper.wrap(model: model),
          )
          .then((response) => ref.processApiResponse<int>(response))
          .then(
        (res) {
          if (res == null) return false;

          state = AsyncValue.data([res, ...value.whereNot((e) => e == res)]);
          debugPrint("Updated value = ${state.value}");
          return true;
        },
      ),
    );
  }

  Future<bool> delete(Entity model, int modelId) async {
    return await future.then(
      (value) async => await nitToolsCaller.crud
          .delete(
            wrappedModel: ObjectWrapper.wrap(model: model),
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
