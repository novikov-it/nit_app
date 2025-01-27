import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_app/src/generic_forms/form_field_widgets/nit_form_field.dart';
import 'package:nit_app/src/generic_forms/generic_forms.dart';

class NitDropdownFormField<ValueType> extends NitFormField<ValueType> {
  const NitDropdownFormField({
    super.key,
    required super.fieldDescriptor,
    required this.inputDescriptor,
    // required this.initialValue,
    // required this.onSaved,
    required this.optionsMap,
  });

  // final ModelFieldDescriptor fieldDescriptor;
  final DropdownInputDescriptor<ValueType> inputDescriptor;
  // final Entity? initialValue;
  // final Function(Entity? value) Function(BuildContext context) onSaved;
  final Map<ValueType, String> optionsMap;
  // final Map<

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButtonFormField<ValueType>(
      value: initialValue(context),
      items: [
        DropdownMenuItem<ValueType>(
          value: null,
          child: Text(
            inputDescriptor.nullLabel ?? 'Выберите из списка',
          ),
        ),
        ...optionsMap.entries.map(
          (e) => DropdownMenuItem<ValueType>(
            value: e.key,
            child: Text(
              e.value,
              // fieldDescriptor.labelExtractor(e),
              // inputDescriptor.labelExtractor != null
              //     ? e != null
              //         ? inputDescriptor.labelExtractor!(ref, e)
              //         : 'Объект не найден'
              //     : inputDescriptor.labelField!.initialValue(ref, e),
            ),
          ),
        ),
      ],
      onChanged: onChangedAction(context),
    );
  }
}
