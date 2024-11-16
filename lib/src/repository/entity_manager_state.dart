import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/src/repository/entity_manager_config.dart';
import 'package:nit_tools_client/nit_tools_client.dart';
import 'repository.dart';

late final Caller nitToolsCaller;

final entityManagerProviders = <Type,
    AsyncNotifierProviderFamily<EntityManagerState, List<int>,
        EntityManagerConfig>>{};

AsyncNotifierProviderFamily<EntityManagerState<T>, List<int>,
        EntityManagerConfig>
    entityManagerStateProvider<T extends SerializableModel>() {
  if (entityManagerProviders[T] == null) {
    entityManagerProviders[T] = AsyncNotifierProviderFamily<
        EntityManagerState<T>, List<int>, EntityManagerConfig>(
      EntityManagerState<T>.new,
    );
  }

  return entityManagerProviders[T] as AsyncNotifierProviderFamily<
      EntityManagerState<T>, List<int>, EntityManagerConfig>;
}

class EntityManagerState<T extends SerializableModel>
    extends FamilyAsyncNotifier<List<int>, EntityManagerConfig> {
  @override
  Future<List<int>> build(EntityManagerConfig arg) async {
    debugPrint("Building state for ${T.toString()}");

    return await nitToolsCaller.crud
        .getAll(className: T.toString(), filters: arg.backendFilters)
        .then((response) => ref.processApiResponse<List<int>, T>(response))
        .then((res) => res ?? []);
  }

  Future<bool> save(T model, int? modelId) async {
    return await future.then(
      (value) async => await nitToolsCaller.crud
          .saveModel(
            wrappedModel: ObjectWrapper(model: model, modelId: modelId),
          )
          .then((response) => ref.processApiResponse<int, T>(response))
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

  Future<bool> delete(T model, int modelId) async {
    return await future.then(
      (value) async => await nitToolsCaller.crud
          .delete(
            wrappedModel: ObjectWrapper(model: model, modelId: modelId),
          )
          .then((response) => ref.processApiResponse<bool, T>(response))
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
