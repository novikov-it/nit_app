import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';

import 'package:nit_app/src/chats/UI/widget/message_bubbles/widgets/bubble_overlay.dart';
import 'package:nit_ui_kit/nit_ui_kit.dart';
// import 'package:nit_app/src/chats/UI/widget/message_bubbles/widgets/bubble_overlay.dart';
import 'package:swipe_to/swipe_to.dart';

class MessageBubble extends ConsumerWidget {
  const MessageBubble({
    super.key,
    required this.chatId,
    required this.message,
    this.customMessageBuilders,
  });

  final int chatId;
  final NitChatMessage message;
  final Map<String, Widget Function(NitChatMessage)>? customMessageBuilders;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatNotifier = ref.read(chatStateProvider(chatId).notifier);
    final theme = ChatTheme.of(context);
    final isMe = message.userId == ref.signedInUserId;

    final enableMessageOverlay = theme.settings.enableMessageOverlay;

    return ConditionalParentWidget(
      condition: enableMessageOverlay,
      parentBuilder: (Widget child) => BubbleOverlay(
        isMe: isMe,
        onReply: () {
          chatNotifier.setRepliedMessage(message);
          FocusScope.of(context).requestFocus();
        },
        onCopy: () {
          // Clipboard.setData(ClipboardData(text: message.text));
        },
        onDelete: () async {
          await chatNotifier.deleteMessage(message);
          chatNotifier.setRepliedMessage(null);
          chatNotifier.setEditedMessage(null);
        },
        onEdit: () {
          chatNotifier.setEditedMessage(message);
          FocusScope.of(context).requestFocus();
        },
        onReact: (emoji) {
          // chatNotifier.reactToMessage(message.id!, emoji);
        },
        child: child,
      ),
      child: SwipeTo(
        onRightSwipe: !isMe
            ? (details) {
                chatNotifier.setRepliedMessage(message);
                FocusScope.of(context).requestFocus();
              }
            : null,
        onLeftSwipe: isMe
            ? (details) {
                chatNotifier.setRepliedMessage(message);
                FocusScope.of(context).requestFocus();
              }
            : null,
        child: ChatBubbleType.personal == theme.settings.chatBubbleType
            ? PersonalMessageBubble(
                message: message,
                customMessageBuilders: customMessageBuilders,
                chatId: chatId,
              )
            : GroupMessageBubble(
                message: message,
                customMessageBuilders: customMessageBuilders,
                chatId: chatId,
              ),
      ),
    );
  }
}
