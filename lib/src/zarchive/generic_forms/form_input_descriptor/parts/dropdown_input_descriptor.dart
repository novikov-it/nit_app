// part of '../form_input_descriptor.dart';

// abstract class DropdownInputDescriptor<ValueType>
//     extends FormInputDescriptor<ValueType> {
//   const DropdownInputDescriptor({
//     required super.displayTitle,
//     super.isRequired = false,
//     this.nullLabel,
//     // this.labelExtractor,
//     // this.labelField,
//   });

//   final String? nullLabel;
//   // final String Function(WidgetRef ref, Entity model)? labelExtractor;
//   // final ModelFieldDescriptor<Entity>? labelField;

//   // AsyncValue<List<Entity>> optionsList(WidgetRef ref);

//   Function(WidgetRef ref, T model) labelFromFieldExtractor<T>(
//           ModelFieldDescriptor<T> field) =>
//       field.initialValue;
// }

// class PredefinedDropdownInputDescriptor<ValueType>
//     extends DropdownInputDescriptor<ValueType> {
//   const PredefinedDropdownInputDescriptor({
//     required super.displayTitle,
//     super.isRequired = false,
//     required this.optionsMap,
//     super.nullLabel,
//     // super.labelExtractor,
//     // super.labelField,
//   });

//   final Map<ValueType, String> optionsMap;

//   @override
//   Widget prepareWidget(ModelFieldDescriptor fieldDescriptor) {
//     return NitDropdownFormField(
//       fieldDescriptor: fieldDescriptor,
//       inputDescriptor: this,
//       optionsMap: optionsMap,
//     );
//   }
// }

// class EntityDropdownInputDescriptor<Entity extends SerializableModel>
//     extends DropdownInputDescriptor<int> {
//   const EntityDropdownInputDescriptor({
//     required super.displayTitle,
//     super.isRequired,
//     super.nullLabel,
//     // super.labelExtractor,
//     required this.labelField,
//     this.secondaryLabelField,
//     this.valueField,
//     this.filteringFields,
//   });

//   final List<ModelFieldDescriptor>? filteringFields;
//   final ModelFieldDescriptor<Entity> labelField;
//   final ModelFieldDescriptor<Entity>? secondaryLabelField;
//   final ModelFieldDescriptor<Entity>? valueField;

//   @override
//   Widget prepareWidget(ModelFieldDescriptor fieldDescriptor) {
//     return NitEntityDropdownFormField(
//       fieldDescriptor: fieldDescriptor,
//       inputDescriptor: this,
//     );
//   }
// }
