// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nit_app/nit_app.dart';

// import '../form_field_widgets/nit_checkbox_field.dart';
// import '../form_field_widgets/nit_datetime_picker_field.dart';
// import '../form_field_widgets/nit_dropdown_form_field.dart';
// import '../form_field_widgets/nit_entity_dropdown_form_field.dart';
// import '../form_field_widgets/nit_image_picker_field.dart';
// import '../form_field_widgets/nit_media_picker_field.dart';
// import '../form_field_widgets/nit_rating_field.dart';
// import '../form_field_widgets/nit_text_form_field.dart';

// part 'parts/checkbox_input_descriptor.dart';
// part 'parts/datetime_picker_input_descriptor.dart';
// part 'parts/dropdown_input_descriptor.dart';
// part 'parts/image_picker_input_descriptor.dart';
// part 'parts/media_picker_input_descriptor.dart';
// part 'parts/rating_input_descriptor.dart';
// part 'parts/text_form_input_descriptor.dart';

// abstract class FormInputDescriptor<T> {
//   const FormInputDescriptor({
//     this.isRequired = false,
//     this.displayTitle,
//   });

//   final bool isRequired;
//   final String? displayTitle;

//   Widget prepareWidget(
//     ModelFieldDescriptor fieldDescriptor,
//   );
// }

// class HiddenInputDescriptor<T> extends FormInputDescriptor<T> {
//   const HiddenInputDescriptor();

//   @override
//   Widget prepareWidget(ModelFieldDescriptor fieldDescriptor) =>
//       SizedBox.shrink();
// }
