// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nit_app/nit_app.dart';
// import 'package:nit_ui_kit/nit_ui_kit.dart';

// extension GenericFormsExtension on WidgetRef {
//   NitGenericEntityManager<Entity>
//       nitGenericEntityManager<Entity extends SerializableModel>({
//     bool allowDelete = false,
//   }) =>
//           NitGenericEntityManager(
//             saveAction: (model) async => await saveModel<Entity>(model)
//                 .then((id) => id != null ? readModel<Entity>(id) : null),
//             deleteAction: allowDelete
//                 ? (model) async => await deleteModel<Entity>(model)
//                 : null,
//           );
// }

// class EntityManagerBlock<Entity extends SerializableModel,
//         FormDescriptor extends NitGenericFormsFieldsEnum<Entity>>
//     extends ConsumerWidget {
//   const EntityManagerBlock({
//     super.key,
//     required this.fields,
//     required this.listViewBuilder,
//     this.customBackendFilter,
//     this.defaultValuesProvider,
//     required this.allowDelete,
//   });

//   final List<FormDescriptor> fields;
//   final Widget Function({
//     required int modelId,
//   }) listViewBuilder;

//   final NitBackendFilter? customBackendFilter;
//   final Future<Map<FormDescriptor, dynamic>> Function(WidgetRef ref)?
//       defaultValuesProvider;
//   final bool allowDelete;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     Widget addButton(BuildContext context) => FilledButton(
//           onPressed: () async => context.showBottomSheetOrDialog<Entity>(
//             NitGenericForm<Entity, FormDescriptor>(
//               fields: fields,
//               model: null,
//               entityManager: ref.nitGenericEntityManager<Entity>(),
//               defaultValues: await defaultValuesProvider?.call(ref),
//             ),
//           ),
//           child: const Text('Добавить'),
//         );

//     return ref
//         .watchEntityListIdsAsync<Entity>(backendFilter: customBackendFilter)
//         .when(
//           error: (error, stackTrace) =>
//               const Text("Не удалось подгрузить данные"),
//           loading: () => const CircularProgressIndicator(),
//           data: (List<int> data) => Column(
//             crossAxisAlignment: context.isMobile
//                 ? CrossAxisAlignment.end
//                 : CrossAxisAlignment.start,
//             children: [
//               if (!context.isMobile) addButton(context),
//               Expanded(
//                 child: ListView(
//                   children: data
//                       .map(
//                         (modelId) => Card(
//                           child: Row(
//                             children: [
//                               IconButton(
//                                 onPressed: () async =>
//                                     await context.showBottomSheetOrDialog(
//                                   NitGenericForm<Entity, FormDescriptor>(
//                                     fields: fields,
//                                     model: ref.readModel<Entity>(modelId),
//                                     entityManager: ref.nitGenericEntityManager(
//                                       allowDelete: allowDelete,
//                                     ),
//                                   ),
//                                 ),
//                                 icon: const Icon(Icons.edit),
//                               ),
//                               Expanded(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: listViewBuilder(modelId: modelId),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       )
//                       .toList(),
//                 ),
//               ),
//               if (context.isMobile) addButton(context),
//             ],
//           ),
//         );
//   }
// }
