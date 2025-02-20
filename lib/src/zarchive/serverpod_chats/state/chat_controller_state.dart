// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:nit_riverpod_notifications/nit_riverpod_notifications.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:serverpod_chat_client/serverpod_chat_client.dart';
// import 'package:serverpod_chat_flutter/serverpod_chat_flutter.dart';

// import '../../session/nit_session_state.dart';

// part 'chat_controller_state.g.dart';
// part 'chat_controller_state.freezed.dart';

// late final Caller chatsModuleCaller;

// final unauthenticatedUsername = StateProvider<String>(
//   (ref) => 'Аноним',
// );

// // extension ChatControllerStateExtension on ChatControllerStateData {
// //   bool get isReady =>
// //       [ChatViewState.hasMessages, ChatViewState.noData].contains(status);
// // }

// @freezed
// class ChatControllerStateData with _$ChatControllerStateData {
//   const factory ChatControllerStateData({
//     required bool isReady,
//     // required chatview.ChatViewState status,
//     required ChatController? serverpodController,
//     // required chatview.ChatController chatViewController,
//     // required bool hasMessages,
//     required int unreadMessageCount,
//     required ChatMessage? lastMessage,
//   }) = _ChatControllerStateData;
// }

// @riverpod
// class ChatControllerState extends _$ChatControllerState {
//   ChatController? _serverpodController;
//   // late final chatview.ChatController _chatViewController;
//   // late chatview.ChatUser _currentUser;
//   late NitSessionStateModel session;

//   @override
//   ChatControllerStateData build(String channel) {
//     ref.onDispose(_dispose);

//     session = ref.watch(nitSessionStateProvider);

//     // _currentUser = chatview.ChatUser(
//     //   id: '${session.signedInUser?.id}',
//     //   name: '${session.signedInUser?.fullName}',
//     //   profilePhoto: session.signedInUser?.imageUrl,
//     // );

//     // _chatViewController = chatview.ChatController(
//     //   initialMessageList: [],
//     //   scrollController: ScrollController(),
//     //   currentUser: _currentUser,
//     //   otherUsers: [], //usersMap.values.toList(),
//     // );

//     if (
//         // session.websocketStatus == StreamingConnectionStatus.connected &&
//         _serverpodController == null) {
//       _serverpodController = ChatController(
//         channel: channel,
//         module: chatsModuleCaller,
//         sessionManager:
//             ref.read(nitSessionStateProvider).serverpodSessionManager!,
//         unauthenticatedUserName: session.signedInUserId != null
//             ? null
//             : ref.read(unauthenticatedUsername),
//       );

//       _serverpodController!.addConnectionStatusListener(
//         _updateState,
//         // _connectionStatusListener,
//       );
//       _serverpodController!.addMessageReceivedListener(
//         (message, addedByUser) {
//           if (!addedByUser && message.senderInfo != null) {
//             ref.notifyUser(message);
//             // ref.read(notificationAreaStateProvider.notifier).add(
//             //       AppNotification(
//             //         userId: ref.signedInUserId,
//             //         userRole: ref.role,
//             //         type: AppNotificationType.chat,
//             //         timestamp: DateTime.now(),
//             //         objectId: _chatId,
//             //         title: '${message.senderInfo!.userName} пишет',
//             //         text: message.message,
//             //         isRead: false,
//             //       ),
//             //     );
//           }
//           _updateState();
//         },
//       );
//       _serverpodController!.addUnreadMessagesListener(
//         _updateState,
//       );
//     }

//     return ChatControllerStateData(
//       isReady: false,
//       // status: ChatViewState.loading,
//       serverpodController: _serverpodController,
//       // chatViewController: _chatViewController,
//       // hasMessages: false,
//       unreadMessageCount: _unreadMessageCount,
//       lastMessage: _serverpodController?.messages.lastOrNull,
//     );
//   }

//   // void _connectionStatusListener() {
//   //   // TODO: обработать прочие важные ситуации
//   //   if (_serverpodController!.joinedChannel) {
//   //     debugPrint('joined ${_serverpodController!.channel}');
//   //     _updateState();
//   //   }
//   // }

//   _updateState() {
//     if (true == _serverpodController?.joinedChannel) {
//       state = state.copyWith(
//         isReady: true,
//         unreadMessageCount: _unreadMessageCount,
//         lastMessage: _serverpodController!.messages.lastOrNull,
//       );
//     }
//   }

//   int get _unreadMessageCount {
//     int count = 0;

//     for (var message
//         in _serverpodController?.messages.reversed ?? <ChatMessage>[]) {
//       if (message.sender != _serverpodController!.joinedAsUserId &&
//           message.id != null) {
//         if (message.id! > _serverpodController!.lastReadMessageId) {
//           count++;
//         } else {
//           break;
//         }
//       }
//     }

//     return count;
//   }

//   // void _unreadMessagesListener() {
//   //   state = state.copyWith(
//   //     unreadMessageCount: _unreadMessageCount,
//   //   );
//   // }

//   // void sendMessage(
//   //   String message,
//   //   chatview.ReplyMessage replyMessage,
//   //   chatview.MessageType messageType,
//   // ) async {
//   //   debugPrint('${_currentUser.name} sent $message');
//   //   // try {
//   //   _serverpodController!.postMessage(
//   //     message,
//   //   );
//   //   // } catch (e) {
//   //   // debugPrint('Error cacthed $e');
//   //   // }

//   //   // _chatViewController.addMessage(
//   //   //   Message(
//   //   //     // messageClientId: clientMessageId,
//   //   //     createdAt: DateTime.now().toLocal(),
//   //   //     message: message,
//   //   //     sentBy: _currentUser.id,
//   //   //     replyMessage: replyMessage,
//   //   //     messageType: messageType,
//   //   //     status: MessageStatus.pending,
//   //   //   ),
//   //   // );
//   // }

//   // void _messageReceivedListener(ChatMessage message, bool addedByUser) {
//   //   debugPrint('message received: ${message.toJson()}');
//   //   if (message.id == null) return;
//   //   // _chatViewController.loadMessagesFromServerpod(
//   //   //   messages: [message],
//   //   //   lastReadMessageId: _serverpodController!.lastReadMessageId,
//   //   // );
//   //   _chatViewController.addMessage(message.convertToUIMessage(true));
//   // }

//   // markMessageRead(chatview.Message message) {
//   //   debugPrint('Message Read: ${message.id}');

//   //   _serverpodController!.markMessageRead(
//   //     int.parse(message.id),
//   //   );
//   // }

//   // TODO: Написать какой-то метод более оптимальный, чтобы не гонять по всему списку N раз
//   /// New portion of messages received from server
//   // void _receivedMessageChunkListener() {
//   //   final newMessageList = _serverpodController!.messages;
//   //   newMessageList.removeWhere((m) => _chatviewController.initialMessageList
//   //       .any((m2) => m2.id == m.id.toString()));

//   //   final convert = newMessageList
//   //       .map(
//   //         (m) => m.convertToUIMessage(
//   //           true,
//   //         ),
//   //       )
//   //       .toList();
//   //   _chatviewController.loadMoreData(convert);
//   // }

//   _dispose() {
//     if (_serverpodController != null) {
//       debugPrint('Disposing controller for ${_serverpodController!.channel}');
//       _serverpodController!.dispose();
//     }
//   }
// }
