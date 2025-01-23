part of '../form_input_descriptor.dart';

class TextInputDescriptor<ValueType> extends FormInputDescriptor<ValueType> {
  const TextInputDescriptor({
    required super.displayTitle,
    super.isRequired = false,
    this.validators,
  });

  final List<Validator<ValueType>>? validators;

  @override
  Widget prepareWidget(ModelFieldDescriptor fieldDescriptor) {
    return NitTextFormField<ValueType>(
      fieldDescriptor: fieldDescriptor,
      inputDescriptor: this,
    );
  }
}
