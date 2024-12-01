import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../form_input_descriptor/form_input_descriptor.dart';

abstract class ModelFieldDescriptor<Entity> implements Enum {
  final FormInputDescriptor inputDescriptor;

  ModelFieldDescriptor({
    required this.inputDescriptor,
  });

  Entity? save(Entity? model, Map<String, dynamic> values) => null;

  dynamic defaultValue(
    WidgetRef ref,
  );

  dynamic initialValue(
    WidgetRef ref,
    Entity? model,
  );
}
