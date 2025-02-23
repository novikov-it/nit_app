class DefaultModelsRepository {
  static const int mockModelId = -273;

  static final repository = <String, dynamic>{};

  // static initRepository(List<MapEntry<Type, dynamic>> modelsMapEntries) {
  //   for (var m in modelsMapEntries) {
  //     repository[m.key.toString()] = m.value;
  //   }
  // }

  static put<T>(T model) => repository[T.toString()] = model;

  static T get<T>() {
    final t = repository[T.toString()];
    if (t == null) {
      throw UnimplementedError(
          "Default Models Repository doesn't contain a model of type $T");
    }
    return t as T;
  }
}
