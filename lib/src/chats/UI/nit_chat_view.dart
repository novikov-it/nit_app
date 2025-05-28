import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nit_app/nit_app.dart';
// import 'package:chatview/chatview.dart';
import 'package:nit_app/src/chats/UI/widget/nit_chat_widgets.dart';

class NitChatView extends HookConsumerWidget {
  final int chatId;
  final Map<String, Widget Function(NitChatMessage message)>?
      customMessageBuilders;

  const NitChatView({
    super.key,
    required this.chatId,
    this.customMessageBuilders,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = nitChatViewStateProvider(chatId);
    final chatState = ref.watch(provider);
    // final controller = chatState.controller;
    final viewState = chatState.viewState;

    if (viewState == ChatViewState.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    useEffect(() {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        chatState.scrollController
            .jumpTo(chatState.scrollController.position.maxScrollExtent);
      });

      return null;
    }, [chatState.messages]);

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: chatState.scrollController,
              itemCount: chatState.messages.length,
              itemBuilder: (context, index) {
                final msg = chatState.messages[index];
                return MessageBubble(
                  message: msg,
                  customMessageBuilders: customMessageBuilders,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ChatInputWidget(chatId: chatId),
          ),
        ],
      ),
    );
  }
}
