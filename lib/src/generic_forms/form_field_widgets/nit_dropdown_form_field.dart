import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_app/src/generic_forms/form_field_widgets/nit_form_field.dart';
import 'package:nit_app/src/generic_forms/generic_forms.dart';

class NitDropdownFormField<Entity> extends NitFormField<Entity> {
  const NitDropdownFormField({
    super.key,
    required super.fieldDescriptor,
    required this.inputDescriptor,
    // required this.initialValue,
    // required this.onSaved,
    required this.optionsList,
  });

  // final ModelFieldDescriptor fieldDescriptor;
  final DropdownInputDescriptor<Entity> inputDescriptor;
  // final Entity? initialValue;
  // final Function(Entity? value) Function(BuildContext context) onSaved;
  final List<Entity> optionsList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButtonFormField<Entity>(
      value: initialValue(context),
      items: [
        DropdownMenuItem<Entity>(
          value: null,
          child: Text(
            inputDescriptor.nullLabel ?? 'Выберите из списка',
          ),
        ),
        ...optionsList.map(
          (e) => DropdownMenuItem<Entity>(
            value: e,
            child: Text(
              // fieldDescriptor.labelExtractor(e),
              inputDescriptor.labelExtractor != null
                  ? e != null
                      ? inputDescriptor.labelExtractor!(ref, e)
                      : 'Объект не найден'
                  : inputDescriptor.labelField!.initialValue(ref, e),
            ),
          ),
        ),
      ],
      onChanged: onChangedAction(context),
    );
  }
}
