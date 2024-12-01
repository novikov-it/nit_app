part of '../form_input_descriptor.dart';

class TextInputDescriptor extends FormInputDescriptor {
  const TextInputDescriptor({
    required super.displayTitle,
    super.isRequired = false,
    this.validators,
  });

  final List<Validator>? validators;

  @override
  Widget prepareWidget(ModelFieldDescriptor fieldDescriptor) {
    return NitTextFormField(
      fieldDescriptor: fieldDescriptor,
      inputDescriptor: this,
    );
  }
}
