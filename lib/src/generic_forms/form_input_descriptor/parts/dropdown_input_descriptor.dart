part of '../form_input_descriptor.dart';

abstract class DropdownInputDescriptor<Entity> extends FormInputDescriptor {
  const DropdownInputDescriptor({
    required super.displayTitle,
    super.isHidden = false,
    super.isRequired = false,
    this.nullLabel,
    this.labelExtractor,
    this.labelField,
  });

  final String? nullLabel;
  final String Function(WidgetRef ref, Entity model)? labelExtractor;
  final ModelFieldDescriptor<Entity>? labelField;

  AsyncValue<List<Entity>> optionsList(WidgetRef ref);

  Function(WidgetRef ref, T model) labelFromFieldExtractor<T>(
          ModelFieldDescriptor<T> field) =>
      field.initialValue;
}

class PredefinedDropdownInputDescriptor<Entity>
    extends DropdownInputDescriptor {
  const PredefinedDropdownInputDescriptor({
    required super.displayTitle,
    super.isHidden = false,
    super.isRequired = false,
    required List<Entity> optionsList,
    super.nullLabel,
    super.labelExtractor,
    super.labelField,
  }) : _optionsList = optionsList;

  final List<Entity> _optionsList;

  @override
  AsyncValue<List<Entity>> optionsList(WidgetRef ref) =>
      AsyncValue.data(_optionsList);
}

class EntityDropdownInputDescriptor<Entity extends SerializableModel>
    extends DropdownInputDescriptor<Entity> {
  const EntityDropdownInputDescriptor({
    required super.displayTitle,
    super.isHidden = false,
    super.isRequired = false,
    super.nullLabel,
    super.labelExtractor,
    super.labelField,
  });

  @override
  AsyncValue<List<Entity>> optionsList(WidgetRef ref) {
    return ref.watchEntityListState<Entity>().whenData(
          (data) =>
              data.map((e) => ref.readModel<Entity>(e)).whereNotNull().toList(),
        );
  }
}
