// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nit_ui_kit/nit_ui_kit.dart';
// import '../database_config.dart';

// class NitDatabasePage extends ConsumerStatefulWidget {
//   const NitDatabasePage({
//     super.key,
//     required this.scaffoldConstructor,
//     required this.pageDescriptors,
//   });

//   final Function({
//     required String pageTitle,
//     required Widget body,
//   }) scaffoldConstructor;
//   final List<DatabasePageDescriptor> pageDescriptors;

//   @override
//   ConsumerState<NitDatabasePage> createState() => _State();
// }

// class _State extends ConsumerState<NitDatabasePage> {
//   late DatabasePageDescriptor _selectedPage = widget.pageDescriptors.first;

//   @override
//   Widget build(BuildContext context) {
//     return widget.scaffoldConstructor(
//       pageTitle: _selectedPage.pageDescriptor.pageTitle,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Padding(
//           //   padding: const EdgeInsets.only(bottom: 4.0),
//           //   child: Text(
//           //     // "База данных: ${_selectedPage.pageDescriptor.pageTitle?.toLowerCase()}",
//           //     _selectedPage.pageDescriptor.pageTitle,
//           //   ),
//           // ),
//           if (context.isMobile)
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                   bottom: 8,
//                 ),
//                 child: _selectedPage.pageDescriptor.entityManagerBlock,
//               ),
//             ),
//           Wrap(
//             spacing: 12,
//             crossAxisAlignment: WrapCrossAlignment.center,
//             children: [
//               const Text("Другие разделы:"),
//               ...widget.pageDescriptors.where((e) => e != _selectedPage).map(
//                   (e) => ElevatedButton(
//                         onPressed: () => setState(() {
//                           _selectedPage = e;
//                         }),
//                         child: Text(e.pageDescriptor.pageTitle),
//                       )
//                   // InkWell(
//                   //   onTap: () => setState(() {
//                   //     _selectedPage = e;
//                   //   }),
//                   //   child: Card(
//                   //     color: _selectedPage == e
//                   //         ? context.colorScheme.primaryContainer
//                   //         : context.colorScheme.secondaryContainer,
//                   //     child: Padding(
//                   //       padding: const EdgeInsets.all(8.0),
//                   //       child: Text(
//                   //         '${_selectedPage == e ? '✅ ' : ''}${e.pageDescriptor.pageTitle ?? '???'}',
//                   //         style: _selectedPage == e
//                   //             ? context.textTheme.bodyMedium!
//                   //                 .copyWith(fontWeight: FontWeight.w700)
//                   //             : null,
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                   ),
//             ],
//           ),
//           if (!context.isMobile)
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                   top: 8,
//                 ),
//                 child: _selectedPage.pageDescriptor.entityManagerBlock,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
