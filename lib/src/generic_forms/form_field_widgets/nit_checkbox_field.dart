import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';

class NitCheckboxField extends ConsumerWidget {
  const NitCheckboxField({
    super.key,
    required this.inputDescriptor,
    required this.initialValue,
    required this.onSaved,
  });

  final CheckboxInputDescriptor inputDescriptor;
  final bool? initialValue;
  final Function(bool? value) Function(BuildContext context) onSaved;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FormField<bool>(
      onSaved: onSaved(context),
      initialValue: initialValue,
      builder: (fieldState) {
        // field.value
        return Row(
          children: [
            Checkbox(
              value: fieldState.value,
              onChanged: (value) => fieldState.didChange(value),
            ),
            Text(
              inputDescriptor.displayTitle ?? '',
            ),
          ],
        );
      },
    );
  }
}
