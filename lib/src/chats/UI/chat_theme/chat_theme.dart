import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatThemeProvider = Provider<ChatTheme>((ref) {
  return ChatTheme(
    primaryColor: Colors.blue,
    backgroundColor: Colors.grey[200]!,
  );
});

class ChatTheme {
  final Color primaryColor;
  final Color backgroundColor;

  const ChatTheme({
    required this.primaryColor,
    required this.backgroundColor,
  });
}
