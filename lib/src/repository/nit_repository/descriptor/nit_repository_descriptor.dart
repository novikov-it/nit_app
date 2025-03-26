// class ForeignKeyDescriptor<K> {
//   const ForeignKeyDescriptor({
//     required this.fieldName,
//   });

//   final String fieldName;
// }

import 'package:nit_app/nit_app.dart';

class NitRepositoryDescriptor<T extends SerializableModel, K> {
  const NitRepositoryDescriptor({
    // required this.className,
    required this.fieldName,
  });

  String get className => T.toString();
  final String fieldName;

  init() => NitRepository.addRepositoryDescriptor<T, K>(this);
}
