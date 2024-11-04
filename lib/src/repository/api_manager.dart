// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:serverpod_auth_client/serverpod_auth_client.dart';
// import 'endpoint_crud.dart';
// import 'object_wrapper.dart';
// import 'repository.dart';

// extension ApiManagerExtension on Ref {
//   // Future<List<int>> getAll<T>(
//   //     // {
//   //     // bool Function(T model)? frontendFilter,
//   //     // }
//   //     ) async {
//   //   final res = await crud.getAll(className: T.toString());

//   //   if (res.isEmpty) return [];

//   //   updateRepository<T>(res);

//   //   // final test = read(repositoryProvider<T>());
//   //   // print(test);

//   //   return
//   //       // (frontendFilter != null
//   //       //         ? res.where((wrapper) => frontendFilter(wrapper.model as T))
//   //       //         : res)
//   //       res.map((e) => e.modelId!).toList();
//   // }

//   // Future<int?> saveModel<T extends SerializableModel>(
//   //     T model, int? modelId) async {
//   //   // print('Class is ${T.toString()}');
//   //   final res = await crud.saveModel(
//   //       wrappedModel: ObjectWrapper(model: model, modelId: modelId));

//   //   if (res == null) return null;

//   //   updateRepository<T>([res]);

//   //   return res.modelId;
//   // }

//   // Future<bool> deleteModel<T extends SerializableModel>(
//   //     T model, int? modelId) async {
//   //   // TODO:
//   //   return await crud.delete(
//   //       wrappedModel: ObjectWrapper(model: model, modelId: modelId));

//   //   // if (res) return null;

//   //   // updateRepository<T>([res]);

//   //   // return res.modelId;
//   // }

//   // Future<List<int>> getAllByType(Type type) async {
//   //   final res = await client.crud.getAll(className: type.toString());

//   //   if (res.isEmpty) return [];

//   //   read(repositoryProvider(type).notifier).updateItems(res);

//   //   return res.map((e) => e.modelId).toList();
//   // }
// }
