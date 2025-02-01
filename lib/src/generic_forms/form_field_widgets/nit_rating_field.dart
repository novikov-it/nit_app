import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';

import 'nit_form_field.dart';

class NitRatingField extends NitFormField<int> {
  const NitRatingField({
    super.key,
    required super.fieldDescriptor,
    required this.inputDescriptor,
  });

  final RatingInputDescriptor inputDescriptor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FormField<int>(
      initialValue: initialValue(context),
      validator: (value) {
        if (inputDescriptor.isRequired && value == null) {
          return 'Обязательное поле';
        }

        return null;
      },
      builder: (fieldState) {
        // field.value
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (inputDescriptor.displayTitle != null)
              Text(
                inputDescriptor.displayTitle!,
                style: context.theme.inputDecorationTheme.labelStyle,
              ),
            Row(
              children: [1, 2, 3, 4, 5]
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        onChangedAction(context)(e);
                        fieldState.didChange(e);
                      },
                      child: Icon(
                        color: const Color.fromARGB(255, 255, 180, 161),
                        (fieldState.value ?? 0) >= e
                            ? Icons.star_rounded
                            : Icons.star_border_rounded,
                      ),
                    ),
                  )
                  .toList(),
            ),
            if (fieldState.hasError)
              Text(
                fieldState.errorText!,
                style: context.textTheme.labelMedium!.copyWith(
                  color: context.colorScheme.error,
                ),
              )
          ],
        );
      },
    );
  }
}
