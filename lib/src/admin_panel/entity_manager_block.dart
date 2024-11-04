import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/src/nit_app_build_context_extension.dart';
// import 'package:nit_app/nit_app.dart';
import 'package:serverpod_client/serverpod_client.dart';
import '../generic_forms/generic_forms.dart';
import '../repository/repository.dart';
import 'entity_editing_form.dart';

// final robotManagerProvider =
//     AutoDisposeAsyncNotifierProvider<EntityManagerState<Robot>, List<int>>(
//         EntityManagerState<Robot>.new);

//     final robotManagerProvider =
// AutoDisposeAsyncNotifierProvider<EntityManagerState<Robot>, List<int>>(
//     EntityManagerState<Robot>.new);

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

  // final AutoDisposeAsyncNotifierProvider<EntityManagerState<Entity>, List<int>>
  //     provider = entityManagerStateProvider<Entity>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return ref.read(entityManagerStateProvider<Entity>()).when(

    return
        // ref.watch(provider).when(
        //     data: (data) => Text(data.toString()),
        //     error: (error, stackTrace) => Text(error.toString()),
        //     loading: () => const CircularProgressIndicator());
        ref.watchEntityListState<Entity>().when(
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
                                      EntityEditingForm<Entity, FormDescriptor>(
                                        fields: fields,
                                        modelId: modelId,
                                        model: ref.read(
                                          modelProvider<Entity>()(
                                            modelId,
                                          ),
                                        ),
                                        // fields: (FormDescriptor as Enum).value,
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
                      EntityEditingForm<Entity, FormDescriptor>(
                        fields: fields,
                        modelId: null,
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
