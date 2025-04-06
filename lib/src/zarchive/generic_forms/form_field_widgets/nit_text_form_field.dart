// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nit_app/src/generic_forms/form_field_widgets/nit_form_field.dart';

// import '../form_input_descriptor/form_input_descriptor.dart';
// import '../validator/validator.dart';

// class NitTextFormField<ValueType> extends NitFormField<ValueType> {
//   const NitTextFormField({
//     super.key,
//     required super.fieldDescriptor,
//     required this.inputDescriptor,
//     // required this.initialValue,
//     // required this.onSaved,
//   });

//   final TextInputDescriptor inputDescriptor;
//   // final dynamic initialValue;
//   // final Function(String? value) Function(BuildContext context) onSaved;

//   String? _toString(ValueType? value) {
//     if (value is String) return value;

//     if (value == null) return null;

//     return value.toString();
//   }

//   ValueType? _fromString(String? inputValue) {
//     if (inputValue == null || inputValue.isEmpty) return null;

//     if (ValueType == String) {
//       return inputValue as ValueType;
//     }
//     if (ValueType == int) {
//       return int.parse(inputValue) as ValueType;
//     } else if (ValueType == double) {
//       return double.parse(inputValue) as ValueType;
//     }

//     throw UnimplementedError();
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return TextFormField(
//       initialValue: _toString(initialValue(context)),
//       // // initialValue,
//       // initialValue != null ? '$initialValue' : '',
//       decoration: InputDecoration(
//         labelText: inputDescriptor.displayTitle,
//       ),
//       validator: (inputValue) {
//         if (inputDescriptor.isRequired &&
//             (inputValue == null || inputValue.isEmpty)) {
//           return "Обязательное поле";
//         }

//         for (var validator in inputDescriptor.validators ?? <Validator>[]) {
//           final t = validator.validate(_fromString(inputValue));

//           if (t != null) return t;
//         }

//         return null;
//       },
//       onChanged: (inputValue) =>
//           onChangedAction(context)(_fromString(inputValue)),
//       // onSaved: onSaved(context),
//     );
//   }
// }
