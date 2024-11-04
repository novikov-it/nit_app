import 'package:serverpod_auth_client/serverpod_auth_client.dart';

class ObjectWrapper implements SerializableModel {
  static late SerializationManager protocol;

  ObjectWrapper({
    required this.model,
    this.modelId,
    // this.entities,
  }) : className = protocol.getClassNameForObject(model) ?? 'unknown';

  final String className;
  final SerializableModel model;
  final int? modelId;
  // final List<SerializableModel>? entities;

  factory ObjectWrapper.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ObjectWrapper(
      modelId: jsonSerialization['data']['id'],
      model: protocol.deserializeByClassName(jsonSerialization),
      // value: jsonSerialization['value'] as T,
      // warning: jsonSerialization['warning'] as String,
      // error: jsonSerialization['error'] as String,
      // entities: (jsonSerialization['entities'] as List)
      //         .map((e) => T.fromJson((e as Map<String, dynamic>)))
      //         .toList(),
    );
  }

  @override
  toJson() {
    return {
      'className': protocol.getClassNameForObject(model),
      'data': model.toJson(),
      // if (entities != null)
      //   'entities': entities?.toJson(valueToJson: (v) => v.toJson()),
    };
  }
}
