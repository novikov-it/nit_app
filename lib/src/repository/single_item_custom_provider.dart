import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/src/repository/single_item_custom_provider_config.dart';
import 'package:nit_tools_client/nit_tools_client.dart';

import 'entity_manager_state.dart';
import 'repository.dart';

final singleItemCustomProviderFamilies = <Type,
    AsyncNotifierProviderFamily<SingleItemCustomProviderState, int?,
        SingleItemCustomProviderConfig>>{};

AsyncNotifierProviderFamily<SingleItemCustomProviderState<T>, int?,
        SingleItemCustomProviderConfig>
    singleItemCustomProvider<T extends SerializableModel>() {
  if (singleItemCustomProviderFamilies[T] == null) {
    singleItemCustomProviderFamilies[T] = AsyncNotifierProviderFamily<
        SingleItemCustomProviderState<T>, int?, SingleItemCustomProviderConfig>(
      SingleItemCustomProviderState<T>.new,
      // name: 'entityManagerProviders${T.toString()}',
      // debugGetCreateSourceHash:
      //     const bool.fromEnvironment('dart.vm.product')
      //         ? null
      //         : _$chatsRepositoryHash,
    );
  }

  return singleItemCustomProviderFamilies[T] as AsyncNotifierProviderFamily<
      SingleItemCustomProviderState<T>, int?, SingleItemCustomProviderConfig>;
}

class SingleItemCustomProviderState<T extends SerializableModel>
    extends FamilyAsyncNotifier<int?, SingleItemCustomProviderConfig> {
  @override
  Future<int?> build(
    SingleItemCustomProviderConfig arg,
  ) async {
    debugPrint("Getting single ${T.toString()} with id $arg");
    // final res = await ref.getAll<T>();
    return await nitToolsCaller.crud
        .getOneCustom(
          className: T.toString(),
          filters: arg.backendFilters,
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
