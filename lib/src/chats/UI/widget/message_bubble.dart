part of 'nit_chat_widgets.dart';

class MessageBubble extends HookConsumerWidget {
  final NitChatMessage message;

  const MessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debounce = useRef<Timer?>(null);

    final isMe = message.userId == ref.signedInUserId;
    final bubble = _MessageBubbleItem(message: message);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: isMe
          ? bubble
          : VisibilityDetector(
              key: Key('message-${message.id}'),
              onVisibilityChanged: (info) {
                if (info.visibleFraction > 0.5) {
                  debounce.value
                      ?.cancel(); //TODO: отладить дебаунсер. Сейчас иногда лагает
                  debounce.value = Timer(const Duration(milliseconds: 300), () {
                    ref
                        .read(nitChatViewStateProvider(message.chatChannelId)
                            .notifier)
                        .markAsReadMessage(message);
                  });
                }
              },
              child: bubble,
            ),
    );
  }
}

class _MessageBubbleItem extends ConsumerWidget {
  const _MessageBubbleItem({
    required this.message,
  });

  final NitChatMessage message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.read(chatThemeProvider);
    final isMe = message.userId == ref.signedInUserId;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width * 0.7,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isMe ? theme.primaryColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (message.attachmentIds != null &&
                message.attachmentIds!.isNotEmpty) ...[
              MediaGrid(
                message: message,
              ),
              const SizedBox(height: 8),
            ],
            Text(
              message.text ?? '',
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${message.sentAt.toLocal().hour}:${message.sentAt.toLocal().minute.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    color: isMe ? Colors.white70 : Colors.black54,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 4),
                ReadIndicator(message: message),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
