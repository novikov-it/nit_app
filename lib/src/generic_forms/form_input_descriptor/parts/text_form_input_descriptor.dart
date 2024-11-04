part of '../form_input_descriptor.dart';

class TextInputDescriptor extends FormInputDescriptor {
  const TextInputDescriptor({
    super.isRequired = false,
    super.displayTitle,
    this.validators,
  });

  final List<Validator>? validators;
}
