import 'package:nit_tools_client/nit_tools_client.dart';

class EntityManagerConfig {
  const EntityManagerConfig({
    this.backendFilters,
  });

  final List<NitBackendFilter>? backendFilters;
}
