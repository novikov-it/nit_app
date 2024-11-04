import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nit_app/nit_app.dart';
import 'package:chatview/chatview.dart' as chatview;
import 'package:nit_app/src/chats/chatview/utils/serverpod_chat_message_extension.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_chat_client/serverpod_chat_client.dart';
import 'package:serverpod_chat_flutter/serverpod_chat_flutter.dart';

part 'chat_controller_state.g.dart';
part 'chat_controller_state.freezed.dart';

late final Caller chatsModuleCaller;

@freezed
class ChatControllerStateData with _$ChatControllerStateData {
  const factory ChatControllerStateData({
    required bool isReady,
    // required ChatController serverpodController,
    required chatview.ChatController chatviewController,
    required bool hasMessages,
    required bool hasUnreadMessages,
    required ChatMessage? lastMessage,
  }) = _ChatControllerStateData;
}

@riverpod
class ChatControllerState extends _$ChatControllerState {
  ChatController? _serverpodController;
  late chatview.ChatController _chatviewController;
  late chatview.ChatUser _currentUser;

  @override
  ChatControllerStateData build(String channel) {
    ref.onDispose(_dispose);

    final session = ref.watch(nitSessionStateProvider);

    _currentUser = chatview.ChatUser(
      id: '${session.signedInUser?.id}',
      name: '${session.signedInUser?.fullName}',
      profilePhoto: session.signedInUser?.imageUrl,
    );

    _chatviewController = chatview.ChatController(
      initialMessageList: [],
      scrollController: ScrollController(),
      currentUser: _currentUser,
      otherUsers: [], //usersMap.values.toList(),
    );

    if (session.websocketStatus == StreamingConnectionStatus.connected) {
      _serverpodController = ChatController(
        channel: channel,
        module: chatsModuleCaller,
        sessionManager:
            ref.read(nitSessionStateProvider).serverpodSessionManager!,
      );

      _serverpodController!.addConnectionStatusListener(
        _connectionStatusListener,
      );
      _serverpodController!.addMessageReceivedListener(
        _messageReceivedListener,
      );
      _serverpodController!.addReceivedMessageChunkListener(
        _receivedMessageChunkListener,
      );
    }

    // return const AsyncLoading();

    return ChatControllerStateData(
      isReady: false,
      // serverpodController: _serverpodController,
      chatviewController: _chatviewController,
      hasMessages: false,
      hasUnreadMessages: _serverpodController?.hasUnreadMessages ?? false,
      lastMessage: _serverpodController?.messages.lastOrNull,
    );
  }

  void _connectionStatusListener() {
    // TODO: обработать прочие важные ситуации
    if (_serverpodController!.joinedChannel) {
      debugPrint('joined ${_serverpodController!.channel}');

      _serverpodController!.messages.removeWhere((m) => m.id == null);
      final List<chatview.Message> messageList = _serverpodController!.messages
          .map(
            (m) => m.convertToUIMessage(
              m.id! <= _serverpodController!.lastReadMessageId,
            ),
          )
          .toList();

      _chatviewController.loadMoreData(messageList);

      final Map<String, chatview.ChatUser> usersMap = {};

      for (var m in _serverpodController!.messages) {
        if (usersMap[m.senderInfo?.id.toString()] == null) {
          usersMap[m.senderInfo?.id.toString() ?? '-'] = chatview.ChatUser(
            id: m.senderInfo?.id.toString() ?? '-',
            name: m.senderInfo?.fullName ?? 'XXX',
            profilePhoto: m.senderInfo?.imageUrl,
          );
        }
      }

      state = state.copyWith(
        isReady: true,
        // serverpodController: _serverpodController,
        // chatviewController: _chatviewController,
        hasMessages: messageList.isNotEmpty,
        hasUnreadMessages: _serverpodController!.hasUnreadMessages,
        lastMessage: _serverpodController!.messages.lastOrNull,
      );
    }
  }

  void sendMessage(
    String message,
    chatview.ReplyMessage replyMessage,
    chatview.MessageType messageType,
  ) async {
    print('_______ pressed $message');
    // final isAttachment =
    //     messageType == chatview.MessageType.voice || messageType == chatview.MessageType.image;
    // ChatMessageAttachment? attachment;
    // if (isAttachment) {
    //   attachment = await _attachFile(message, messageType);
    //   debugPrint('attachment_url ${attachment?.url}');
    //   _chatController.setAttachmentLoadingIndicator = false;
    // }
    try {
      // if (isAttachment && attachment == null) {
      //   debugPrint('Message type is attachment but attachment is null');
      //   return;
      // }
      // Map<String, String> replyOf = {
      //   'message': replyMessage.message,
      //   'replyBy': replyMessage.replyBy,
      //   'replyTo': replyMessage.replyTo,
      //   'id': replyMessage.messageId,
      //   'messageType': replyMessage.messageType.name,
      // };
      // await widget.serverpodChatController.module.typingIndicator.sendStreamMessage(
      //   cl.TypeIndicator(
      //     status: false,
      //     typerID: currentUser.id!,
      //     channel: widget.serverpodChatController.channel,
      //   ),
      // );

      // final clientMessageId =
      _serverpodController!.postMessage(
        // _attachments.isNotEmpty ? '' :
        message,
        // _attachments,
        // replyOf,
      );
      // _attachments.clear();

      _chatviewController.addMessage(
        chatview.Message(
          // messageClientId: clientMessageId,
          createdAt: DateTime.now().toLocal(),
          message: message,
          sentBy: _currentUser.id.toString(),
          replyMessage: replyMessage,
          messageType: messageType,
          status: chatview.MessageStatus.pending,
        ),
      );
    } catch (e) {
      debugPrint('Error cacthed $e');
    }
  }

  void _messageReceivedListener(ChatMessage message, bool addedByUser) {
    debugPrint('message received: ${message.toJson()}');
    if (message.id == null) return;

    final index = _chatviewController.initialMessageList
        .indexWhere((e) => e.id == message.id.toString());
    if (index != -1) {
      // Remove the message from the list
      if (message.removed) {
        _chatviewController.initialMessageList
            .removeWhere((e) => e.id == message.id.toString());
        // setState(() {});
        return;
      }
      // Add reactions the existing message
      chatview.Message found = _chatviewController.initialMessageList[index];
      chatview.Message updatedMessage = message
          .convertToUIMessage(found.status == chatview.MessageStatus.read);

      _chatviewController.initialMessageList[index] = updatedMessage;
    } else {
      if (!message.removed) {
        _chatviewController.addMessage(message.convertToUIMessage(false));
      }
    }

    if (!state.hasMessages) {
      state = state.copyWith(
        hasMessages: true,
      );
    }

    //allMEssages.add(Message.fromJson(message.toJson()));
    // _chatController.chatUpdateStreamController.add(true);
  }

  // TODO: Написать какой-то метод более оптимальный, чтобы не гонять по всему списку N раз
  /// New portion of messages received from server
  void _receivedMessageChunkListener() {
    final newMessageList = _serverpodController!.messages;
    newMessageList.removeWhere((m) => _chatviewController.initialMessageList
        .any((m2) => m2.id == m.id.toString()));

    final convert = newMessageList
        .map((m) => m.convertToUIMessage(
              true,
            ))
        .toList();
    _chatviewController.loadMoreData(convert);
  }

  _dispose() {
    if (_serverpodController != null) {
      debugPrint('Disposing controller for ${_serverpodController!.channel}');
      // final changedList = ref.read(chatListStateProvider).value?.map(
      //   (element) {
      //     if (element.channel == channel) {
      //       return element.copyWith(
      //         hasUnreadMessages: false,
      //         lastMessage: _controller.messages.lastOrNull,
      //       );
      //     }
      //     return element;
      //   },
      // ).toList();

      // ref.read(chatListStateProvider.notifier).updateState(changedList ?? []);
      _serverpodController!.dispose();
      // TODO: очень странно тут всё
      // ref.read(chatListStateProvider.notifier).newChannelListener();
    }
  }
}


  // listenForMessage() async {
    // widget.serverpodChatController
    //     .addMessageUpdatedListener((m) => messageUpdatedListener(m));

    // widget.serverpodChatController
    //     .addMessageReceivedListener((ChatMessage message, bool addedByUser) {
    //   debugPrint('message received: ${message.toJson()}');
    //   messageReceivedListener(message);
    // });

    // widget.serverpodChatController.addReadStatusListeners((int messageId) {
    //   final foundMessage = _chatController.initialMessageList
    //       .firstWhere((e) => e.id == messageId.toString());

    //   if (foundMessage.sentBy != currentUser.id.toString()) {
    //     return;
    //   }

    //   if (foundMessage.status == MessageStatus.read) return;

    //   final readMessageId = _chatController.initialMessageList
    //       .indexWhere((e) => e.id == messageId.toString());
    //   if (readMessageId != -1) {
    //     final markedMessages = _chatController.initialMessageList.where((e) =>
    //         e.status == MessageStatus.delivered &&
    //         readMessageId < int.parse(e.id));
    //     for (var e in markedMessages) {
    //       final messageIndex = _chatController.initialMessageList
    //           .indexWhere((e2) => e2.id == e.id);
    //       _chatController.initialMessageList[messageIndex] = _chatController
    //           .initialMessageList[messageIndex]
    //           .copyWith(status: MessageStatus.read);
    //     }
    //     debugPrint(
    //         'read message ${_chatController.initialMessageList[readMessageId].toJson()}');
    //     _chatController.chatUpdateStreamController.add(true);
    //   }
    // });
    // widget.serverpodChatController.module.typingIndicator.resetStream();

    // widget.serverpodChatController.module.typingIndicator.stream.listen((typer) {
    //   try {
    //     final cl.TypeIndicator thisTyper =
    //         cl.TypeIndicator.fromJson(typer.toJson());

    //     if (thisTyper.channel != widget.serverpodChatController.channel ||
    //         thisTyper.typerID == currentUser.id) {
    //       return;
    //     } else {
    //       if (thisTyper.status) {
    //         _chatController.setTypingIndicator = true;
    //       } else {
    //         _chatController.setTypingIndicator = false;
    //       }
    //     }
    //   } catch (e) {
    //     debugPrint('Error" $e');
    //   }
    // });
  // }