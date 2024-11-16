import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_tools_client/nit_tools_client.dart';

import 'entity_manager_state.dart';
import 'repository.dart';

final singleItemProviderFamilies =
    <Type, AsyncNotifierProviderFamily<SingleItemProviderState, int?, int>>{};

AsyncNotifierProviderFamily<SingleItemProviderState<T>, int?, int>
    singleItemProvider<T extends SerializableModel>() {
  if (singleItemProviderFamilies[T] == null) {
    singleItemProviderFamilies[T] =
        AsyncNotifierProviderFamily<SingleItemProviderState<T>, int?, int>(
      SingleItemProviderState<T>.new,
      // name: 'entityManagerProviders${T.toString()}',
      // debugGetCreateSourceHash:
      //     const bool.fromEnvironment('dart.vm.product')
      //         ? null
      //         : _$chatsRepositoryHash,
    );
  }

  return singleItemProviderFamilies[T]
      as AsyncNotifierProviderFamily<SingleItemProviderState<T>, int?, int>;
}

class SingleItemProviderState<T extends SerializableModel>
    extends FamilyAsyncNotifier<int?, int> {
  @override
  Future<int?> build(
    int arg,
  ) async {
    debugPrint("Getting single ${T.toString()} with id $arg");
    // final res = await ref.getAll<T>();
    return await nitToolsCaller.crud
        .getOne(
          className: T.toString(),
          id: arg,
        )
        .then((response) => ref.processApiResponse<int, T>(response))
        .then((res) => res);
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
