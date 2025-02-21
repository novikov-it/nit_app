import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../admin_panel/nit_generic_form.dart';
import '../descriptors/model_field_descriptor.dart';

abstract class NitFormField<ValueType> extends ConsumerWidget {
  const NitFormField({
    super.key,
    required this.fieldDescriptor,
  });

  final ModelFieldDescriptor fieldDescriptor;

  NitFormState formStateProvider(BuildContext context) =>
      NitGenericForm.of(context);

  ValueType? initialValue(BuildContext context) {
    return formStateProvider(context).values[fieldDescriptor.name];
  }

  onChangedAction(BuildContext context) => (ValueType? value) {
        formStateProvider(context).setValue<ValueType>(fieldDescriptor, value);
      };
}
