import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';

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
