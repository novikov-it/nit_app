import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_app/src/generic_forms/generic_forms.dart';

class NitDropdownFormField<Entity> extends ConsumerWidget {
  const NitDropdownFormField({
    super.key,
    required this.inputDescriptor,
    required this.initialValue,
    required this.onSaved,
  });

  final DropdownInputDescriptor<Entity> inputDescriptor;
  final Entity? initialValue;
  final Function(Entity? value) Function(BuildContext context) onSaved;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return inputDescriptor.optionsList(ref).when(
          error: (error, stackTrace) =>
              const Text('Не удалось подгрузить опции'),
          loading: () => const CircularProgressIndicator(),
          data: (data) => DropdownButtonFormField<Entity>(
            value: initialValue,
            items: [
              DropdownMenuItem<Entity>(
                value: null,
                child: Text(
                  inputDescriptor.nullLabel ?? 'Выберите из списка',
                ),
              ),
              ...data.map(
                (e) => DropdownMenuItem<Entity>(
                  value: e,
                  child: Text(
                    // fieldDescriptor.labelExtractor(e),
                    inputDescriptor.labelExtractor != null
                        ? e != null
                            ? inputDescriptor.labelExtractor!(ref, e)
                            : 'Объект не найден'
                        : inputDescriptor.labelField!.initialValue(ref, e),
                  ),
                ),
              ),
            ],
            onChanged: onSaved(context),
          ),
        );
  }
}
