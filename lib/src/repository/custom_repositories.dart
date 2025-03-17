import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';
// import 'package:nit_app/nit_app.dart';

class RepositoryDescriptor<T extends SerializableModel> {
  const RepositoryDescriptor({
    required this.className,
    required this.fieldName,
  });

  final String className;
  final String fieldName;

  static final Map<RepositoryDescriptor,
      StateProviderFamily<SerializableModel?, int>> _customRepository = {};
  static final Map<String, List<RepositoryDescriptor>> _customDescriptors = {};

  // static Iterable<Refreshable<StateController<SerializableModel?>>>
  //     getCustomRepositories(ObjectWrapper e) {
  //   if (_customDescriptors.containsKey(e.nitMappingClassname)) {
  //     return _customDescriptors[e.nitMappingClassname]!.map((d) =>
  //         (_customRepository[d] ?? initCustomRepository(d))(e.modelId!)
  //             .notifier);
  //     // for (var d in !) {
  //     //   if (_customRepository[d] == null) {
  //     //     debugPrint(
  //     //         "Initializing repo for ${d.className} using ${d.fieldName}");
  //     //     initCustomRepository(d);
  //     //   }
  //     //   read(_repository[e.nitMappingClassname]!(e.modelId!).notifier).state =
  //     //       e.model;
  //     // }
  //   } else {
  //     return [];
  //   }
  // }

  static List<RepositoryDescriptor> getCustomDescriptors(String className) =>
      _customDescriptors[className] ?? <RepositoryDescriptor>[];

  static StateProviderFamily<SerializableModel?, int> getCustomRepository(
          RepositoryDescriptor descriptor) =>
      _customRepository[descriptor] ?? initCustomRepository(descriptor);

  static setupCustomRepositories(
    List<RepositoryDescriptor> descriptors,
  ) {
    for (var d in descriptors) {
      if (_customDescriptors[d.className] == null) {
        _customDescriptors[d.className] = [];
      }

      _customDescriptors[d.className]!.add(d);
    }
  }

  static StateProviderFamily<SerializableModel?, int> initCustomRepository(
          RepositoryDescriptor descriptor) =>
      _customRepository[descriptor] =
          StateProvider.family<SerializableModel?, int>((ref, id) => null);

  //   return _customRepository[descriptor]
  //       as StateProviderFamily<SerializableModel?, int>;
  // }

  static StateProviderFamily<SerializableModel?, int> customModelProvider(
      RepositoryDescriptor descriptor) {
    final rep = _customRepository[descriptor];

    if (rep == null) return initCustomRepository(descriptor);

    return rep;
  }
}
