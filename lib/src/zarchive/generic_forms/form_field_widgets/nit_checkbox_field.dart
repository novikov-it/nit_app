// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../form_input_descriptor/form_input_descriptor.dart';
// import 'nit_form_field.dart';

// class NitCheckboxField extends NitFormField<bool> {
//   const NitCheckboxField({
//     super.key,
//     required super.fieldDescriptor,
//     required this.inputDescriptor,
//     // required this.initialValue,
//     // required this.onSaved,
//   });

//   // final ModelFieldDescriptor fieldDescriptor;
//   final CheckboxInputDescriptor inputDescriptor;
//   // final bool? initialValue;
//   // final Function(bool? value) Function(BuildContext context) onSaved;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // return Row(
//     //   children: [
//     //     Checkbox(
//     //       value: ref
//     //           .watch(nitFormStateProvider(formKey))
//     //           .values[fieldDescriptor.name],
//     //       onChanged: (value) {
//     //         ref
//     //             .read(nitFormStateProvider(formKey).notifier)
//     //             .setValue<bool>(fieldDescriptor, value);
//     //       },
//     //     ),
//     //     Text(
//     //       inputDescriptor.displayTitle,
//     //     ),
//     //   ],
//     // );

//     return FormField<bool>(
//       // onSaved: onSaved(context),
//       initialValue: initialValue(context) ?? false,
//       builder: (fieldState) {
//         // field.value
//         return Row(
//           children: [
//             Checkbox(
//               value: fieldState.value,
//               onChanged: (value) {
//                 onChangedAction(context)(value);
//                 fieldState.didChange(value);
//               },
//             ),
//             if (inputDescriptor.displayTitle != null)
//               Text(
//                 inputDescriptor.displayTitle!,
//               ),
//           ],
//         );
//       },
//     );
//   }
// }
