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
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isMe ? theme.primaryColor : theme.incomingBubbleColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft: Radius.circular(isMe ? 12 : 4),
              bottomRight: Radius.circular(isMe ? 4 : 12),
            ),
            boxShadow: [
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
                      style: TextStyle(
                        color: isMe
                            ? theme.outgoingBubbleTextColor
                            : theme.incomingBubbleTextColor,
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
                        style: TextStyle(
                          color: theme.timeTextColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
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
