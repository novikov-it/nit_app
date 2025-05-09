import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';

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
    debugPrint("Getting single ${NitRepository.typeName<T>()} with id $arg");
    // final res = await ref.getAll<T>();
    // NitRepository.ensureDefaultDescriptor<T>();

    return await nitToolsCaller!.nitCrud
        .getOneCustom(
          className: NitRepository.typeName<T>(),
          filters: arg.backendFilters,
        )
        .then((response) => ref.processApiResponse<int>(response))
        .then((res) => res);
  }
}
