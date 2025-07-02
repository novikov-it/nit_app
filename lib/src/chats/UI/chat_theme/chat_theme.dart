import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_theme.freezed.dart';

enum ChatBubbleType { personal, group }

@freezed
class ChatBubbleThemeData with _$ChatBubbleThemeData {
  const factory ChatBubbleThemeData({
    required Color backgroundColor,
    required Color textColor,
    @Default(12.0) double borderRadius,
    @Default(EdgeInsets.symmetric(horizontal: 16, vertical: 10))
    EdgeInsets padding,
    @Default(EdgeInsets.symmetric(vertical: 4, horizontal: 8))
    EdgeInsets margin,
    BoxBorder? border,
    List<BoxShadow>? boxShadow,
    TextStyle? textStyle,
  }) = _ChatBubbleThemeData;
}

@freezed
class ChatInputThemeData with _$ChatInputThemeData {
  const factory ChatInputThemeData({
    @Default(Colors.white) Color backgroundColor,
    @Default(Colors.black87) Color textColor,
    @Default(Colors.grey) Color hintColor,
    @Default(Colors.blue) Color cursorColor,
    @Default(24.0) double borderRadius,
    @Default(EdgeInsets.symmetric(horizontal: 0, vertical: 12))
    EdgeInsets padding,
    InputBorder? border,
    TextStyle? textStyle,
    TextStyle? hintStyle,
  }) = _ChatInputThemeData;
}

@freezed
class GroupMessageTheme with _$GroupMessageTheme {
  const factory GroupMessageTheme({
    required Future<String?> Function(int userId) getSenderName,
    @Default(TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
      color: Color(0xFF222222),
    ))
    TextStyle senderNameTextStyle,
  }) = _GroupMessageTheme;
}

@freezed
class MainTheme with _$MainTheme {
  const factory MainTheme({
    @Default(Color(0xFFF5F5F5)) Color backgroundColor,
    @Default(Colors.blue) Color primaryColor,
    @Default(Colors.grey) Color secondaryColor,
    @Default(Colors.red) Color errorColor,
    @Default(Color(0xFFE0E0E0)) Color dividerColor,
    @Default(Colors.grey) Color timeTextColor,
    @Default(Colors.grey) Color sentStatusColor,
    @Default(Colors.grey) Color deliveredStatusColor,
    @Default(Colors.blue) Color readStatusColor,
    @Default(Colors.blue) Color typingIndicatorColor,
    @Default(TextStyle(fontSize: 10.0, color: Colors.grey))
    TextStyle timeTextStyle,
    @Default(12.0) double typingIndicatorSize,
  }) = _MainTheme;
}

@freezed
class Settings with _$Settings {
  const factory Settings({
    @Default(ChatBubbleType.personal) ChatBubbleType chatBubbleType,
    @Default(true) bool showScrollToBottomButton,
  }) = _Settings;
}

@freezed
class ChatThemeData with _$ChatThemeData {
  const factory ChatThemeData({
    @Default(MainTheme()) MainTheme mainTheme,
    @Default(Settings()) Settings settings,
    @Default(ChatBubbleThemeData(
      backgroundColor: Colors.white,
      textColor: Colors.black87,
      borderRadius: 12.0,
    ))
    ChatBubbleThemeData incomingBubble,
    @Default(ChatBubbleThemeData(
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      borderRadius: 12.0,
    ))
    ChatBubbleThemeData outgoingBubble,
    @Default(ChatInputThemeData()) ChatInputThemeData inputTheme,
    @Default(GroupMessageTheme(
      getSenderName: _defaultGetSenderName,
    ))
    GroupMessageTheme groupMessageTheme,
  }) = _ChatThemeData;
}

// Функция по умолчанию для получения имени отправителя
Future<String?> _defaultGetSenderName(int id) => Future.value('User $id');

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
    return result?.data ?? const ChatThemeData();
  }

  @override
  bool updateShouldNotify(ChatTheme oldWidget) => data != oldWidget.data;
}

class ChatThemeProvider extends StatelessWidget {
  final Widget child;
  final ChatThemeData? themeData;

  const ChatThemeProvider({
    super.key,
    required this.child,
    this.themeData,
  });

  @override
  Widget build(BuildContext context) {
    return ChatTheme(
      data: themeData ?? const ChatThemeData(),
      child: child,
    );
  }
}
