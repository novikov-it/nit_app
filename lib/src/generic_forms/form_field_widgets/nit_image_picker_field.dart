import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_app/src/generic_forms/form_field_widgets/nit_form_field.dart';

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
        // field.value
        return InkWell(
          onTap: () async {
            final ImagePicker picker = ImagePicker();

            final XFile? image =
                await picker.pickImage(source: ImageSource.gallery);

            if (image == null) {
              debugPrint('no image');
              return;
            }

            final buffer = await image.readAsBytes();
            final bytes = ByteData.view(buffer.buffer);

            final path =
                '${DateFormat('yyyy-MM-dd').format(DateTime.now())}-${image.name}';
            var uploadDescription =
                await nitToolsCaller.upload.getUploadDescription(
              path: path,
              // '${folder != null ? '$folder/' : ''}
            );

            if (uploadDescription != null) {
              debugPrint(uploadDescription);
              var uploader = FileUploader(uploadDescription);
              await uploader.uploadByteData(bytes);
              var publicUrl = await nitToolsCaller.upload.verifyUpload(
                path: path,
              );

              debugPrint('$publicUrl');

              if (context.mounted) {
                onChangedAction(context)(publicUrl);
                fieldState.didChange(publicUrl);
              }
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
        );
      },
    );
  }
}
