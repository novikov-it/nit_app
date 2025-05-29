import 'package:flutter/material.dart';

class ChatThemeData {
  static const ChatThemeData _default = ChatThemeData();
  final Color primaryColor;
  final Color backgroundColor;
  final Color incomingBubbleColor;
  final Color outgoingBubbleTextColor;
  final Color incomingBubbleTextColor;
  final Color timeTextColor;

  const ChatThemeData({
    this.primaryColor = Colors.blue,
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.incomingBubbleColor = Colors.white,
    this.outgoingBubbleTextColor = Colors.white,
    this.incomingBubbleTextColor = Colors.black,
    this.timeTextColor = Colors.grey,
  });
}

class ChatTheme extends InheritedWidget {
  final ChatThemeData data;

  const ChatTheme({
    super.key,
    required this.data,
    required super.child,
  });

  static ChatThemeData of(BuildContext context) {
    final ChatTheme? result =
        context.dependOnInheritedWidgetOfExactType<ChatTheme>();
    return result?.data ?? ChatThemeData._default;
  }

  @override
  bool updateShouldNotify(ChatTheme oldWidget) => data != oldWidget.data;
}

class ChatThemeProvider extends StatelessWidget {
  final ChatThemeData data;
  final Widget child;

  const ChatThemeProvider({
    super.key,
    required this.child,
    ChatThemeData? themeData,
  }) : data = themeData ?? const ChatThemeData();

  @override
  Widget build(BuildContext context) {
    return ChatTheme(
      data: data,
      child: child,
    );
  }
}
