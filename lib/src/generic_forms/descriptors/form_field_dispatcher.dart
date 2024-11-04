import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/src/generic_forms/form_field_widgets/nit_checkbox_field.dart';
import 'package:nit_app/src/generic_forms/form_field_widgets/nit_dropdown_form_field.dart';
import 'package:nit_app/src/generic_forms/form_field_widgets/nit_image_picker_field.dart';
import '../form_field_widgets/nit_text_form_field.dart';
import '../form_input_descriptor/form_input_descriptor.dart';
import 'model_field_descriptor.dart';

class FormFieldDispatcher<ModelType, FieldType> {
  FormFieldDispatcher(
    this.fieldDescriptor,
    this.inputDescriptor,
  );

  final ModelFieldDescriptor<ModelType> fieldDescriptor;
  final FormInputDescriptor inputDescriptor;

  Function(T? value) onSavedAction<T>(BuildContext context) => (value) {
        final key = Form.maybeOf(context)?.widget.key;
        if (key != null) {
          if (ModelFieldDescriptor.valuesMap[key] == null) {
            ModelFieldDescriptor.valuesMap[key] = {};
          }
          ModelFieldDescriptor.valuesMap[key]![fieldDescriptor.name] = value;
        }
      };

  Widget prepareFormWidget(WidgetRef ref, ModelType? model) {
    if (inputDescriptor is TextInputDescriptor) {
      return NitTextFormField(
        inputDescriptor: inputDescriptor as TextInputDescriptor,
        initialValue: fieldDescriptor.initialValue(ref, model),
        onSaved: onSavedAction<String>,
      );
    } else if (inputDescriptor is DropdownInputDescriptor<FieldType>) {
      return NitDropdownFormField<FieldType>(
        inputDescriptor: inputDescriptor as DropdownInputDescriptor<FieldType>,
        initialValue: fieldDescriptor.initialValue(ref, model),
        onSaved: onSavedAction<FieldType>,
      );
    } else if (inputDescriptor is ImagePickerInputDescriptor) {
      return NitImagePickerField(
        inputDescriptor: inputDescriptor as ImagePickerInputDescriptor,
        initialValue: fieldDescriptor.initialValue(ref, model),
        onSaved: onSavedAction<String>,
      );
    } else if (inputDescriptor is CheckboxInputDescriptor) {
      return NitCheckboxField(
        inputDescriptor: inputDescriptor as CheckboxInputDescriptor,
        initialValue: fieldDescriptor.initialValue(ref, model),
        onSaved: onSavedAction<bool>,
      );
    } else {
      return Container(
        color: Colors.grey,
        child: Text(
            "Ошибка: поле '${inputDescriptor.displayTitle} настроено некорректно"),
      );
    }
  }
}
