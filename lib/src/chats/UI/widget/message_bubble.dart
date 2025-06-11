part of 'nit_chat_widgets.dart';

class MessageBubble extends ConsumerWidget {
  final NitChatMessage message;
  final Map<String, Widget Function(NitChatMessage)>? customMessageBuilders;

  const MessageBubble({
    super.key,
    required this.message,
    this.customMessageBuilders,
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
                  if (message.attachmentIds?.isNotEmpty == true) ...[
                    MediaGrid(message: message),
                    const SizedBox(height: 8),
                  ],
                  if (message.text?.trim().isNotEmpty == true)
                    Text(
                      message.text!,
                      style: bubbleTheme.textStyle ??
                          TextStyle(
                            color: bubbleTheme.textColor,
                            fontSize: 16,
                            height: 1.3,
                          ),
                    ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${message.sentAt.toLocal().hour}:${message.sentAt.toLocal().minute.toString().padLeft(2, '0')}',
                        style: theme.timeTextStyle,
                      ),
                      const SizedBox(width: 6),
                      ReadIndicator(message: message),
                    ],
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
