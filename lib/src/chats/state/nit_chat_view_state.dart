import 'dart:async';

import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
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
        sentBy: userInfoId.toString(),
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

  StreamSubscription<SerializableModel>? _updatesSubscription;

  @override
  NitChatViewStateModel build(int chatId) {
    ref.onDispose(() {
      _updatesSubscription?.cancel();

      //    ref.removeUpdatesListener<NitChatMessage>(
      //   _messageUpdatesListener,
      // );
    });

    _updatesSubscription =
        nitToolsCaller!.nitChat.updatesStream(chatId: chatId).listen(
      (update) {
        if (update is NitChatInitialData) {
          state.controller.otherUsers =
              update.participantProfiles.map((e) => e.toChatViewUser).toList();
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
          // if (state.viewState != ChatViewState.loading) {
          state.controller.addMessage(update.toChatViewMessage);

          if (state.viewState == ChatViewState.noData) {
            state = state.copyWith(viewState: ChatViewState.hasMessages);
          }
          // }
        }

        // May be useful for debug
      },
      onError: (Object error, StackTrace stackTrace) =>
          debugPrint('$error\n$stackTrace'),
      onDone: () => debugPrint("Chat Channel $chatId subscription done"),
    );

    // final config = EntityListConfig(
    //   backendFilters: [
    //     NitBackendFilter(
    //       fieldName: 'chatChannelId',
    //       equalsTo: chatId.toString(),
    //     )
    //   ],
    // );
    // final messageIds = await nitToolsCaller!.nitCrud
    //     // TODO: Изменить, toString() не работает на Web release из-за minification
    //     .getAll(
    //       className: 'NitChatMessage',
    //       filters: config.backendFilters,
    //     )
    //     .then(
    //       (response) => ref.processApiResponse<List<int>>(response),
    //     )
    //     .then(
    //       (res) => res ?? <int>[],
    //     );

    // ref.addUpdatesListener<NitChatMessage>(_messageUpdatesListener);

    // await ref.watch(
    //   entityManagerStateProvider<NitChatMessage>()(
    //     config,
    //   ).future,
    // );

    // final participants = await ref.watch(
    //   entityManagerStateProvider<NitChatParticipant>()(config).future,
    // );

    // _chatController = ;
    // final messages =
    return NitChatViewStateModel(
      controller: ChatController(
        initialMessageList: [],
        //  messageIds
        //     .map((e) => ref.readModel<NitChatMessage>(e)!.toChatViewMessage)
        //     .toList(),
        scrollController: ScrollController(),
        currentUser: ChatUser(
          id: ref.signedInUserId.toString(),
          name: 'Пользователь',
        ),
        otherUsers: [],
        //  participants
        //     .map((e) => ref
        //         .readModel<UserInfo>(
        //             ref.readModel<NitChatParticipant>(e)!.userInfoId)!
        //         .toChatViewUser)
        //     .toList(), // participants.map((e) => ref.watchModel<ChatParticipant>(e)!),),
      ),
      viewState: ChatViewState.loading,
      // messageIds.isEmpty ? ChatViewState.noData : ChatViewState.hasMessages,
    );
  }

  // _messageUpdatesListener(int id, SerializableModel updatedMessage) async {
  //   await future.then((currentState) {
  //     currentState.controller
  //         .addMessage((updatedMessage as NitChatMessage).toChatViewMessage);
  //   });
  // }

  onMessageTap(String message, ReplyMessage replyMessage,
      MessageType messageType) async {
    // await future.then((currentState) {
    // state.controller.addMessage(
    //   Message(
    //     message: message,
    //     createdAt: DateTime.now(),
    //     sentBy: ref.signedInUserId.toString(),
    //     status: MessageStatus.undelivered,
    //   ),
    // );

    ref.saveModel(
      NitChatMessage(
        text: message,
        userInfoId: ref.signedInUserId!,
        chatChannelId: chatId,
        sentAt: DateTime.now(),
      ),
    );
    // });

    // .then(
    //   (id) => _chatController.addMessage(
    //     id != null
    //         ? ref.watchModel<NitChatMessage>(id)!.toChatViewMessage
    //         : Message(
    //             message: message,
    //             createdAt: DateTime.now(),
    //             sentBy: ref.signedInUserId.toString(),
    //             status: MessageStatus.undelivered,
    //           ),
    //   ),
    // );
  }
}
