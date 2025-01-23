part of '../form_input_descriptor.dart';

class MediaPickerInputDescriptor extends FormInputDescriptor {
  const MediaPickerInputDescriptor({
    required super.displayTitle,
    super.isRequired = false,
  });

  @override
  Widget prepareWidget(ModelFieldDescriptor fieldDescriptor) {
    return NitMediaPickerField(
      fieldDescriptor: fieldDescriptor,
      inputDescriptor: this,
    );
  }
}
