part of '../form_input_descriptor.dart';

class ImagePickerInputDescriptor extends FormInputDescriptor {
  const ImagePickerInputDescriptor({
    required super.displayTitle,
    super.isRequired = false,
  });

  @override
  Widget prepareWidget(ModelFieldDescriptor fieldDescriptor) {
    return NitImagePickerField(
      fieldDescriptor: fieldDescriptor,
      inputDescriptor: this,
    );
  }
}
