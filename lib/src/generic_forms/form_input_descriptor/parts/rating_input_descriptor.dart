part of '../form_input_descriptor.dart';

class RatingInputDescriptor extends FormInputDescriptor {
  const RatingInputDescriptor({
    required super.displayTitle,
    super.isRequired,
  });

  @override
  Widget prepareWidget(ModelFieldDescriptor fieldDescriptor) {
    return NitRatingField(
      fieldDescriptor: fieldDescriptor,
      inputDescriptor: this,
    );
  }
}
