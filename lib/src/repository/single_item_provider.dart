import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_tools_client/nit_tools_client.dart';

import 'entity_manager_state.dart';
import 'repository.dart';

final singleItemProviderFamilies = <Type,
    AsyncNotifierProviderFamily<SingleItemProviderState, ObjectWrapper?,
        int>>{};

AsyncNotifierProviderFamily<SingleItemProviderState<T>, ObjectWrapper?, int>
    singleItemProvider<T extends SerializableModel>() {
  if (singleItemProviderFamilies[T] == null) {
    singleItemProviderFamilies[T] = AsyncNotifierProviderFamily<
        SingleItemProviderState<T>, ObjectWrapper?, int>(
      SingleItemProviderState<T>.new,
      // name: 'entityManagerProviders${T.toString()}',
      // debugGetCreateSourceHash:
      //     const bool.fromEnvironment('dart.vm.product')
      //         ? null
      //         : _$chatsRepositoryHash,
    );
  }

  return singleItemProviderFamilies[T] as AsyncNotifierProviderFamily<
      SingleItemProviderState<T>, ObjectWrapper?, int>;
}

class SingleItemProviderState<T extends SerializableModel>
    extends FamilyAsyncNotifier<ObjectWrapper?, int> {
  @override
  Future<ObjectWrapper?> build(
    int arg,
  ) async {
    debugPrint("Getting single ${T.toString()} with id $arg");
    // final res = await ref.getAll<T>();
    final res = await crud.getOne(
      className: T.toString(),
      id: arg,
    );

    debugPrint("Entity manager received: $res from API");

    if (res != null) _updateRepository([res]);

    return res;
  }

  _updateRepository(List<ObjectWrapper> newModels) {
    if (repository[T] == null) {
      debugPrint("Initializing repo for $T");
      initRepository<T>();
    }

    for (var e in newModels) {
      // if (read(repository[T]!(e.modelId!)) == null) {
      ref.read(repository[T]!(e.modelId!).notifier).state = e.model as T;
      // } else {
      //   read(repository[T]!(e.modelId!).notifier).state = e.model as T;
      // }
    }
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
