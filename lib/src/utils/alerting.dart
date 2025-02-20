import 'package:flutter/material.dart';

class NitAlerts {
  static Widget Function(Object error, StackTrace stackTrace) reportError(
          String uiExplanationText) =>
      (Object error, StackTrace stackTrace) {
        debugPrint(error.toString());
        debugPrintStack(stackTrace: stackTrace);
        return Text(uiExplanationText);
      };
}
