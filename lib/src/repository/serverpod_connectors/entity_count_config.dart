import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nit_tools_client/nit_tools_client.dart';

part 'entity_count_config.freezed.dart';

@freezed
class EntityCountConfig with _$EntityCountConfig {
  const factory EntityCountConfig({
    NitBackendFilter? backendFilter,
    // int? pageSize,
    Function(List<ObjectWrapper> wrappedModel)? customUpdatesListener,
  }) = _EntityCountConfig;

  // static const defaultConfig = EntityListConfig();
}
