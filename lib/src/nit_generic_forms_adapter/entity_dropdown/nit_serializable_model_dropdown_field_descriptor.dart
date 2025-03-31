import 'package:flutter/material.dart';
import 'package:nit_app/nit_app.dart';

import 'nit_serializable_model_dropdown_form_field_widget.dart';

class NitSerializableModelDropdownFieldDescriptor<
    Entity extends SerializableModel> extends NitDropdownFieldDescriptor<int> {
  const NitSerializableModelDropdownFieldDescriptor({
    required super.displayTitle,
    super.isRequired,
    super.nullLabel,
    // required this.preloadProvider,
    // super.labelExtractor,
    required this.labelField,
    this.secondaryLabelField,
    this.valueField,
    this.filteringFields,
  });

  // final AsyncNotifierProvider<dynamic, Map<ValueType, String>> preloadProvider;

  final List<NitGenericFormsFieldsEnum>? filteringFields;
  final NitGenericFormsFieldsEnum labelField;
  final NitGenericFormsFieldsEnum? secondaryLabelField;
  final NitGenericFormsFieldsEnum? valueField;

  // final AsyncNotifierProvider<

  @override
  Widget prepareWidget(NitGenericFormsFieldsEnum formField) {
    return NitSerializableModelDropdownFieldWidget(
      formField: formField,
      fieldDescriptor: this,
    );
  }
}
