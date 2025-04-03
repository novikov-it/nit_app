import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_ui_kit/nit_ui_kit.dart';

extension GenericFormsExtension on WidgetRef {
  NitGenericEntityManager<Entity>
      nitGenericEntityManager<Entity extends SerializableModel>() =>
          NitGenericEntityManager(
            saveAction: (model) async => await saveModel<Entity>(model)
                .then((id) => id != null ? readModel<Entity>(id) : null),
          );

  // NitGenericModelWrapper
  //     nitGenericFormWrapper<Entity extends SerializableModel>(
  //   Entity? model,
  // )
  //   final Map<String, dynamic> json = model?.toJson() ?? {};

  //   return NitGenericModelWrapper(
  //     initialData: json,
  //     saveAction: (updatedData) async =>
  //         null !=
  //         await saveModel<Entity>(
  //           NitToolsClient.protocol.deserializeByClassName(
  //             {
  //               'className': Entity.toString(),
  //               'data': Map.fromEntries(
  //                 [
  //                   ...json.entries,
  //                   ...updatedData.entries,
  //                 ],
  //               ),
  //             },
  //           ),
  //         ),
  //   );
  // }
}

class EntityManagerBlock<Entity extends SerializableModel,
        FormDescriptor extends NitGenericFormsFieldsEnum<Entity>>
    extends ConsumerWidget {
  const EntityManagerBlock({
    super.key,
    // required this.title,
    required this.fields,
    required this.listViewBuilder,
    // this.additionalDetailsTabs,
    // this.detailsRouteName,
    // this.detailsRoutePathParameter,
    this.customBackendConfig,
    this.defaultValuesProvider,
    this.allowDelete = true,
  });

  // final String title;
  final List<FormDescriptor> fields;
  final Widget Function({
    // Key? key,
    required int modelId,
  }) listViewBuilder;
  // final List<Widget>? additionalDetailsTabs;
  // final String? detailsRouteName;
  // final String? detailsRoutePathParameter;
  final EntityListConfig? customBackendConfig;
  final Future<Map<FormDescriptor, dynamic>> Function(WidgetRef ref)?
      defaultValuesProvider;
  final bool allowDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return ref.read(entityManagerStateProvider<Entity>()).when(
    final backendConfig = customBackendConfig ?? EntityListConfig.defaultConfig;
    final entityManager =
        ref.read(entityManagerStateProvider<Entity>()(backendConfig).notifier);

    Widget addButton(
            BuildContext context, EntityManagerState<Entity> entityManager) =>
        FilledButton(
          onPressed: () async => context.showBottomSheetOrDialog<Entity>(
            NitGenericForm<Entity, FormDescriptor>(
              fields: fields,
              // modelWrapper: ref.nitGenericFormWrapper<Entity>(null),
              model: null,
              entityManager: ref.nitGenericEntityManager<Entity>(),
              defaultValues: await defaultValuesProvider?.call(ref),
              // fields: (FormDescriptor as Enum).value,
            ),
          ),
          child: const Text('Добавить'),
        );

    return ref.watchEntityListState<Entity>(backendConfig: backendConfig).when(
          error: (error, stackTrace) =>
              const Text("Не удалось подгрузить данные"),
          loading: () => const CircularProgressIndicator(),
          data: (List<int> data) => Column(
            crossAxisAlignment: context.isMobile
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              if (!context.isMobile) addButton(context, entityManager),
              Expanded(
                child: ListView(
                  children: data
                      .map(
                        (modelId) => Card(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () async =>
                                    // detailsRouteName != null &&
                                    //         detailsRoutePathParameter != null
                                    //     ? context.pushNamed(
                                    //         detailsRouteName!,
                                    //         pathParameters: {
                                    //           detailsRoutePathParameter!:
                                    //               modelId.toString()
                                    //         },
                                    //       )
                                    // additionalDetailsTabs != null ? Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(scaffoldConstructor: sca,)))
                                    // :
                                    await context.showBottomSheetOrDialog(
                                  NitGenericForm<Entity, FormDescriptor>(
                                    fields: fields,
                                    model: ref.readModel<Entity>(modelId),
                                    entityManager:
                                        ref.nitGenericEntityManager(),
                                  ),
                                ),
                                icon: const Icon(Icons.edit),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: listViewBuilder(modelId: modelId),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              if (context.isMobile) addButton(context, entityManager),
            ],
          ),
        );
  }
}
