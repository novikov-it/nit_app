import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nit_app/src/chats/UI/widget/message_bubbles/message_bubble.dart';

import 'package:nit_app/src/chats/states/chat_ui_state/chat_ui_state.dart';
import 'package:scrollview_observer/scrollview_observer.dart';
import 'package:nit_app/nit_app.dart';

class ChatMessagesList extends HookConsumerWidget {
  final int chatId;
  final Map<String, Widget Function(NitChatMessage)>? customMessageBuilders;

  const ChatMessagesList({
    super.key,
    required this.chatId,
    this.customMessageBuilders,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatStateProvider(chatId));
    final uiNotifier = ref.watch(chatUIStateProvider(chatId).notifier);

    if (chatState.viewState == ChatViewState.noData) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('Нет сообщений'),
          ],
        ),
      );
    }
    useEffect(() {
      // Для того чтобы стриггерить uiNotifier.handleVisibilityChange
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final chatState = ref.read(chatStateProvider(chatId));
        chatState.observerController.controller!.jumpTo(1);
      });
      return null;
    }, [chatId]);

    return ListViewObserver(
      controller: chatState.observerController,
      onObserve: uiNotifier.handleVisibilityChange,
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollUpdateNotification &&
              notification.scrollDelta != null &&
              notification.scrollDelta! > 0) {
            FocusScope.of(context).unfocus();
          }
          return false;
        },
        child: ListView.builder(
          physics: ChatObserverBouncingScrollPhysics(
            observer: chatState.chatObserver,
          ),
          controller: chatState.scrollController,
          reverse: true,
          itemCount: chatState.messages.length,
          cacheExtent: 1000,
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemBuilder: (context, index) {
            final reversedIndex = chatState.messages.length - 1 - index;
            final message = chatState.messages[reversedIndex];

            return MessageBubble(
              key: ValueKey('message-${message.id}'),
              chatId: chatId,
              message: message,
              customMessageBuilders: customMessageBuilders,
            );
          },
        ),
      ),
    );
  }
}
