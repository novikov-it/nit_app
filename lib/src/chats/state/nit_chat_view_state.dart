import 'dart:async';

import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nit_app/nit_app.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart';

part 'nit_chat_view_state.freezed.dart';
part 'nit_chat_view_state.g.dart';

@freezed
abstract class NitChatViewStateModel with _$NitChatViewStateModel {
  const factory NitChatViewStateModel({
    required ChatController controller,
    required ChatViewState viewState,
  }) = _NitChatViewStateModel;
}

extension on NitChatMessage {
  Message get toChatViewMessage => Message(
        message: text ?? '-',
        createdAt: sentAt.toLocal(),
        sentBy: userId.toString(),
        status: MessageStatus.delivered,
      );
}

extension on UserInfo {
  ChatUser get toChatViewUser => ChatUser(
        id: id.toString(),
        name: userName ?? userIdentifier,
        profilePhoto: imageUrl,
      );
}

@riverpod
class NitChatViewState extends _$NitChatViewState {
  // late final ChatController _chatController;

  static late final List<ChatUser> Function(Ref ref, List<int> userIds)
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

          state.controller.otherUsers =
              prepareUserProfiles(ref, update.participantIds);
          state.controller.initialMessageList =
              update.messages.map((e) => e.toChatViewMessage).toList();

          state = state.copyWith(
            viewState: update.messages.isEmpty
                ? ChatViewState.noData
                : ChatViewState.hasMessages,
          );

          if (!state.controller.messageStreamController.isClosed) {
            state.controller.messageStreamController.sink
                .add(state.controller.initialMessageList);
          }
        } else if (update is NitChatMessage) {
          state.controller.addMessage(update.toChatViewMessage);

          if (state.viewState == ChatViewState.noData) {
            state = state.copyWith(viewState: ChatViewState.hasMessages);
          }
        }
      },
      onError: (Object error, StackTrace stackTrace) =>
          debugPrint('$error\n$stackTrace'),
      onDone: () => debugPrint("Chat Channel $chatId subscription done"),
    );

    return NitChatViewStateModel(
      controller: ChatController(
        initialMessageList: [],
        scrollController: ScrollController(),
        currentUser: ChatUser(
          id: ref.signedInUserId.toString(),
          name: 'Пользователь',
        ),
        otherUsers: [],
      ),
      viewState: ChatViewState.loading,
    );
  }

  onMessageTap(String message, ReplyMessage replyMessage,
      MessageType messageType) async {
    ref.saveModel(
      NitChatMessage(
        text: message,
        userId: ref.signedInUserId!,
        chatChannelId: chatId,
        sentAt: DateTime.now(),
      ),
    );
  }
}
