import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'form_field_dispatcher.dart';
import '../form_input_descriptor/form_input_descriptor.dart';

abstract class ModelFieldDescriptor<Entity> implements Enum {
  final FormInputDescriptor inputDescriptor;

  static Map<Key, Map<String, dynamic>> valuesMap = {};

  ModelFieldDescriptor({
    required this.inputDescriptor,
  });

  Entity? save(Entity? model, Map<String, dynamic> values) => null;

  // ModelField<T> get field;

  dynamic initialValue(WidgetRef ref, Entity? model);

  FormFieldDispatcher prepareField();
}
