import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_tools_client/nit_tools_client.dart';

import 'entity_manager_state.dart';
import 'repository.dart';
import 'single_item_custom_provider_config.dart';

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
    return await nitToolsCaller!.crud
        .getOneCustom(
          className: T.toString(),
          filters: arg.backendFilters,
        )
        .then((response) => ref.processApiResponse<int>(response))
        .then((res) => res);
  }
}
