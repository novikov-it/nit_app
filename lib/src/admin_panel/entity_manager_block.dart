import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_ui_kit/nit_ui_kit.dart';

class EntityManagerBlock<Entity extends SerializableModel,
        FormDescriptor extends ModelFieldDescriptor<Entity>>
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
  final bool allowDelete;

  Widget _addButton(
          BuildContext context, EntityManagerState<Entity> entityManager) =>
      FilledButton(
        onPressed: () => context.showBottomSheetOrDialog<Entity>(
          NitGenericForm<Entity, FormDescriptor>(
            fields: fields,
            entityManager: entityManager,
            // fields: (FormDescriptor as Enum).value,
          ),
        ),
        child: const Text('Добавить'),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return ref.read(entityManagerStateProvider<Entity>()).when(
    final backendConfig = customBackendConfig ?? EntityListConfig.defaultConfig;
    final entityManager =
        ref.read(entityManagerStateProvider<Entity>()(backendConfig).notifier);

    return ref.watchEntityListState<Entity>(backendConfig: backendConfig).when(
          error: (error, stackTrace) =>
              const Text("Не удалось подгрузить данные"),
          loading: () => const CircularProgressIndicator(),
          data: (List<int> data) => Column(
            crossAxisAlignment: context.isMobile
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              if (!context.isMobile) _addButton(context, entityManager),
              Expanded(
                child: ListView(
                  children: data
                      .map(
                        (modelId) => Card(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () =>
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
                                    context.showBottomSheetOrDialog(
                                  NitGenericForm<Entity, FormDescriptor>(
                                    fields: fields,
                                    modelId: modelId,
                                    entityManager: entityManager,
                                    allowDelete: allowDelete,
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
              if (context.isMobile) _addButton(context, entityManager),
            ],
          ),
        );
  }
}
