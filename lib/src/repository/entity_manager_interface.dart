import 'package:serverpod_client/serverpod_client.dart';

abstract class EntityManagerInterface<Entity extends SerializableModel> {
  Future<bool> save(Entity model, int? modelId);
  Future<bool> delete(Entity model, int modelId);
}
