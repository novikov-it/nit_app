part of '../validator.dart';

class StringValidator implements Validator<String> {
  const StringValidator({
    this.minCharacters,
    this.maxCharacters,
  });

  final int? minCharacters;
  final int? maxCharacters;

  @override
  validate(String? value) {
    if (value == null || value.isEmpty) {}

    if (minCharacters != null &&
        value != null &&
        value.length < minCharacters!) {
      return "Введите не менее $minCharacters символов";
    }

    if (maxCharacters != null &&
        value != null &&
        value.length > maxCharacters!) {
      return "Введите не более $maxCharacters символов";
    }

    return null;
  }
}
