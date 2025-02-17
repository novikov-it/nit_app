import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_app/src/generic_forms/form_field_widgets/nit_form_field.dart';
import 'package:nit_ui_kit/nit_ui_kit.dart';

class NitImagePickerField extends NitFormField<String> {
  const NitImagePickerField({
    super.key,
    required super.fieldDescriptor,
    required this.inputDescriptor,
    // required this.initialValue,
    // required this.onSaved,
  });

  final ImagePickerInputDescriptor inputDescriptor;
  // final String? initialValue;
  // final Function(String? value) Function(BuildContext context) onSaved;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FormField<String>(
      // onSaved: onSaved(context),
      initialValue: initialValue(context),
      builder: (fieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (inputDescriptor.displayTitle != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  inputDescriptor.displayTitle!,
                  // 'Цена',
                  style: context.theme.inputDecorationTheme.labelStyle,
                ),
              ),
            InkWell(
              onTap: () async {
                final publicUrl = await ref.pickImage();

                if (context.mounted) {
                  onChangedAction(context)(publicUrl);
                  fieldState.didChange(publicUrl);
                }
              },
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: fieldState.value != null
                      ? null
                      : context.colorScheme.secondaryContainer,
                  image: fieldState.value == null
                      ? null
                      : DecorationImage(
                          image: NetworkImage(fieldState.value!),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
