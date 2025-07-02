import 'package:nit_app/nit_app.dart';

extension NitBackendFilterExtension<T> on NitBackendFilter<T> {
  bool filterUpdate(
    Map<String, dynamic> jsonSerialization, {
    bool outerNegate = false,
  }) {
    bool shouldNegate = negate != outerNegate;

    if (type == NitBackendFilterType.and || type == NitBackendFilterType.or) {
      if (children == null || children!.isEmpty) {
        return true; // или другая логика для пустых групп
      }

      // Собираем детей, если нужно - с отрицанием
      final expressions = children!.map(
        (child) => child.filterUpdate(
          jsonSerialization,
          outerNegate: shouldNegate,
        ),
      );

      // Используем OR если фильтр такого типа или если это отрицание AND
      return expressions.reduce((a, b) =>
          shouldNegate != (type == NitBackendFilterType.or) ? a || b : a && b);
    }

    return _valueExpression(
      jsonSerialization,
      negate: shouldNegate,
    );
  }

  bool _isType<T1, T2>(Type t) => t == T1 || t == T2;

  bool _isNullableType(Type t) => _isType<T, T?>(t);

  bool _valueExpression(
    Map<String, dynamic> jsonSerialization, {
    bool negate = false,
  }) {
    final modelValue =
        NitToolsClient.protocol.deserialize<T?>(jsonSerialization[fieldName]);

    if (type == NitBackendFilterType.equals) {
      return negate != (modelValue == fieldValue);
    }

    if (_isNullableType(int)) {
      return negate !=
          switch (type) {
            NitBackendFilterType.greaterThan => fieldValue == null ||
                (modelValue != null &&
                    ((modelValue as int) > (fieldValue as int))),
            NitBackendFilterType.greaterThanOrEquals => fieldValue == null ||
                (modelValue != null &&
                    ((modelValue as int) >= (fieldValue as int))),
            NitBackendFilterType.lessThan => fieldValue == null ||
                (modelValue != null &&
                    ((modelValue as int) < (fieldValue as int))),
            NitBackendFilterType.lessThanOrEquals => fieldValue == null ||
                (modelValue != null &&
                    ((modelValue as int) <= (fieldValue as int))),
            _ => throw Exception('Unsupported filter type'),
          };
    } else if (_isNullableType(double)) {
      return negate !=
          switch (type) {
            NitBackendFilterType.greaterThan => fieldValue == null ||
                (modelValue != null &&
                    ((modelValue as double) > (fieldValue as double))),
            NitBackendFilterType.greaterThanOrEquals => fieldValue == null ||
                (modelValue != null &&
                    ((modelValue as double) >= (fieldValue as double))),
            NitBackendFilterType.lessThan => fieldValue == null ||
                (modelValue != null &&
                    ((modelValue as double) < (fieldValue as double))),
            NitBackendFilterType.lessThanOrEquals => fieldValue == null ||
                (modelValue != null &&
                    ((modelValue as double) <= (fieldValue as double))),
            _ => throw Exception('Unsupported filter type'),
          };
    } else if (_isNullableType(DateTime)) {
      return negate !=
          switch (type) {
            NitBackendFilterType.greaterThan => fieldValue == null ||
                (modelValue != null &&
                    ((modelValue as DateTime)
                        .isAfter((fieldValue as DateTime)))),
            NitBackendFilterType.greaterThanOrEquals => fieldValue == null ||
                (modelValue != null &&
                    (modelValue == fieldValue ||
                        ((modelValue as DateTime)
                            .isAfter((fieldValue as DateTime))))),
            NitBackendFilterType.lessThan => fieldValue == null ||
                (modelValue != null &&
                    ((modelValue as DateTime)
                        .isBefore((fieldValue as DateTime)))),
            NitBackendFilterType.lessThanOrEquals => fieldValue == null ||
                (modelValue != null &&
                    (modelValue == fieldValue ||
                        ((modelValue as DateTime)
                            .isBefore((fieldValue as DateTime))))),
            _ => throw Exception('Unsupported filter type'),
          };
    } else if (_isNullableType(String)) {
      return negate !=
          switch (type) {
            NitBackendFilterType.ilike => fieldValue == null ||
                (modelValue != null &&
                    _ilikeMatch(modelValue as String, fieldValue as String)),
            _ => throw Exception('Unsupported filter type'),
          };
    }

    throw Exception('Unsupported filter type');
  }

  bool _ilikeMatch(String value, String pattern) {
    // Экранируем спецсимволы в RegExp, кроме % и _
    String escaped = RegExp.escape(pattern)
        .replaceAll('%', '<<<PERCENT>>>') // временные метки
        .replaceAll('_', '<<<UNDERSCORE>>>');

    // Преобразуем % и _ в шаблоны RegExp
    String regexPattern = escaped
        .replaceAll('<<<PERCENT>>>', '.*') // % → .*
        .replaceAll('<<<UNDERSCORE>>>', '.'); // _ → .

    // Добавляем начало и конец строки для точного совпадения
    RegExp regex =
        RegExp('^$regexPattern\$', caseSensitive: false, dotAll: true);

    return regex.hasMatch(value);
  }
}
