import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nit_tools_client/nit_tools_client.dart';

part 'single_item_custom_provider_config.freezed.dart';

@freezed
class SingleItemCustomProviderConfig with _$SingleItemCustomProviderConfig {
  const factory SingleItemCustomProviderConfig({
    required List<NitBackendFilter> backendFilters,
  }) = _SingleItemCustomProviderConfig;
}
