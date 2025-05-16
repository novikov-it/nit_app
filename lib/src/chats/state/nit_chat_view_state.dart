import 'dart:async';

// import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_app/src/chats/UI/widget/attachment/state/attachment_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart';
import 'dart:developer';

part 'nit_chat_view_state.freezed.dart';
part 'nit_chat_view_state.g.dart';

/// Types of states
enum ChatViewState { hasMessages, noData, loading, error }

@freezed
abstract class NitChatViewStateModel with _$NitChatViewStateModel {
  const factory NitChatViewStateModel({
    required ScrollController scrollController,
    required ChatViewState viewState,
    @Default([]) List<NitChatMessage> messages,
    int? lastReadMessageId,
    @Default(false) bool isTyping,
    // required ChatController controller,
  }) = _NitChatViewStateModel;
}

// extension on NitChatMessage {
//   NitChatMessage get toChatViewMessage => Message(
//         message: text ?? '-',
//         createdAt: sentAt.toLocal(),
//         sentBy: userId.toString(),
//         status: MessageStatus.delivered,
//       );
// }

// extension on UserInfo {
//   ChatUser get toChatViewUser => ChatUser(
//         id: id.toString(),
//         name: userName ?? userIdentifier,
//         profilePhoto: imageUrl,
//       );
// }

@riverpod
class NitChatViewState extends _$NitChatViewState {
  // late final ChatController _chatController;

  static late final List<UserInfo> Function(Ref ref, List<int> userIds)
      prepareUserProfiles;

  StreamSubscription<SerializableModel>? _updatesSubscription;

  @override
  NitChatViewStateModel build(int chatId) {
    ref.onDispose(() {
      _updatesSubscription?.cancel();
    });

    _updatesSubscription =
        nitToolsCaller!.nitChat.updatesStream(chatId: chatId).listen(
      (update) {
        if (update is NitChatInitialData) {
          ref.updateRepository(update.additionalEntities);

          // state.controller.otherUsers =
          //     prepareUserProfiles(ref, update.participantIds);
          update.participantIds;

          state = state.copyWith(
            viewState: update.messages.isEmpty
                ? ChatViewState.noData
                : ChatViewState.hasMessages,
            messages: update.messages,
            lastReadMessageId: update.lastReadMessageId,
            isTyping: false,
          );

          // if (!state.controller.messageStreamController.isClosed) {
          //   state.controller.messageStreamController.sink
          //       .add(state.controller.initialMessageList);
          // }
        } else if (update is NitChatMessage) {
          // Merge or update existing message
          final idx = state.messages.indexWhere((m) => m.id == update.id);
          if (idx != -1) {
            final updated = [...state.messages];
            updated[idx] = update;
            state = state.copyWith(messages: updated);
          } else {
            state = state.copyWith(messages: [...state.messages, update]);
          }

          if (update.userId == ref.signedInUserId) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              state.scrollController.jumpTo(
                state.scrollController.position.maxScrollExtent,
              );
            });
          }

          if (state.viewState == ChatViewState.noData) {
            state = state.copyWith(viewState: ChatViewState.hasMessages);
          }
        } else if (update is NitChatReadMessageEvent) {
          if (update.userId != ref.signedInUserId) {
            state = state.copyWith(lastReadMessageId: update.messageId);
          }
        } else if (update is NitTypingMessageEvent) {
          if (update.userId != ref.signedInUserId) {
            state = state.copyWith(
              isTyping: update.isTyping,
            );
          }
        }
      },
      onError: (Object error, StackTrace stackTrace) =>
          debugPrint('$error\n$stackTrace'),
      onDone: () => debugPrint("Chat Channel $chatId subscription done"),
    );

    return NitChatViewStateModel(
      scrollController: ScrollController(),
      viewState: ChatViewState.loading,
    );
  }

  Future<void> onMessageTap(String message) async {
    final attachment =
        await ref.read(attachmentStateProvider.notifier).uploadMedia();

    ref.saveModel(
      NitChatMessage(
        text: message,
        userId: ref.signedInUserId!,
        chatChannelId: chatId,
        sentAt: DateTime.now(),
        attachmentIds: attachment.map((e) => e.id).nonNulls.toList(),
      ),
    );
    ref.invalidate(attachmentStateProvider);
  }

  /// Called when a message becomes visible in the viewport
  void markAsReadMessage(NitChatMessage message) {
    if (message.id! > (state.lastReadMessageId ?? 0)) {
      log('Message ${message.id} visible in chat $chatId');

      nitToolsCaller!.nitChat.readChatMessage(message.id!, chatId);
    }
  }

  void typingToggle(bool isTyping) {
    log('Typing $isTyping in chat $chatId');
    nitToolsCaller!.nitChat.typingToggle(chatId, isTyping);
  }
}
