import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';

import 'package:nit_app/src/chats/states/chat_ui_state/chat_ui_state.dart';

class NitChatView extends ConsumerWidget {
  final int chatId;
  final Map<String, Widget Function(NitChatMessage)>? customMessageBuilders;

  const NitChatView({
    super.key,
    required this.chatId,
    this.customMessageBuilders,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewState = ref.watch(
      chatStateProvider(chatId).select((state) => state.viewState),
    );

    if (viewState == ChatViewState.loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: ChatTheme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ChatMessagesList(
                    chatId: chatId,
                    customMessageBuilders: customMessageBuilders,
                  ),
                  // Should be consumer inside widgets?
                  Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      return ref.watch(
                        chatUIStateProvider(chatId).select(
                          (state) => state.showScrollToBottom,
                        ),
                      )
                          ? Positioned(
                              bottom: 16,
                              right: 16,
                              child: ScrollToBottomButton(chatId: chatId),
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return ref.watch(
                  chatStateProvider(chatId).select((state) => state.isTyping),
                )
                    ? const TypingIndicator()
                    : const SizedBox.shrink();
              },
            ),
            ChatInputWidget(chatId: chatId),
          ],
        ),
      ),
    );
  }
}
