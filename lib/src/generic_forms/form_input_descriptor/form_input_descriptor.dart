import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/src/repository/repository.dart';
import 'package:serverpod_client/serverpod_client.dart';

import '../descriptors/model_field_descriptor.dart';
import '../validator/validator.dart';

part 'parts/checkbox_input_descriptor.dart';
part 'parts/dropdown_input_descriptor.dart';
part 'parts/image_picker_input_descriptor.dart';
part 'parts/text_form_input_descriptor.dart';

abstract class FormInputDescriptor {
  const FormInputDescriptor({
    this.isRequired = false,
    this.displayTitle,
  });

  final bool isRequired;
  final String? displayTitle;
}
