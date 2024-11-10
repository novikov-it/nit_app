import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_app/src/chats/chatview/widgets/custom_chat_view.dart';
import 'package:serverpod_chat_flutter/serverpod_chat_flutter.dart';

import 'widgets/message_card.dart';

class NitChatView extends ConsumerStatefulWidget {
  const NitChatView({
    super.key,
    // required this.serverpodChatController,
    // required this.currentUser,
    required this.channel,
  });

  // final serverpod_chat.ChatController serverpodChatController;
  // final chatview.ChatUser currentUser;
  final String channel;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NitChatViewState();
}

class _NitChatViewState extends ConsumerState<NitChatView> {
  // ChatViewState status = ChatViewState.loading;
  // late ChatController _chatController;
  // ProviderSubscription? _subscription;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  //   final signedInUser = ref.read(nitSessionStateProvider).signedInUser;
  //   _chatController = ChatController(
  //     initialMessageList: [],
  //     scrollController: ScrollController(),
  //     currentUser: ChatUser(
  //       id: '${signedInUser?.id}',
  //       name: '${signedInUser?.fullName}',
  //       profilePhoto: signedInUser?.imageUrl,
  //     ),
  //     otherUsers: [], //usersMap.values.toList(),
  //   );

  //   final controllerState = ref.read(
  //     chatControllerStateProvider(widget.channel),
  //   );

  //   if (controllerState.isReady) {
  //     _init(controllerState);
  //   } else {
  //     _subscription = ref.listenManual<ChatControllerStateData>(
  //       chatControllerStateProvider(widget.channel),
  //       _listener,
  //     );
  //   }
  // }

  // _listener(
  //     ChatControllerStateData? oldState, ChatControllerStateData newState) {
  //   if (newState.isReady) {
  //     _subscription?.close();
  //     setState(() {
  //       _init(newState);
  //     });
  //   }
  // }

  // _init(ChatControllerStateData state) {

  //   status = state.serverpodController!.messages.isEmpty
  //       ? ChatViewState.noData
  //       : ChatViewState.hasMessages;
  //   state.serverpodController!.addMessageReceivedListener(_newMessageListener);
  // }

  // _newMessageListener(ChatMessage message, bool _) {
  //   _loadMessages(
  //       [message],
  //       ref
  //           .read(chatControllerStateProvider(widget.channel))
  //           .serverpodController!
  //           .lastReadMessageId);
  // }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatControllerStateProvider(widget.channel));

    if (state.isReady && state.serverpodController != null) {
      // return ChatViewWidget(serverpodController: state.serverpodController!);
      return Column(children: [
        Expanded(
          child: CustomChatView(
              controller: state.serverpodController!,
              tileBuilder: (context, message, previous) {
                return MessageCard(message: message);
              }),
        ),
        ChatInput(
          controller: state.serverpodController!,
          hintText: 'Сообщение',

          // Функция отправки файлов
          // enableAttachments: true,
        ),
      ]);
    }

    return CircularProgressIndicator();
    // final state =

    // return chatview.ChatView(
    //   chatController: state.chatViewController,
    //   onSendTap: ref
    //       .read(chatControllerStateProvider(widget.channel).notifier)
    //       .sendMessage,
    //   chatViewState: ChatViewState.hasMessages,
    //   //  ref.watch(
    //   //   chatControllerStateProvider(widget.channel).select((e) => e.status),
    //   // ),
    //   chatBackgroundConfig: chatview.ChatBackgroundConfiguration(
    //     backgroundColor: context.colorScheme.surface,
    //   ),
    //   sendMessageConfig: chatview.SendMessageConfiguration(
    //     textFieldConfig: chatview.TextFieldConfiguration(
    //       textStyle: TextStyle(
    //         color: context.colorScheme.onSurface,
    //       ),
    //     ),
    //     allowRecordingVoice: false,
    //   ),
    //   chatBubbleConfig: chatview.ChatBubbleConfiguration(
    //     inComingChatBubbleConfig: chatview.ChatBubble(
    //       onMessageRead: ref
    //           .read(chatControllerStateProvider(widget.channel).notifier)
    //           .markMessageRead,
    //     ),
    //   ),
    // );
  }
}
