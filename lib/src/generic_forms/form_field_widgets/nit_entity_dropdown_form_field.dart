import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_app/src/generic_forms/form_field_widgets/nit_dropdown_form_field.dart';
import 'package:nit_app/src/generic_forms/form_field_widgets/nit_form_field.dart';
import 'package:nit_app/src/repository/repository.dart';

import '../../repository/entity_list_config.dart';

class NitEntityDropdownFormField<Entity extends SerializableModel>
    extends NitFormField<Entity> {
  const NitEntityDropdownFormField({
    super.key,
    required super.fieldDescriptor,
    required this.inputDescriptor,
    // required this.initialValue,
    // required this.onSaved,
  });

  final EntityDropdownInputDescriptor<Entity> inputDescriptor;
  // final Entity? initialValue;
  // final Function(Entity? value) Function(BuildContext context) onSaved;
  // final List<Entity> optionsList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watchEntityListState<Entity>(
          backendConfig: EntityListConfig(
              backendFilters: inputDescriptor.filteringFields
                  ?.map(
                    (e) => NitBackendFilter(
                      fieldName: e.name,
                      equalsTo:
                          formStateProvider(context).values[e.name].toString(),
                    ),
                  )
                  .toList()),
        )
        .whenData((data) =>
            data.map((e) => ref.readModel<Entity>(e)).whereNotNull().toList())
        .when(
          error: (error, stackTrace) =>
              const Text('Не удалось подгрузить опции'),
          loading: () => const CircularProgressIndicator(),
          data: (data) => NitDropdownFormField(
            fieldDescriptor: fieldDescriptor,
            inputDescriptor: inputDescriptor,
            // initialValue: initialValue,
            // onSaved: onSaved,
            optionsMap: Map.fromEntries(
              data.map(
                (e) => MapEntry(
                  e.toJson()['id'],
                  inputDescriptor.labelField.initialValue(ref, e),
                  // e.toString(),
                ),
              ),
            ),
          ),
        );
  }
}
