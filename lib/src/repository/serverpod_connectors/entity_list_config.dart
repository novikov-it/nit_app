import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nit_tools_client/nit_tools_client.dart';

part 'entity_list_config.freezed.dart';

@freezed
class EntityListConfig with _$EntityListConfig {
  const factory EntityListConfig({
    NitBackendFilter? backendFilter,
    Function(ObjectWrapper wrappedModel)? customUpdatesListener,
  }) = _EntityListConfig;

  // static const defaultConfig = EntityListConfig();
}
