import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/src/generic_forms/form_field_widgets/nit_form_field.dart';

import '../form_input_descriptor/form_input_descriptor.dart';
import '../validator/validator.dart';

class NitTextFormField extends NitFormField<String> {
  const NitTextFormField({
    super.key,
    required super.fieldDescriptor,
    required this.inputDescriptor,
    // required this.initialValue,
    // required this.onSaved,
  });

  final TextInputDescriptor inputDescriptor;
  // final dynamic initialValue;
  // final Function(String? value) Function(BuildContext context) onSaved;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      initialValue: initialValue(context),
      // // initialValue,
      // initialValue != null ? '$initialValue' : '',
      decoration: InputDecoration(
        labelText: inputDescriptor.displayTitle,
      ),
      validator: (value) {
        if (inputDescriptor.isRequired && (value == null || value.isEmpty)) {
          return "Обязательное поле";
        }

        for (var validator in inputDescriptor.validators ?? <Validator>[]) {
          final t = validator.validate(value);

          if (t != null) return t;
        }

        return null;
      },
      onChanged: onChangedAction(context),
      // onSaved: onSaved(context),
    );
  }
}
