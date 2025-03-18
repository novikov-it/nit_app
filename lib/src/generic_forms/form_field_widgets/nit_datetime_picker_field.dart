import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_app/src/generic_forms/form_field_widgets/nit_form_field.dart';

class NitDatetimePickerField extends NitFormField<DateTime> {
  const NitDatetimePickerField({
    super.key,
    required super.fieldDescriptor,
    required this.inputDescriptor,
    // required this.initialValue,
    // required this.onSaved,
  });

  final DatetimePickerInputDescriptor inputDescriptor;
  // final String? initialValue;
  // final Function(String? value) Function(BuildContext context) onSaved;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return InkWell(
    //   onTap: () => ,
    //   child: TextFormField(
    //     initialValue: ,
    //   ),
    // );

    return FormField<DateTime>(
      initialValue: initialValue(context),
      builder: (fieldState) {
        // InkWell(

        // child:
        return TextField(
          decoration: InputDecoration(labelText: inputDescriptor.displayTitle),
          controller: TextEditingController(
            text: fieldState.value != null
                ? DateFormat('dd.mm.yyyy').format(fieldState.value!)
                : null,
          ),
          readOnly: true,
          // enabled: false,
          onTap: () async {
            DateTime? date;
            await showCupertinoModalPopup(
              context: context,
              builder: (_) => Container(
                height: 190,
                color: Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  children: [
                    SizedBox(
                      height: 180,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: DateTime(2000),
                        onDateTimeChanged: (val) {
                          date = val;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // ),
            );

            if (date != null && context.mounted) {
              onChangedAction(context)(date);
              fieldState.didChange(date);
            }

            if (context.mounted) FocusScope.of(context).unfocus();
          },
        );
      },
    );
  }
}
