import 'package:nit_app/nit_app.dart';

class NitDefaultModelsRepository {
  static const int mockModelId = 0;

  static final repository = <String, dynamic>{};

  // static initRepository(List<MapEntry<Type, dynamic>> modelsMapEntries) {
  //   for (var m in modelsMapEntries) {
  //     repository[m.key.toString()] = m.value;
  //   }
  // }

  static String _setupRepository<T extends SerializableModel>(T object) {
    final className =
        NitToolsClient.protocol.getClassNameForObject(object)!.split('.').last;
    NitRepository.setupRepository<T>(className);
    return className;
  }

  static putSerializableModel<T extends SerializableModel>(T model) =>
      repository[_setupRepository(model)] = model;

  static putOtherObject<T>(T model) {
    assert(model is! SerializableModel);
    return repository[T.toString()] = model;
  }

  static T get<T>() {
    final t = repository[NitRepository.maybeTypeName<T>() ?? T.toString()];
    if (t == null) {
      throw UnimplementedError(
          "Default Models Repository doesn't contain a model of type $T");
    }
    return t as T;
  }
}
