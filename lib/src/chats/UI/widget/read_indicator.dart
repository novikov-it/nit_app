part of 'nit_chat_widgets.dart';

class ReadIndicator extends ConsumerWidget {
  final NitChatMessage message;

  const ReadIndicator({super.key, required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId = ref.signedInUserId;
    if (message.userId != currentUserId) return const SizedBox.shrink();
    final lastReadMessageId = ref.watch(
      chatStateProvider(message.chatChannelId)
          .select((state) => state.lastReadMessageId),
    );

    final theme = ChatTheme.of(context);

    Color color;
    if (lastReadMessageId != null && lastReadMessageId >= message.id!) {
      color = theme.readStatusColor;
    } else {
      color = theme.sentStatusColor;
    }

    return Icon(
      Icons.done_all,
      size: 12,
      color: color,
    );
  }
}
