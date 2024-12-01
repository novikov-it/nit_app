part of '../form_input_descriptor.dart';

abstract class DropdownInputDescriptor<Entity> extends FormInputDescriptor {
  const DropdownInputDescriptor({
    required super.displayTitle,
    super.isRequired = false,
    this.nullLabel,
    this.labelExtractor,
    this.labelField,
  });

  final String? nullLabel;
  final String Function(WidgetRef ref, Entity model)? labelExtractor;
  final ModelFieldDescriptor<Entity>? labelField;

  // AsyncValue<List<Entity>> optionsList(WidgetRef ref);

  Function(WidgetRef ref, T model) labelFromFieldExtractor<T>(
          ModelFieldDescriptor<T> field) =>
      field.initialValue;
}

class PredefinedDropdownInputDescriptor<Entity>
    extends DropdownInputDescriptor {
  const PredefinedDropdownInputDescriptor({
    required super.displayTitle,
    super.isRequired = false,
    required this.optionsList,
    super.nullLabel,
    super.labelExtractor,
    super.labelField,
  });

  final List<Entity> optionsList;

  @override
  Widget prepareWidget(ModelFieldDescriptor fieldDescriptor) {
    return NitDropdownFormField(
      fieldDescriptor: fieldDescriptor,
      inputDescriptor: this,
      optionsList: optionsList,
    );
  }
}

class EntityDropdownInputDescriptor<Entity extends SerializableModel>
    extends DropdownInputDescriptor<Entity> {
  const EntityDropdownInputDescriptor({
    required super.displayTitle,
    super.isRequired,
    super.nullLabel,
    super.labelExtractor,
    super.labelField,
    this.filteringFields,
  });

  final List<ModelFieldDescriptor>? filteringFields;

  @override
  Widget prepareWidget(ModelFieldDescriptor fieldDescriptor) {
    return NitEntityDropdownFormField(
      fieldDescriptor: fieldDescriptor,
      inputDescriptor: this,
    );
  }
}
