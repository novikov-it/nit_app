part of 'nit_chat_widgets.dart';

class ReadIndicator extends ConsumerWidget {
  final NitChatMessage message;

  const ReadIndicator({super.key, required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId = ref.signedInUserId;
    if (message.userId != currentUserId) return const SizedBox.shrink();
    final lastReadMessageId = ref.watch(
        nitChatViewStateProvider(message.chatChannelId)
            .select((state) => state.lastReadMessageId));

    return Icon(
      Icons.done_all,
      size: 12,
      color: lastReadMessageId != null && lastReadMessageId >= message.id!
          ? Colors.pink
          : Colors.grey,
    );
  }
}
