import 'package:nit_tools_client/nit_tools_client.dart';

mixin BackendFilterMethodsMixin<T> on Enum {
  NitBackendFilter<T> equals(
    T? value, {
    bool negate = false,
  }) =>
      NitBackendFilter<T>.value(
        type: NitBackendFilterType.equals,
        fieldName: name,
        fieldValue: value,
        negate: negate,
      );

  NitBackendFilter<int> intMath(
    NitBackendFilterType type,
    int value, {
    bool negate = false,
  }) =>
      [
        NitBackendFilterType.greaterThan,
        NitBackendFilterType.greaterThanOrEquals,
        NitBackendFilterType.lessThan,
        NitBackendFilterType.lessThanOrEquals,
      ].contains(type)
          ? NitBackendFilter<int>.value(
              type: type,
              fieldName: name,
              fieldValue: value,
              negate: negate,
            )
          : throw UnsupportedError(
              'Unsupported filter type, please, choose from greaterThan, greaterThanOrEquals, lessThan,lessThanOrEquals',
            );

  NitBackendFilter<String> like(
    String value, {
    bool negate = false,
  }) =>
      NitBackendFilter.value(
        type: NitBackendFilterType.like,
        fieldName: name,
        fieldValue: value,
        negate: negate,
      );

  NitBackendFilter<String> ilike(
    String value, {
    bool negate = false,
  }) =>
      NitBackendFilter.value(
        type: NitBackendFilterType.ilike,
        fieldName: name,
        fieldValue: value,
        negate: negate,
      );

  // NitBackendFilter<T> equals(
  //   T? value, {
  //   bool negate = false,
  // }) =>
  //     NitBackendFilter.equals(
  //       fieldName: name,
  //       equalsTo: value,
  //       negate: negate,
  //     );
}

// abstract class NitBackendFilterEnum {
//   const NitBackendFilterEnum(
//     this.descriptor,
//   );

//   final NBFD descriptor;
// }

// class NBFD<T> {
//   const NBFD({
//     this.type = NitBackendFilterType.equals,
//   });

//   final NitBackendFilterType type;

//   NitBackendFilter<T> prepareFilter({
//     required String fieldName,
//     required T? value,
//     bool negate = false,
//   }) =>
//       switch (type) {
//         NitBackendFilterType.equals => NitBackendFilter.equals(
//             fieldName: fieldName,
//             equalsTo: value,
//             negate: negate,
//           ),
//         _ => throw UnimplementedError(
//             'Filter type $type is not implemented for field $fieldName'),
//       };
// }
