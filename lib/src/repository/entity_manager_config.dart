import 'package:nit_tools_client/nit_tools_client.dart';

class EntityListConfig {
  const EntityListConfig({
    this.backendFilters,
  });

  final List<NitBackendFilter>? backendFilters;
}
