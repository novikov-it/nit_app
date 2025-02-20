// import 'package:flutter/material.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:nit_app/nit_app.dart';
// import 'package:nit_app/src/chats/chatview/utils/serverpod_chat_message_extension.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:serverpod_chat_client/serverpod_chat_client.dart';

// part 'chat_view_page_state.g.dart';
// part 'chat_view_page_state.freezed.dart';

// @riverpod
// class ChatViewPageState extends _$ChatViewPageState {
//   @override
//   ChatViewPageStateModel build(String channel) {
//     final signedInUser =
//         ref.watch(nitSessionStateProvider.select((e) => e.signedInUser));
//     final controllerIsReady = ref
//         .watch(chatControllerStateProvider(channel).select((e) => e.isReady));

//     final chatController = ChatController(
//       initialMessageList: [],
//       scrollController: ScrollController(),
//       currentUser: ChatUser(
//         id: '${signedInUser?.id}',
//         name: '${signedInUser?.fullName}',
//         profilePhoto: signedInUser?.imageUrl,
//       ),
//       otherUsers: [], //usersMap.values.toList(),
//     );

//     return ChatViewPageStateModel(
//       status: controllerIsReady ? _loadInitialData() : ChatViewState.loading,
//       chatviewController: chatController,
//     );
//   }

//   // setStatus(ChatViewState newStatus) {
//   //   state = state.copyWith(status: newStatus);
//   // }

//   ChatViewState _loadInitialData() {
//     final serverpodController = ref.read(chatControllerStateProvider(channel)
//         .select((e) => e.serverpodController));

//     if (serverpodController == null) return ChatViewState.error;

//     _addMessages(
//         messages: serverpodController.messages,
//         lastReadMessageId: serverpodController.lastReadMessageId);

//     return serverpodController.messages.isEmpty
//         ? ChatViewState.noData
//         : ChatViewState.hasMessages;
//   }

//   _addMessages({
//     required List<ChatMessage> messages,
//     required int lastReadMessageId,
//     // bool initial = false,
//   }) {
//     final List<Message> messageList = messages
//         .map(
//           (m) => m.convertToUIMessage(
//             m.id! <= lastReadMessageId,
//           ),
//         )
//         .toList();

//     // _chatviewController.loadMoreData(messageList);

//     final Map<String, ChatUser> usersMap = {};

//     for (var m in messages) {
//       final id = m.senderInfo?.id.toString();
//       if (id != state.chatviewController.currentUser.id &&
//           usersMap[id] == null) {
//         usersMap[m.senderInfo?.id.toString() ?? '-'] = ChatUser(
//           id: m.senderInfo?.id.toString() ?? '-',
//           name: m.senderInfo?.fullName ?? 'XXX',
//           profilePhoto: m.senderInfo?.imageUrl,
//         );
//       }
//     }

//     state.chatviewController.otherUsers.addAll(usersMap.values);
//     state.chatviewController.loadMoreData(messageList);

//     // if (initial) {
//     //   state = state.copyWith(
//     //     status:
//     //         messages.isEmpty ? ChatViewState.noData : ChatViewState.hasMessages,
//     //   );
//     // }
//     // _chatviewController.otherUsers = usersMap.values.toList();
//   }
// }

// @freezed
// abstract class ChatViewPageStateModel with _$ChatViewPageStateModel {
//   const factory ChatViewPageStateModel({
//     required ChatViewState status,
//     // required ChatController serverpodController,
//     required ChatController chatviewController,
//   }) = _ChatViewPageStateModel;
// }
