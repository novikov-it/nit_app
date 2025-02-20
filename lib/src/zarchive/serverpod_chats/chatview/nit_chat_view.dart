// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nit_app/nit_app.dart';
// import 'package:serverpod_chat_flutter/serverpod_chat_flutter.dart';

// import 'widgets/message_card.dart';

// class NitChatView extends ConsumerStatefulWidget {
//   const NitChatView({
//     super.key,
//     // required this.serverpodChatController,
//     // required this.currentUser,
//     required this.channel,
//     this.loadingWidget = const Center(
//       child: CircularProgressIndicator(),
//     ),
//   });

//   // final serverpod_chat.ChatController serverpodChatController;
//   // final chatview.ChatUser currentUser;
//   final String channel;
//   final Widget loadingWidget;

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _NitChatViewState();
// }

// class _NitChatViewState extends ConsumerState<NitChatView> {
//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(chatControllerStateProvider(widget.channel));

//     if (state.isReady && state.serverpodController != null) {
//       return Column(children: [
//         Expanded(
//           child: ChatView(
//             controller: state.serverpodController!,
//             tileBuilder: (context, message, previous) => MessageCard(
//               message: message,
//               sentByMe:
//                   state.serverpodController!.joinedAsUserId == message.sender,
//             ),
//           ),
//         ),
//         ChatInput(
//           controller: state.serverpodController!,
//           hintText: 'Сообщение',
//         ),
//       ]);
//     }

//     return widget.loadingWidget;
//   }
// }
