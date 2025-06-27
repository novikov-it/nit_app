part of '../nit_chat_widgets.dart';

class GroupMessageBubble extends HookConsumerWidget {
  final NitChatMessage message;
  final Map<String, Widget Function(NitChatMessage)>? customMessageBuilders;
  final int chatId;

  const GroupMessageBubble({
    super.key,
    required this.message,
    this.customMessageBuilders,
    required this.chatId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ChatTheme.of(context);
    final isMe = message.userId == ref.signedInUserId;
    final bubbleTheme = isMe ? theme.outgoingBubble : theme.incomingBubble;

    final customWidget = customMessageBuilders != null &&
            message.customMessageType?.type != null
        ? customMessageBuilders![message.customMessageType!.type]?.call(message)
        : null;
    //TODO: сомнительно
    final senderNameFuture = useMemoized(
      () => isMe ? null : theme.groupMessageTheme.getSenderName(message.userId),
      [isMe, message.userId],
    );

    final senderNameSnapshot = useFuture(senderNameFuture);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.7,
        ),
        child: Container(
          margin: bubbleTheme.margin,
          padding: bubbleTheme.padding,
          decoration: BoxDecoration(
            color: bubbleTheme.backgroundColor,
            borderRadius:
                BorderRadius.all(Radius.circular(bubbleTheme.borderRadius)),
            border: bubbleTheme.border,
            boxShadow: bubbleTheme.boxShadow ??
                [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
          ),
          child: customWidget ??
              Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (message.replyMessageId != null)
                    ReplyIndicator(
                      repliedMessageId: message.replyMessageId!,
                      chatId: chatId,
                    ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          isMe ? 'Вы' : senderNameSnapshot.data ?? 'n',
                          style: theme.groupMessageTheme.senderNameTextStyle,
                        ),
                      ),
                      const Gap(8),
                      MessageTime(message: message),
                    ],
                  ),
                  if (message.attachmentIds?.isNotEmpty == true) ...[
                    const Gap(8),
                    MediaGrid(message: message),
                    const Gap(8),
                  ],
                  const Gap(8),
                  if (message.text?.isOnlyEmoji == true &&
                      (message.attachmentIds == null ||
                          message.attachmentIds?.isEmpty == true))
                    EmojiBubble(message: message)
                  else if (message.text?.trim().isNotEmpty == true)
                    Text(
                      message.text!,
                      style: bubbleTheme.textStyle,
                    ),
                ],
              ),
        ),
      ),
    );
  }
}
