import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_app/src/generic_forms/form_field_widgets/nit_form_field.dart';

class NitMediaPickerField extends NitFormField<List<String>> {
  const NitMediaPickerField({
    super.key,
    required super.fieldDescriptor,
    required this.inputDescriptor,
    // required this.initialValue,
    // required this.onSaved,
  });

  final MediaPickerInputDescriptor inputDescriptor;
  // final String? initialValue;
  // final Function(String? value) Function(BuildContext context) onSaved;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FormField<List<String>>(
      // onSaved: onSaved(context),
      initialValue: initialValue(context) ?? [],
      builder: (fieldState) {
        // field.value
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (inputDescriptor.displayTitle != null)
              Text(
                inputDescriptor.displayTitle!,
                // 'Цена',
                style: context.theme.inputDecorationTheme.labelStyle,
              ),
            SizedBox(
              height: 150,
              child: CarouselView(
                itemExtent: 150,
                onTap: (index) async {
                  final publicUrl = await ref.pickImage();

                  final newValue = index == fieldState.value!.length
                      ? [
                          ...fieldState.value!,
                          if (publicUrl != null) publicUrl,
                        ]
                      : [
                          ...fieldState.value!.sublist(0, index),
                          if (publicUrl != null) publicUrl,
                          ...fieldState.value!.sublist(index + 1),
                        ];

                  if (context.mounted) {
                    onChangedAction(context)(newValue);
                    fieldState.didChange(newValue);
                  }
                },
                children: List<int>.generate(
                        (fieldState.value?.length ?? 0) + 1, (i) => i)
                    .map(
                      (index) =>
                          // InkWell(
                          // onTap: () async {
                          //   final ImagePicker picker = ImagePicker();

                          //   final XFile? image = await picker.pickImage(
                          //       source: ImageSource.gallery);

                          //   if (image == null) {
                          //     debugPrint('no image');
                          //     return;
                          //   }

                          //   final buffer = await image.readAsBytes();
                          //   final bytes = ByteData.view(buffer.buffer);

                          //   final path =
                          //       '${DateFormat('yyyy-MM-dd').format(DateTime.now())}-${image.name}';
                          //   var uploadDescription =
                          //       await nitToolsCaller.upload.getUploadDescription(
                          //     path: path,
                          //     // '${folder != null ? '$folder/' : ''}
                          //   );

                          //   if (uploadDescription != null) {
                          //     debugPrint(uploadDescription);
                          //     var uploader = FileUploader(uploadDescription);
                          //     await uploader.uploadByteData(bytes);
                          //     var publicUrl =
                          //         await nitToolsCaller.upload.verifyUpload(
                          //       path: path,
                          //     );

                          //     debugPrint('$publicUrl');

                          //     final newValue = index == fieldState.value!.length
                          //         ? [
                          //             ...fieldState.value!,
                          //             if (publicUrl != null) publicUrl,
                          //           ]
                          //         : [
                          //             ...fieldState.value!.sublist(0, index),
                          //             if (publicUrl != null) publicUrl,
                          //             ...fieldState.value!.sublist(index),
                          //           ];

                          //     if (context.mounted) {
                          //       onChangedAction(context)(newValue);
                          //       fieldState.didChange(newValue);
                          //     }
                          //   }
                          // },
                          // child:
                          Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          color: index < fieldState.value!.length
                              ? null
                              : context.colorScheme.secondaryContainer,
                          image: index == fieldState.value!.length
                              ? null
                              : DecorationImage(
                                  image: NetworkImage(fieldState.value![index]),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        // ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
