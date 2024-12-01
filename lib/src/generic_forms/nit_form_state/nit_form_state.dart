// import 'package:flutter/material.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:nit_app/nit_app.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'nit_form_state.g.dart';
// part 'nit_form_state.freezed.dart';

// @freezed
// abstract class NitFormStateModel with _$NitFormStateModel {
//   const factory NitFormStateModel({
//     required Map<String, dynamic> values,
//   }) = _NitFormStateModel;
// }

// @riverpod
// class NitFormState extends _$NitFormState {
//   @override
//   NitFormStateModel build(Key formKey) {
//     return NitFormStateModel(values: {});
//   }

//   init<Entity>(List<ModelFieldDescriptor<Entity>> fields, Entity? model) {
//     state = state.copyWith(
//         values: ;
//     // for (var e in fields) {
//     // ModelFieldDescriptor.valuesMap[_formKey]![e.name] =
//     //     ;
//   }

//   // setValue<T>(ModelFieldDescriptor field, T? value) {
//   //   if (state.values.containsKey(field)) ;
//   // }

//   prepareUpdatedModel() {}
// }
