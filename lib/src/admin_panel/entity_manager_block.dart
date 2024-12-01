import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';
import 'entity_editing_form.dart';

class EntityManagerBlock<Entity extends SerializableModel,
        FormDescriptor extends ModelFieldDescriptor<Entity>>
    extends ConsumerWidget {
  const EntityManagerBlock({
    super.key,
    required this.fields,
    required this.listViewBuilder,
  });

  final List<FormDescriptor> fields;
  final Widget Function({required int id, Key? key}) listViewBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return ref.read(entityManagerStateProvider<Entity>()).when(
    final backendConfig = EntityListConfig.defaultConfig;
    final entityManager =
        ref.read(entityManagerStateProvider<Entity>()(backendConfig).notifier);

    return ref.watchEntityListState<Entity>(backendConfig: backendConfig).when(
          error: (error, stackTrace) =>
              const Text("Не удалось подгрузить данные"),
          loading: () => const CircularProgressIndicator(),
          data: (List<int> data) => Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: ListView(
                  children: data
                      .map(
                        (modelId) => Card(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () =>
                                    context.showBottomSheetOrDialog(
                                  NitForm<Entity, FormDescriptor>(
                                    fields: fields,
                                    modelId: modelId,
                                    entityManager: entityManager,
                                  ),
                                ),
                                icon: const Icon(Icons.edit),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: listViewBuilder(id: modelId),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              FilledButton(
                onPressed: () => context.showBottomSheetOrDialog<Entity>(
                  NitForm<Entity, FormDescriptor>(
                    fields: fields,
                    entityManager: entityManager,
                    // fields: (FormDescriptor as Enum).value,
                  ),
                ),
                child: const Text('Добавить'),
              ),
            ],
          ),
        );
  }
}
