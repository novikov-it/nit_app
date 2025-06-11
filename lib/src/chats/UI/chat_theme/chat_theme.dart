import 'package:flutter/material.dart';

class ChatBubbleThemeData {
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final TextStyle? textStyle;

  const ChatBubbleThemeData({
    required this.backgroundColor,
    required this.textColor,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    this.margin = const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    this.border,
    this.boxShadow,
    this.textStyle,
  });

  ChatBubbleThemeData copyWith({
    Color? backgroundColor,
    Color? textColor,
    double? borderRadius,
    EdgeInsets? padding,
    EdgeInsets? margin,
    BoxBorder? border,
    List<BoxShadow>? boxShadow,
    TextStyle? textStyle,
  }) {
    return ChatBubbleThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      border: border ?? this.border,
      boxShadow: boxShadow ?? this.boxShadow,
      textStyle: textStyle ?? this.textStyle,
    );
  }
}

class ChatInputThemeData {
  final Color backgroundColor;
  final Color textColor;
  final Color hintColor;
  final Color cursorColor;
  final double borderRadius;
  final EdgeInsets padding;
  final InputBorder? border;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;

  const ChatInputThemeData({
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black87,
    this.hintColor = Colors.grey,
    this.cursorColor = Colors.blue,
    this.borderRadius = 24.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.border,
    this.textStyle,
    this.hintStyle,
  });
}

class ChatThemeData {
  static ChatThemeData get _default => const ChatThemeData._();

  // Приватный конструктор для дефолтного экземпляра
  const ChatThemeData._({
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.grey,
    this.errorColor = Colors.red,
    this.dividerColor = const Color(0xFFE0E0E0),
    ChatBubbleThemeData? incomingBubble,
    ChatBubbleThemeData? outgoingBubble,
    ChatInputThemeData? inputTheme,
    TextStyle? timeTextStyle,
    this.timeTextColor = Colors.grey,
    Color? sentStatusColor,
    Color? deliveredStatusColor,
    Color? readStatusColor,
    this.typingIndicatorColor = Colors.blue,
    this.typingIndicatorSize = 12.0,
  })  : incomingBubble = incomingBubble ??
            const ChatBubbleThemeData(
              backgroundColor: Colors.white,
              textColor: Colors.black87,
              borderRadius: 12.0,
            ),
        outgoingBubble = outgoingBubble ??
            const ChatBubbleThemeData(
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              borderRadius: 12.0,
            ),
        inputTheme = inputTheme ?? const ChatInputThemeData(),
        timeTextStyle = timeTextStyle ??
            const TextStyle(
              fontSize: 10.0,
              color: Colors.grey,
            ),
        sentStatusColor = sentStatusColor ?? Colors.grey,
        deliveredStatusColor = deliveredStatusColor ?? Colors.grey,
        readStatusColor = readStatusColor ?? Colors.blue;

  // General
  final Color backgroundColor;
  final Color dividerColor;
  final Color primaryColor;
  final Color secondaryColor;
  final Color errorColor;

  // Bubbles
  final ChatBubbleThemeData incomingBubble;
  final ChatBubbleThemeData outgoingBubble;

  // Input
  final ChatInputThemeData inputTheme;

  // Time
  final TextStyle timeTextStyle;
  final Color timeTextColor;

  // Status
  final Color sentStatusColor;
  final Color deliveredStatusColor;
  final Color readStatusColor;

  // Typing indicator
  final Color typingIndicatorColor;
  final double typingIndicatorSize;

  const ChatThemeData({
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.grey,
    this.errorColor = Colors.red,
    this.dividerColor = const Color(0xFFE0E0E0),
    ChatBubbleThemeData? incomingBubble,
    ChatBubbleThemeData? outgoingBubble,
    ChatInputThemeData? inputTheme,
    TextStyle? timeTextStyle,
    this.timeTextColor = Colors.grey,
    Color? sentStatusColor,
    Color? deliveredStatusColor,
    Color? readStatusColor,
    this.typingIndicatorColor = Colors.blue,
    this.typingIndicatorSize = 12.0,
  })  : incomingBubble = incomingBubble ??
            const ChatBubbleThemeData(
              backgroundColor: Colors.white,
              textColor: Colors.black87,
              borderRadius: 12.0,
            ),
        outgoingBubble = outgoingBubble ??
            const ChatBubbleThemeData(
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              borderRadius: 12.0,
            ),
        inputTheme = inputTheme ?? const ChatInputThemeData(),
        timeTextStyle = timeTextStyle ??
            const TextStyle(
              fontSize: 10.0,
              color: Colors.grey,
            ),
        sentStatusColor = sentStatusColor ?? Colors.grey,
        deliveredStatusColor = deliveredStatusColor ?? Colors.grey,
        readStatusColor = readStatusColor ?? Colors.blue;

  ChatThemeData copyWith({
    Color? backgroundColor,
    Color? primaryColor,
    Color? secondaryColor,
    Color? errorColor,
    Color? dividerColor,
    ChatBubbleThemeData? incomingBubble,
    ChatBubbleThemeData? outgoingBubble,
    ChatInputThemeData? inputTheme,
    TextStyle? timeTextStyle,
    Color? timeTextColor,
    Color? sentStatusColor,
    Color? deliveredStatusColor,
    Color? readStatusColor,
    Color? typingIndicatorColor,
    double? typingIndicatorSize,
  }) {
    return ChatThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      errorColor: errorColor ?? this.errorColor,
      dividerColor: dividerColor ?? this.dividerColor,
      incomingBubble: incomingBubble ?? this.incomingBubble,
      outgoingBubble: outgoingBubble ?? this.outgoingBubble,
      inputTheme: inputTheme ?? this.inputTheme,
      timeTextStyle: timeTextStyle ?? this.timeTextStyle,
      timeTextColor: timeTextColor ?? this.timeTextColor,
      sentStatusColor: sentStatusColor ?? this.sentStatusColor,
      deliveredStatusColor: deliveredStatusColor ?? this.deliveredStatusColor,
      readStatusColor: readStatusColor ?? this.readStatusColor,
      typingIndicatorColor: typingIndicatorColor ?? this.typingIndicatorColor,
      typingIndicatorSize: typingIndicatorSize ?? this.typingIndicatorSize,
    );
  }
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
