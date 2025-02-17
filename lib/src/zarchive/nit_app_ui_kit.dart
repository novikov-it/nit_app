// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gap/gap.dart';

// // import 'package:collection/collection.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:flutter_svg/svg.dart';
// // import 'package:go_router/go_router.dart';
// import 'package:nit_riverpod_notifications/nit_riverpod_notifications.dart';
// import 'package:skeletonizer/skeletonizer.dart';
// // import 'package:nit_router/nit_router.dart';

// import 'nit_app_build_context_extension.dart';

// part 'ui_kit_parts/nit_dialog_layout.dart';
// // part 'ui_kit_parts/nit_navigation_bar.dart';

// extension NitAsyncValueExtension<T> on AsyncValue<T> {
//   Widget nitWhen({
//     required Widget errorWidget,
//     required T loadingValue,
//     required Widget Function(T value) childBuilder,
//     // bool errorOnNull = false,
//   }) =>
//       when(
//         data: (data) =>
//             // errorOnNull && data == null ? errorWidget :
//             childBuilder(data),
//         error: (error, stackTrace) {
//           print(error);
//           print(stackTrace);
//           return errorWidget;
//         },
//         loading: () => Skeletonizer(
//           child: childBuilder(loadingValue),
//         ),
//       );
// }
