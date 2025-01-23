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
    return await nitToolsCaller!.crud
        .getOneById(
          className: T.toString(),
          id: arg,
        )
        .then((response) => ref.processApiResponse<int>(response))
        .then((res) => res);
  }
}
