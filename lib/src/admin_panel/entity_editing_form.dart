import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:nit_app/src/nit_app_build_context_extension.dart';
import 'package:nit_app/src/repository/entity_manager_config.dart';
// import 'package:nit_app/nit_app.dart';
import 'package:serverpod_client/serverpod_client.dart';

import '../generic_forms/generic_forms.dart';
import '../nit_app_ui_kit.dart';
import '../repository/entity_manager_state.dart';

class EntityEditingForm<Entity extends SerializableModel,
        FormDescriptor extends ModelFieldDescriptor<Entity>>
    extends ConsumerStatefulWidget {
  const EntityEditingForm({
    super.key,
    required this.fields,
    this.model,
    this.modelId,
    // this.initialModel,
    this.customOnSaveAction,
  });

  // final NitGenericFormEnum
  final Entity? model;
  final int? modelId;
  final List<FormDescriptor> fields;
  final Function(Entity? model)? customOnSaveAction;

  @override
  ConsumerState<EntityEditingForm> createState() =>
      _State<Entity, FormDescriptor>();
}

class _State<StateEntity extends SerializableModel,
        StateFormDescriptor extends ModelFieldDescriptor<StateEntity>>
    extends ConsumerState<EntityEditingForm> {
  // final Map<StateFormDescriptor, dynamic> values = {};
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // if (ModelFieldDescriptor.valuesMap[key] == null) {
    ModelFieldDescriptor.valuesMap[_formKey] = {};
    // }
    for (var e in widget.fields) {
      ModelFieldDescriptor.valuesMap[_formKey]![e.name] =
          e.initialValue(ref, widget.model);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final model = widget.modelId != null
    //     ? ref.read(modelProvider<Entity>()(widget.modelId!))
    //     : null;

    return Form(
      key: _formKey,
      child: NitDialogLayout(
        title: "Редактирование",
        buttons: [
          if (widget.model != null)
            IconButton(
                onPressed: () => ref
                    .read(entityManagerStateProvider<StateEntity>()(
                            EntityListConfig())
                        .notifier)
                    .delete(widget.model! as StateEntity, widget.modelId!)
                    .then(context.popOnTrue),
                icon: const Icon(Icons.delete_forever)),
          ElevatedButton(
            onPressed: () {
              context.pop();
            },
            child: const Text(
              'Сбросить',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() != false) {
                // Вызывает срабатывание
                _formKey.currentState?.save();

                final updatedModel = widget.fields.first.save(
                  widget.model,
                  ModelFieldDescriptor.valuesMap[_formKey] ?? {},
                );

                if (updatedModel != null) {
                  ref
                      .read(entityManagerStateProvider<StateEntity>()(
                              EntityListConfig())
                          .notifier)
                      .save(updatedModel as StateEntity, widget.modelId)
                      .then(context.popOnTrue);
                }
              }
            },
            child: const Text(
              'Сохранить',
            ),
          ),
        ],
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: widget.fields.length,
          itemBuilder: (context, index) => widget.fields[index]
              .prepareField()
              .prepareFormWidget(ref, widget.model),
          separatorBuilder: (context, index) => const Gap(8),
        ),
      ),
    );
  }
}
