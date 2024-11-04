import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_client/serverpod_client.dart';

import 'endpoint_crud.dart';
import 'object_wrapper.dart';
import 'repository.dart';

final entityManagerProviders =
    <Type, AsyncNotifierProvider<EntityManagerState, List<ObjectWrapper>>>{};

AsyncNotifierProvider<EntityManagerState<T>, List<ObjectWrapper>>
    entityManagerStateProvider<T extends SerializableModel>() {
  if (entityManagerProviders[T] == null) {
    entityManagerProviders[T] =
        AsyncNotifierProvider<EntityManagerState<T>, List<ObjectWrapper>>(
      EntityManagerState<T>.new,
      // name: 'entityManagerProviders${T.toString()}',
      // debugGetCreateSourceHash:
      //     const bool.fromEnvironment('dart.vm.product')
      //         ? null
      //         : _$chatsRepositoryHash,
    );
  }

  return entityManagerProviders[T]
      as AsyncNotifierProvider<EntityManagerState<T>, List<ObjectWrapper>>;
}

late final EndpointCrud crud;

class EntityManagerState<T extends SerializableModel>
    extends AsyncNotifier<List<ObjectWrapper>> {
  @override
  Future<List<ObjectWrapper>> build() async {
    debugPrint("Building state for ${T.toString()}");
    // final res = await ref.getAll<T>();
    // await Future.delayed(Duration(seconds: 3));
    final res = await crud.getAll(className: T.toString());
    debugPrint("Entity manager received: $res from API");
    if (res.isEmpty) return [];

    _updateRepository(res);

    return res;
  }

  _updateRepository(List<ObjectWrapper> newModels) {
    if (repository[T] == null) {
      debugPrint("Initializing repo for $T");
      initRepository<T>();
    }

    // read(objectPool[T]!.notifier).state = Map.fromEntries({
    //   ...read(objectPool[T]!).entries,
    //   ...newModels.map(
    //     (e) => MapEntry(e.modelId!, e.model),
    //   )
    // });

    for (var e in newModels) {
      // if (read(repository[T]!(e.modelId!)) == null) {
      ref.read(repository[T]!(e.modelId!).notifier).state = e.model as T;
      // } else {
      //   read(repository[T]!(e.modelId!).notifier).state = e.model as T;
      // }
    }
  }

  Future<bool> save(T model, int? modelId) async {
    return await future.then((value) async {
      final res = await crud.saveModel(
        wrappedModel: ObjectWrapper(model: model, modelId: modelId),
      );

      if (res == null) return false;

      _updateRepository([res]);

      // return res.modelId;
      // final id = await ref.saveModel<T>(
      //   model,
      //   modelId,
      // );

      // if (id != null) {
      state = AsyncValue.data(
          [res, ...value.whereNot((e) => e.modelId == res.modelId)]);
      debugPrint("Updated value = ${state.value}");
      return true;
      // } else {
      //   return false;
      // }
    });
  }

  Future<bool> delete(T model, int modelId) async {
    return await future.then((value) async {
      if (await crud.delete(
        wrappedModel: ObjectWrapper(model: model, modelId: modelId),
      )
          //   await ref.deleteModel<T>(
          //   model,
          //   modelId,
          // )

          ) {
        state =
            AsyncValue.data([...value.whereNot((e) => e.modelId == modelId)]);
        debugPrint("Updated value = ${state.value}");
        return true;
      } else {
        return false;
      }
    });
  }
}

// (entityManagerProviders[T] ??
//     (
//       entityManagerProviders[T] = AutoDisposeAsyncNotifierProvider<
//           EntityManagerState<T>, List<int>>(
//         EntityManagerState<T>.new,
//         name: 'entityManagerProviders${T.toString()}',
//         // debugGetCreateSourceHash:
//         //     const bool.fromEnvironment('dart.vm.product')
//         //         ? null
//         //         : _$chatsRepositoryHash,
//       ),
//     ))
// // as AsyncNotifierProvider<EntityManagerState<T>, List<int>>
// ;

// class RobotManagerState extends AutoDisposeAsyncNotifier<List<int>> {
//   @override
//   Future<List<int>> build() async {
//     print("Building state for robot");
//     final res = await ref.getAll<Robot>();
//     print(res);
//     return res;
//   }

//   Future<bool> save(Robot model) async {
//     return null != await ref.saveModel<Robot>(model);
//   }
// }
