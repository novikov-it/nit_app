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

  NitBackendFilter<T> greaterThan(
    T value, {
    bool negate = false,
  }) =>
      (T != int && T != double && T != DateTime)
          ? throw UnsupportedError(
              'Unsupported value type, comparison filters are supported for int or double values only (currently)',
            )
          : NitBackendFilter<T>.value(
              type: NitBackendFilterType.greaterThan,
              fieldName: name,
              fieldValue: value,
              negate: negate,
            );

  NitBackendFilter<T> greaterThanOrEquals(
    T value, {
    bool negate = false,
  }) =>
      (T != int && T != double && T != DateTime)
          ? throw UnsupportedError(
              'Unsupported value type, comparison filters are supported for int or double values only (currently)',
            )
          : NitBackendFilter<T>.value(
              type: NitBackendFilterType.greaterThanOrEquals,
              fieldName: name,
              fieldValue: value,
              negate: negate,
            );

  NitBackendFilter<T> lessThan(
    T value, {
    bool negate = false,
  }) =>
      (T != int && T != double && T != DateTime)
          ? throw UnsupportedError(
              'Unsupported value type, comparison filters are supported for int or double values only (currently)',
            )
          : NitBackendFilter<T>.value(
              type: NitBackendFilterType.lessThan,
              fieldName: name,
              fieldValue: value,
              negate: negate,
            );

  NitBackendFilter<T> lessThanOrEquals(
    T value, {
    bool negate = false,
  }) =>
      (T != int && T != double && T != DateTime)
          ? throw UnsupportedError(
              'Unsupported value type, comparison filters are supported for int or double values only (currently)',
            )
          : NitBackendFilter<T>.value(
              type: NitBackendFilterType.lessThanOrEquals,
              fieldName: name,
              fieldValue: value,
              negate: negate,
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
