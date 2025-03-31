import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_ui_kit/nit_ui_kit.dart';

class NitSerializableModelDropdownFieldWidget<Entity extends SerializableModel>
    extends NitFormField<int> {
  const NitSerializableModelDropdownFieldWidget({
    super.key,
    required super.formField,
    required this.fieldDescriptor,
    // required this.initialValue,
    // required this.onSaved,
  });

  final NitSerializableModelDropdownFieldDescriptor<Entity> fieldDescriptor;
  // final Entity? initialValue;
  // final Function(Entity? value) Function(BuildContext context) onSaved;
  // final List<Entity> optionsList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watchEntityListState<Entity>(
          backendConfig: EntityListConfig(
              backendFilters: fieldDescriptor.filteringFields
                  ?.map(
                    (e) => NitBackendFilter(
                      fieldName: e.name,
                      equalsTo:
                          formStateProvider(context).values[e.name].toString(),
                    ),
                  )
                  .toList()),
        )
        // .whenData((data) =>
        //     data.map((e) => ref.readModel<Entity>(e)).whereNotNull().toList())
        .nitWhen(
          errorWidget: const Text('Не удалось подгрузить опции'),
          loadingValue: [NitDefaultModelsRepository.mockModelId],
          childBuilder: (data) => Skeleton.replace(
            // width: width,
            // height: height,
            child: NitDropdownFieldWidget<int>(
              formField: formField,
              fieldDescriptor: fieldDescriptor,
              // initialValue: initialValue,
              // onSaved: onSaved,
              optionsMap: Map.fromEntries(
                data.map(
                  (e) {
                    final json = ref.readModel<Entity>(e).toJson();

                    return MapEntry(
                      json[fieldDescriptor.valueField?.name ?? 'id'],
                      json[fieldDescriptor.labelField.name] ??
                          (fieldDescriptor.secondaryLabelField != null
                              ? json[fieldDescriptor.secondaryLabelField!.name]
                              : null) ??
                          '???',
                    );
                  },
                ),
              ),
            ),
          ),
        );
  }
}
