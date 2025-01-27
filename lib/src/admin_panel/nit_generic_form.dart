import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:nit_app/src/nit_app_build_context_extension.dart';
import 'package:nit_app/src/repository/repository.dart';
// import 'package:nit_app/nit_app.dart';
import 'package:serverpod_client/serverpod_client.dart';

import '../generic_forms/generic_forms.dart';
import '../nit_app_ui_kit.dart';
import '../repository/entity_manager_interface.dart';

class NitGenericForm<Entity extends SerializableModel,
        FormDescriptor extends ModelFieldDescriptor<Entity>>
    extends ConsumerStatefulWidget {
  const NitGenericForm({
    super.key,
    this.title = 'Редактирование',
    required this.fields,
    this.entityManager,
    this.modelId,
    // this.initialModel,
    this.customOnSaveAction,
    this.allowDelete = true,
  });

  // final NitGenericFormEnum
  final String title;
  final int? modelId;
  final List<FormDescriptor> fields;
  final Function(Entity? model)? customOnSaveAction;
  final EntityManagerInterface? entityManager;
  final bool allowDelete;

  static NitFormState? maybeOf(BuildContext context) {
    final _NitFormScope? scope =
        context.dependOnInheritedWidgetOfExactType<_NitFormScope>();
    return scope?._formState;
  }

  static NitFormState of(BuildContext context) {
    final NitFormState? formState = maybeOf(context);
    assert(() {
      if (formState == null) {
        throw FlutterError(
          'NitForm.of() was called with a context that does not contain a NitForm widget.\n'
          'No NitForm widget ancestor could be found starting from the context that '
          'was passed to NitForm.of(). This can happen because you are using a widget '
          'that looks for a NitForm ancestor, but no such ancestor exists.\n'
          'The context used was:\n'
          '  $context',
        );
      }
      return true;
    }());
    return formState!;
  }

  @override
  ConsumerState<NitGenericForm> createState() =>
      NitFormState<Entity, FormDescriptor>();
}

class NitFormState<StateEntity extends SerializableModel,
        StateFormDescriptor extends ModelFieldDescriptor<StateEntity>>
    extends ConsumerState<NitGenericForm> {
  final _formKey = GlobalKey<FormState>();
  late final StateEntity? model;
  late final Map<String, dynamic> values;

  late final List<StateFormDescriptor> visibleFields;

  @override
  void initState() {
    super.initState();

    // if (widget.modelId != null) {
    model = widget.modelId != null
        ? ref.readModel(
            widget.modelId!,
          )
        : null;
    values = Map.fromEntries(
      widget.fields.map(
        (e) => MapEntry(
          e.name,
          e.initialValue(
            ref,
            model,
          ),
        ),
      ),
    );
    visibleFields = widget.fields
        .whereNot((e) => e.inputDescriptor is HiddenInputDescriptor)
        .toList() as List<StateFormDescriptor>;
  }

  setValue<T>(ModelFieldDescriptor field, T? value) {
    values[field.name] = value;
  }

  @override
  Widget build(BuildContext context) {
    // final model = widget.modelId != null
    //     ? ref.read(modelProvider<Entity>()(widget.modelId!))
    //     : null;

    return _NitFormScope(
      formState: this,
      child: Form(
        key: _formKey,
        child: NitDialogLayout(
          title: widget.title,
          buttons: [
            if (widget.modelId != null &&
                widget.entityManager != null &&
                widget.allowDelete)
              IconButton(
                onPressed: () => widget.entityManager!
                    .delete(widget.modelId!)
                    .then(context.popOnTrue),
                icon: const Icon(Icons.delete_forever),
              ),
            ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text(
                'Сбросить',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() != false) {
                  // Вызывает срабатывание
                  // _formKey.currentState?.save();

                  // final updatedModel = ref
                  //     .read(nitFormStateProvider(_formKey).notifier)
                  //     .prepareUpdatedModel();

                  final updatedModel = widget.fields.first.save(
                    model,
                    values,
                  );

                  if (updatedModel != null) {
                    await (widget.entityManager != null
                            ? widget.entityManager!
                                .save(updatedModel as StateEntity)
                            : ref.saveModel(updatedModel))
                        .then(context.popIfNotNull);
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
            itemCount: visibleFields.length,
            itemBuilder: (context, index) => visibleFields[index]
                .inputDescriptor
                .prepareWidget(visibleFields[index]),
            // .prepareField()
            // .prepareFormWidget(ref, widget.model),
            separatorBuilder: (context, index) => const Gap(0),
          ),
        ),
      ),
    );
  }
}

class _NitFormScope extends InheritedWidget {
  const _NitFormScope({
    required super.child,
    required NitFormState formState,
    // required int generation,
  }) : _formState = formState;
  // _generation = generation;

  final NitFormState _formState;

  /// Incremented every time a form field has changed. This lets us know when
  /// to rebuild the form.
  // final int _generation;

  /// The [Form] associated with this widget.
  // Form get form => _formState.widget;

  @override
  bool updateShouldNotify(_NitFormScope old) => false;
  //  _generation != old._generation;
}
