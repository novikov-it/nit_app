import 'package:chatview/chatview.dart' as chatview;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';

class NitChatView extends ConsumerStatefulWidget {
  const NitChatView({
    super.key,
    // required this.serverpodChatController,
    // required this.currentUser,
    required this.channel,
  });

  // final serverpod_chat.ChatController serverpodChatController;
  // final chatview.ChatUser currentUser;
  final String channel;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NitChatViewState();
}

class _NitChatViewState extends ConsumerState<NitChatView> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatControllerStateProvider(widget.channel));

    return chatview.ChatView(
      chatController: state.chatviewController,
      onSendTap: ref
          .read(chatControllerStateProvider(widget.channel).notifier)
          .sendMessage,
      chatViewState: state.isReady
          ?
          // state.hasMessages
          // ?
          chatview.ChatViewState.hasMessages
          // : chatview.ChatViewState.noData
          : chatview.ChatViewState.loading,
      chatBackgroundConfig: chatview.ChatBackgroundConfiguration(
        backgroundColor: context.colorScheme.surface,
      ),
    );
  }
}
