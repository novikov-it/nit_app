part of '../form_input_descriptor.dart';

class TextInputDescriptor extends FormInputDescriptor {
  const TextInputDescriptor({
    required super.displayTitle,
    super.isHidden = false,
    super.isRequired = false,
    this.validators,
  });

  final List<Validator>? validators;
}
