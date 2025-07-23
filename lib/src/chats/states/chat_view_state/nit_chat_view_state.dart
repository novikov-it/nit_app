import 'dart:async';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nit_app/src/chats/UI/widget/attachment/state/attachment_state.dart';
import 'package:nit_app/src/chats/UI/widget/message_bubbles/widgets/voice_message/state/voice_message_bubble_state.dart';
import 'package:scrollview_observer/scrollview_observer.dart';
import 'package:nit_app/nit_app.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:developer';

part 'nit_chat_view_state.g.dart';
part 'nit_chat_view_state.freezed.dart';

enum ChatViewState { hasMessages, noData, loading, error }

@freezed
abstract class ChatStateModel with _$ChatStateModel {
  const factory ChatStateModel({
    required ChatViewState viewState,
    @Default([]) List<NitChatMessage> messages,
    int? lastReadMessageId, // последнее прочитанное сообщение в чате
    @Default(false) bool isTyping,
    required ScrollController scrollController,
    required ListObserverController observerController,
    required ChatScrollObserver chatObserver,
    NitChatMessage? repliedMessage,
    NitChatMessage? editedMessage,
  }) = _ChatStateModel;
}

@riverpod
class ChatState extends _$ChatState {
  StreamSubscription<SerializableModel>? _updatesSubscription;

  @override
  ChatStateModel build(int chatId) {
    ref.onDispose(() {
      _updatesSubscription?.cancel();
      state.scrollController.dispose();
      ref.invalidate(voiceMessageBubbleStateProvider);
    });

    // Инициализация контроллеров
    final scrollController = ScrollController();
    final observerController =
        ListObserverController(controller: scrollController);
    final chatObserver = ChatScrollObserver(observerController);

    _setupUpdatesStream();

    return ChatStateModel(
      viewState: ChatViewState.loading,
      scrollController: scrollController,
      observerController: observerController,
      chatObserver: chatObserver,
    );
  }

  void _setupUpdatesStream() {
    _updatesSubscription =
        nitToolsCaller!.nitChat.updatesStream(chatId: chatId).listen(
      (update) {
        if (update is NitChatInitialData) {
          ref.updateRepository(update.additionalEntities);

          state = state.copyWith(
            viewState: update.messages.isEmpty
                ? ChatViewState.noData
                : ChatViewState.hasMessages,
            messages: update.messages,
            lastReadMessageId: update.lastReadMessageId,
            isTyping: false,
          );
        } else if (update is NitChatMessage) {
          state.chatObserver.standby();

          final idx = state.messages.indexWhere((m) => m.id == update.id);
          if (idx != -1) {
            final updated = [...state.messages];
            updated[idx] = update;
            if (update.isDeleted) {
              updated.removeAt(idx);
            }

            state = state.copyWith(messages: updated);
          } else {
            if (update.isDeleted) {
              return;
            }
            state = state.copyWith(messages: [...state.messages, update]);
          }

          if (state.viewState == ChatViewState.noData) {
            state = state.copyWith(viewState: ChatViewState.hasMessages);
          }
        } else if (update is NitChatReadMessageEvent) {
          state = state.copyWith(lastReadMessageId: update.messageId);
        } else if (update is NitTypingMessageEvent) {
          if (update.userId != ref.signedInUserId) {
            state = state.copyWith(isTyping: update.isTyping);
          }
        }
      },
      onError: (Object error, StackTrace stackTrace) =>
          debugPrint('$error\n$stackTrace'),
      onDone: () => debugPrint("Chat Channel $chatId subscription done"),
    );
  }

  /// Отправка сообщения
  Future<void> sendMessage(
    String text, [
    NitMedia? additionalAtttachment,
  ]) async {
    state.chatObserver.standby();

    final attachment =
        await ref.read(attachmentStateProvider.notifier).uploadMedia();

    if (additionalAtttachment != null) {
      attachment.add(additionalAtttachment);
    }
    ref.saveModel(
      NitChatMessage(
        text: text,
        userId: ref.signedInUserId!,
        chatChannelId: chatId,
        sentAt: DateTime.now(),
        attachmentIds: attachment.map((e) => e.id).nonNulls.toList(),
        replyMessageId: state.repliedMessage?.id,
      ),
    );
    // nitToolsCaller!.nitChat.;

    ref.invalidate(attachmentStateProvider);
    setRepliedMessage(null);
  }

  /// Отправка сообщения
  Future<void> deleteMessage(NitChatMessage message) async {
    state.chatObserver.standby();

    await ref.saveModel(message.copyWith(isDeleted: true));
  }

  /// Отправка сообщения
  Future<void> editMessage(String text) async {
    if (state.editedMessage == null) {
      log('No edited message');
      return;
    }

    state.chatObserver.standby();

    await ref.saveModel(state.editedMessage!.copyWith(text: text));
    setEditedMessage(null);
  }

  bool get isEditMode => state.editedMessage != null;

  void typingToggle(bool isTyping) {
    log('Typing $isTyping in chat $chatId');
    nitToolsCaller!.nitChat.typingToggle(chatId, isTyping);
  }

  /// Добавление исторических сообщений
  void addHistoryMessages(List<NitChatMessage> historyMessages) {
    if (historyMessages.isNotEmpty) {
      state.chatObserver.standby(changeCount: historyMessages.length);
      state = state.copyWith(
        messages: [...historyMessages, ...state.messages],
      );
    }
  }

  // /// Обновление существующего сообщения
  // void updateMessage(NitChatMessage updatedMessage) {
  //   final updatedMessages = state.messages.map((msg) {
  //     return msg.id == updatedMessage.id ? updatedMessage : msg;
  //   }).toList();

  //   state = state.copyWith(messages: updatedMessages);
  // }

  // void handleStreamingMessage(NitChatMessage streamingMessage) {
  //   state.chatObserver.standby(mode: ChatScrollObserverHandleMode.generative);
  //   updateMessage(streamingMessage);
  // }

  void setRepliedMessage(NitChatMessage? message) {
    state = state.copyWith(repliedMessage: message, editedMessage: null);
  }

  void setEditedMessage(NitChatMessage? message) {
    state = state.copyWith(editedMessage: message, repliedMessage: null);
  }
}
