import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_client/serverpod_client.dart';
import 'entity_manager_state.dart';
import 'single_item_provider.dart';

final Map<Type, StateProviderFamily<dynamic, int>> repository = {};
// final Map<Type, StateProvider<Map<int, dynamic>>> objectPool = {};

StateProviderFamily<T?, int> initRepository<T>() {
  repository[T] = StateProvider.family<T?, int>(
      (ref, id) => null); // ref.watch(repository[T]!(id)) as T);

  // objectPool[T] = StateProvider<Map<int, T>>((ref) => {});

  return repository[T] as StateProviderFamily<T?, int>;
}

StateProviderFamily<T?, int> modelProvider<T>() {
  final rep = repository[T];

  if (rep == null) return initRepository<T>();

  return rep as StateProviderFamily<T?, int>;
}

extension WidgetRefRepositoryExtension on WidgetRef {
  T? watchModel<T extends SerializableModel>(int id) {
    final p = modelProvider<T>();

    final t = watch(p(id));

    return t;
  }

  // watch((id));
  T? readModel<T extends SerializableModel>(int id) =>
      read(modelProvider<T>()(id));

  AsyncValue<T?> watchEntityState<T extends SerializableModel>(int id) =>
      watch(singleItemProvider<T>()(id)).whenData(
          (value) => value == null ? null : watchModel<T>(value.modelId!));
  //(value) => value?.model as T);

  AsyncValue<List<int>> watchEntityListState<T extends SerializableModel>({
    bool Function(T model)? frontendFilter,
  }) =>
      watch(entityManagerStateProvider<T>()).whenData((data) =>
          (frontendFilter == null
                  ? data
                  : data.where((e) => frontendFilter(e.model as T)))
              .map((e) => e.modelId!)
              .toList());
}

extension RefRepositoryExtension on Ref {
  T? watchModel<T>(int id) => watch(modelProvider<T>()(id));
  T? readModel<T>(int id) => read(modelProvider<T>()(id));

  AsyncValue<List<int>> watchEntityState<T extends SerializableModel>(
          bool Function(T model)? frontendFilter) =>
      watch(entityManagerStateProvider<T>()).whenData((data) =>
          (frontendFilter == null
                  ? data
                  : data.where((e) => frontendFilter(e.model as T)))
              .map((e) => e.modelId!)
              .toList());

  // List<int> selectObjects<T>({
  //   bool Function(T model)? filter,
  // }) =>
  //     watch(objectPool[T]!)
  //         .entries
  //         .where((e) => filter == null || filter(e.value as T))
  //         .map((e) => e.key)
  //         .toList();
}

// extension RepositoryExtension on Ref {

// }

// final Map<Type, Map<int, StateProvider<dynamic>>> repository = {};

// extension WidgetRefRepositoryExtension on WidgetRef {
//   // model<T>(int id) =>
//   //     watch(modelProvider(ModelIdentifier(className: T.toString(), id: id)));

//   model<T>(int id) => watch(repository[T]![id]!);
// }

// extension RepositoryExtension on Ref {
//   updateRepository<T>(List<ObjectWrapper> newModels) {
//     if (repository[T] == null) repository[T] = {};

//     for (var e in newModels) {
//       if (repository[T]![e.modelId] == null) {
//         repository[T]![e.modelId!] = StateProvider<T>((ref) => e.model as T);
//       } else {
//         read(repository[T]![e.modelId!]!.notifier).state = e.model as T;
//       }
//     }
//   }
// }



// ProviderFamily<T, int> modelProvider<T>() => Provider.family<T, int>(
//     (ref, id) => ref.watch(repositoryStateProvider)[T]?[id] as T);

// class ModelIdentifier {
//   const ModelIdentifier({
//     required this.className,
//     required this.id,
//   });
//   final String className;
//   final int id;
// }

// final repository = {...[Robot].map((e) => MapEntry(e, StateProvider<));

// final Map<Type, StateProvider<Map<int, dynamic>>> repository = {};

// initRepository<T>() {
//   repository[T] = StateProvider<Map<int, dynamic>>((ref) => {});
// }

// AutoDisposeAsyncNotifierProvider<EntityManagerState, List<int>>
//     entityManagerStateProvider<T extends SerializableModel>() =>
//         AutoDisposeAsyncNotifierProvider<EntityManagerState, List<int>>(
//             EntityManagerState<T>.new);

// class EntityManagerState<T extends SerializableModel>
//     extends AutoDisposeAsyncNotifier<List<int>> {
//   @override
//   Future<List<int>> build() async {
//     print("Building state for ${T.toString()}");
//     final res = await ref.getAll<T>();
//     print("Api manager returned: $res");
//     return [1];
//   }
// }



// initRepository<T>() {
//   repository[T] = StateProvider<Map<int, dynamic>>((ref) => {});
// }

// StateProviderFamily<dynamic,
//     ModelIdentifier> modelProvider = StateProvider.family<dynamic,
//         ModelIdentifier>(
//     (ref, modelIdentifier) =>
//         null //JUST - мы не должны оказаться в ситуации, когда запрашивается стейт, до обновления
//     );



// StateProvider<Map<int, T>> repositoryProvider<T>() =>
//     StateProvider<Map<int, T>>(
//       (ref) => <int, T>{},
//     );

// StateProvider<Map<int, T>> repositoryProvider =>
//     Provider.family<>(
//       (ref) => <int, T>{},
//     );

// extension RepositoryExtension on Ref {
//   updateRepository<T>(List<ObjectWrapper> newModels) {
//     read(repositoryProvider<T>().notifier).state = {
//       ...read(repositoryProvider<T>()),
//       ...Map.fromEntries(
//         newModels.map(
//           (e) => MapEntry(
//             e.modelId!, // JUST - апдейт вызывается только для сущностей, полученных с бэка, у которых обязательно будет id заполненный
//             e.model as T,
//           ),
//         ),
//       )
//     };

//     final test = read(repositoryProvider<T>());
//     print(test);
//   }
// }





// @ProviderFor(PreloadState)
// final repositoryStateProvider =
//     AutoDisposeAsyncNotifierProvider<PreloadState, PreloadData>.internal(
//   PreloadState.new,
//   name: r'preloadStateProvider',
//   debugGetCreateSourceHash:
//       const bool.fromEnvironment('dart.vm.product') ? null : _$preloadStateHash,
//   dependencies: const <ProviderOrFamily>[],
//   allTransitiveDependencies: const <ProviderOrFamily>{},
// );

// typedef _$PreloadState = AutoDisposeAsyncNotifier<PreloadData>;

// extension ModelExtension on WidgetRef {

//   T watchModel<T>(int id) => wa

// }

/// Business logic state for the Appointment.
// @Riverpod(keepAlive: true)
// class Repository extends _$Repository {
//   @override
//   Map<int, SerializableModel> build(Type type) {
//     return <int, SerializableModel>{};
//   }

//   updateItems(List<ObjectWrapper> newModels) {
//     // TODO: добавить проверку соответствия типов
//     state = {
//       ...state,
//       ...Map.fromEntries(
//         newModels.map(
//           (e) => MapEntry(e.modelId, e.model),
//         ),
//       )
//     };
//   }

//   // updateItem(Consultation updatedModel) async {
//   //   await future.then((value) {
//   //     state = AsyncValue.data(
//   //       [
//   //         updatedModel,
//   //         ...value.where((e) => e.id != updatedModel.id),
//   //       ],
//   //     );
//   //   });
//   // }
// }
