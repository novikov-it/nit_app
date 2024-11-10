// import 'dart:io';
// import 'dart:typed_data';

// import 'package:chatview/chatview.dart';
// import 'package:flutter/material.dart';
// import 'package:nit_app/src/chats/chatview/utils/serverpod_chat_message_extension.dart';
// import 'package:nit_app/src/nit_app_build_context_extension.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:serverpod_auth_client/module.dart';
// import 'package:serverpod_chat_client/serverpod_chat_client.dart';
// import 'package:serverpod_chat_client/serverpod_chat_client.dart' as cl;
// import 'package:serverpod_chat_flutter/serverpod_chat_flutter.dart'
//     as serverpod_controller;

// class ChatViewWidget extends StatefulWidget {
//   const ChatViewWidget({
//     super.key,
//     required this.serverpodController,
//     // required this.chatWithUserInfo,
//     this.appBarBottomWidget,
//     this.onTitleTap,
//     this.customMessageViewBuilder,
//     this.customReplyBuilder,
//     // this.getCustomModelViewFunction,
//     this.onAvatarTap,
//   });

//   /// Provides builder for custom message view.
//   final Widget Function(Message message)? customMessageViewBuilder;

//   /// Provides builder for custom reply view.
//   final Widget Function(Message message)? customReplyBuilder;

//   /// Provides controller for the chat.
//   final serverpod_controller.ChatController serverpodController;

//   /// Provides information about the chat with.
//   // final UserInfo chatWithUserInfo;

//   /// Provides callback when user tap on title.
//   final VoidCallBack? onTitleTap;

//   ///
//   final VoidCallBack? onAvatarTap;

//   /// Provides callback when user tap on send button.
//   final Widget? appBarBottomWidget;

//   // final Future<CustomMessageModel?> Function(int id)?
//   //     getCustomModelViewFunction;

//   @override
//   State<ChatViewWidget> createState() => _ChatViewWidgetState();
// }

// class _ChatViewWidgetState extends State<ChatViewWidget> {
//   late final UserInfo currentUser;

//   bool _uploadingAttachment = false;
//   final List<ChatMessageAttachment> _attachments = [];
//   @override
//   void initState() {
//     super.initState();
//     currentUser = widget.serverpodController.sessionManager.signedInUser!;

//     widget.serverpodController.addUnreadMessagesListener(() {
//       // debugPrint('unread changed!!!');
//     });

//     listenForMessage();
//     widget.serverpodController.messages.removeWhere((m) => m.id == null);
//     final List<Message> messageList = widget.serverpodController.messages
//         .map(
//           (m) => m.convertToUIMessage(
//             m.id! <= widget.serverpodController.lastReadMessageId,
//           ),
//         )
//         .toList();

//     _chatController = ChatController(
//       initialMessageList: messageList,
//       scrollController: ScrollController(),
//       currentUser: ChatUser(
//         id: currentUser.id.toString(),
//         name: currentUser?.userName ?? 'me',
//         profilePhoto: currentUser.imageUrl,
//       ),
//       otherUsers: [
//         // ChatUser(
//         //   id: widget.chatWithUserInfo.id.toString(),
//         //   name: widget.chatWithUserInfo.userName ??
//         //       widget.chatWithUserInfo.userIdentifier,
//         //   profilePhoto: widget.chatWithUserInfo.imageUrl,
//         // )
//       ],
//     );

//     widget.serverpodController
//         .addReceivedMessageChunkListener(reciveChunckListener);
//   }

//   void reciveChunckListener() {
//     final newMessageList = widget.serverpodController.messages;
//     newMessageList.removeWhere((m) => _chatController.initialMessageList
//         .any((m2) => m2.id == m.id.toString()));

//     final convert = newMessageList
//         .map((m) => m.convertToUIMessage(
//               true,
//             ))
//         .toList();
//     _chatController.loadMoreData(convert);
//   }

//   void messageUpdatedListener(ChatMessage m) {
//     if (m.id != null) {
//       final foundMessageIndex = _chatController.initialMessageList
//           .indexWhere((e) => e.id == m.id.toString());
//       if (foundMessageIndex != -1) {
//         final foundMessage =
//             _chatController.initialMessageList[foundMessageIndex];

//         final convertedMessage = m
//             .convertToUIMessage(foundMessage.status == MessageStatus.read)
//             .copyWith(messageClientId: foundMessage.messageClientId);

//         _chatController.initialMessageList[foundMessageIndex] =
//             convertedMessage;

//         // TODO: вернуть
//         //_chatController.chatUpdateStreamController.add(true);
//         return;
//       }
//     }

//     // Add new own message to chat
//     final serverpodMessages = _chatController.initialMessageList
//         .lastIndexWhere((e) => e.messageClientId == (m.clientMessageId! + 1));
//     _chatController.initialMessageList.removeAt(serverpodMessages);
//     _chatController.addMessage(m.convertToUIMessage(false));
//     // _chatController.initialMessageList[serverpodMessages] =
//     //     m.convertToUIMessage(false);
//     // setState(() {});
//     debugPrint('ADD NEW MESSAGE TO CHAT id $serverpodMessages');
//   }

//   void messageReceivedListener(ChatMessage message) {
//     if (message.id == null) return;

//     final index = _chatController.initialMessageList
//         .indexWhere((e) => e.id == message.id.toString());
//     if (index != -1) {
//       // Remove the message from the list
//       if (message.removed) {
//         _chatController.initialMessageList
//             .removeWhere((e) => e.id == message.id.toString());
//         // setState(() {});
//         return;
//       }
//       // Add reactions the existing message
//       Message found = _chatController.initialMessageList[index];
//       Message updatedMessage =
//           message.convertToUIMessage(found.status == MessageStatus.read);

//       _chatController.initialMessageList[index] = updatedMessage;
//     } else {
//       if (!message.removed) {
//         _chatController.addMessage(message.convertToUIMessage(false));
//       }
//     }

//     //allMEssages.add(Message.fromJson(message.toJson()));

//     // TODO: вернуть
//     // _chatController.chatUpdateStreamController.add(true);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     // TODO: вернуть
//     // widget.serverpodController.module.typingIndicator.resetStream();
//     widget.serverpodController.dispose();
//     print('DISPOSE');
//   }

//   // ChatViewTheme theme = LightTheme(); //TODO sdfdsf
//   late final ChatController _chatController;
//   listenForMessage() async {
//     // TODO: вернуть
//     // widget.serverpodController
//     //     .addMessageUpdatedListener((m) => messageUpdatedListener(m));

//     widget.serverpodController
//         .addMessageReceivedListener((ChatMessage message, bool addedByUser) {
//       debugPrint('message recived: ${message.toJson()}');
//       messageReceivedListener(message);
//     });

//     // TODO: вернуть
//     // widget.serverpodController.addReadStatusListeners((int messageId) {
//     //   final foundMessage = _chatController.initialMessageList
//     //       .firstWhere((e) => e.id == messageId.toString());

//     //   if (foundMessage.sentBy != currentUser.id.toString()) {
//     //     return;
//     //   }

//     //   if (foundMessage.status == MessageStatus.read) return;

//     //   final readMessageId = _chatController.initialMessageList
//     //       .indexWhere((e) => e.id == messageId.toString());
//     //   if (readMessageId != -1) {
//     //     final markedMessages = _chatController.initialMessageList.where((e) =>
//     //         e.status == MessageStatus.delivered &&
//     //         readMessageId < int.parse(e.id));
//     //     for (var e in markedMessages) {
//     //       final messageIndex = _chatController.initialMessageList
//     //           .indexWhere((e2) => e2.id == e.id);
//     //       _chatController.initialMessageList[messageIndex] = _chatController
//     //           .initialMessageList[messageIndex]
//     //           .copyWith(status: MessageStatus.read);
//     //     }
//     //     debugPrint(
//     //         'read message ${_chatController.initialMessageList[readMessageId].toJson()}');
//     //     _chatController.chatUpdateStreamController.add(true);
//     //   }
//     // });
//     // widget.serverpodController.module.typingIndicator.resetStream();

//     // widget.serverpodController.module.typingIndicator.stream.listen((typer) {
//     //   try {
//     //     final cl.TypeIndicator thisTyper =
//     //         cl.TypeIndicator.fromJson(typer.toJson());

//     //     if (thisTyper.channel != widget.serverpodController.channel ||
//     //         thisTyper.typerID == currentUser.id) {
//     //       return;
//     //     } else {
//     //       if (thisTyper.status) {
//     //         _chatController.setTypingIndicator = true;
//     //       } else {
//     //         _chatController.setTypingIndicator = false;
//     //       }
//     //     }
//     //   } catch (e) {
//     //     debugPrint('Error" $e');
//     //   }
//     // });
//   }

//   void _onSendTap(
//     String message,
//     ReplyMessage replyMessage,
//     MessageType messageType,
//   ) async {
//     print('_______ pressed $message');
//     final isAttachment =
//         messageType == MessageType.voice || messageType == MessageType.image;
//     ChatMessageAttachment? attachment;
//     // if (isAttachment) {
//     //   attachment = await _attachFile(message, messageType);
//     //   debugPrint('attachment_url ${attachment?.url}');
//     //   // TODO: вернуть
//     //   // _chatController.setAttachmentLoadingIndicator = false;
//     // }
//     try {
//       // if (isAttachment && attachment == null) {
//       //   debugPrint('Message type is attachment but attachment is null');
//       //   return;
//       // }
//       // Map<String, String> replyOf = {
//       //   'message': replyMessage.message,
//       //   'replyBy': replyMessage.replyBy,
//       //   'replyTo': replyMessage.replyTo,
//       //   'id': replyMessage.messageId,
//       //   'messageType': replyMessage.messageType.name,
//       // };
//       // TODO: вернуть
//       // await widget.serverpodController.module.typingIndicator.sendStreamMessage(
//       //   cl.TypeIndicator(
//       //     status: false,
//       //     typerID: currentUser.id!,
//       //     channel: widget.serverpodController.channel,
//       //   ),
//       // );

//       final clientMessageId = widget.serverpodController.postMessage(
//         _attachments.isNotEmpty ? '' : message,
//         _attachments,
//         // TODO: вернуть
//         // replyOf,
//       );

//       if (clientMessageId == null) return;
//       _attachments.clear();

//       // _chatController.addMessage(
//       //   Message(
//       //     messageClientId: clientMessageId,
//       //     createdAt: DateTime.now().toLocal(),
//       //     message: message,
//       //     sentBy: currentUser.id.toString(),
//       //     replyMessage: replyMessage,
//       //     messageType: messageType,
//       //     status: MessageStatus.pending,
//       //   ),
//       // );
//     } catch (e) {
//       debugPrint('Error catched $e');
//     }
//   }

//   // Future<ChatMessageAttachment?> _attachFile(
//   //     String filePath, MessageType messageType) async {
//   //   // ChatMessageAttachment attachment;
//   //   _uploadingAttachment = true;
//   //   try {
//   //     _chatController.setAttachmentLoadingIndicator = true;
//   //     final file = File(filePath);
//   //     final fileName = file.path.split('/').last;
//   //     final bytes = await file.readAsBytes();

//   //     var uploadedAttachment = await widget.serverpodController.module.chat
//   //         .uploadAttachment(ByteData.view(bytes.buffer), fileName);
//   //     if (uploadedAttachment == null) {
//   //       _uploadCancelled();
//   //       return null;
//   //     }

//   //     debugPrint(uploadedAttachment.url);

//   //     if (mounted) {
//   //       setState(() {
//   //         _attachments.add(uploadedAttachment);
//   //       });
//   //     }

//   //     return uploadedAttachment;
//   //   } catch (e) {
//   //     _uploadCancelled();
//   //   }
//   //   return null;
//   // }

//   void _uploadCancelled() {
//     _uploadingAttachment = false;
//     // _chatController.setAttachmentLoadingIndicator = false;
//     if (mounted) setState(() {});
//   }

//   Future<void> loadMoreData() async {
//     debugPrint('need load');
//     widget.serverpodController.requestNextMessageChunk();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChatView(
//       isLastPage: false,
//       chatController: _chatController,
//       onSendTap: _onSendTap,
//       loadingWidget: const Center(
//         child: CircularProgressIndicator(),
//       ),
//       loadMoreData: loadMoreData,
//       featureActiveConfig: const FeatureActiveConfig(
//         lastSeenAgoBuilderVisibility: false,
//         enablePagination: true,
//         receiptsBuilderVisibility: false,
//         enableSwipeToSeeTime: false,
//         enableDoubleTapToLike: false,
//         enableOtherUserName: false,
//       ),
//       chatViewState: ChatViewState.hasMessages,
//       chatViewStateConfig: ChatViewStateConfiguration(
//         loadingWidgetConfig: ChatViewStateWidgetConfiguration(
//             // loadingIndicatorColor: theme.outgoingChatBubbleColor,
//             ),
//         onReloadButtonTap: () {},
//       ),
//       typeIndicatorConfig: TypeIndicatorConfiguration(
//           // flashingCircleBrightColor: theme.flashingCircleBrightColor,
//           // flashingCircleDarkColor: theme.flashingCircleDarkColor,
//           ),
//       appBar: ChatViewAppBar(
//         onBackPress: () {
//           Navigator.of(context).pop();
//         },
//         // bottomWidget: widget.appBarBottomWidget,
//         // onTitleTap: widget.onTitleTap,
//         // elevation: theme.elevation,
//         backGroundColor: context.theme.canvasColor, // appbar color
//         // profilePicture: widget.chatWithUserInfo.imageUrl,
//         backArrowColor: context.theme.iconTheme.color,
//         chatTitle: 'Временное название',
//         // chatTitle: widget.chatWithUserInfo.userName ??
//         // widget.chatWithUserInfo.userIdentifier,
//         chatTitleTextStyle: TextStyle(
//           color: context.theme.iconTheme.color, // ник нейм юзера
//           fontWeight: FontWeight.bold,
//           fontSize: 18,
//           letterSpacing: 0.25,
//         ),
//         // userStatus: widget.chatWithUserInfo., // TODO: isOnline status
//         userStatusTextStyle: TextStyle(color: context.theme.primaryColorDark),
//         actions: const [
//           // IconButton(
//           //   icon: const Icon(
//           //     Icons.search,
//           //   ),
//           //   onPressed: () {
//           //     setState(() {
//           //       _chatController.initialMessageList.last = _chatController
//           //           .initialMessageList.last
//           //           .copyWith(status: MessageStatus.read);
//           //     });
//           //   },
//           // ),
//         ],
//       ),
//       chatBackgroundConfig: ChatBackgroundConfiguration(
//         // messageTimeIconColor: theme.messageTimeIconColor,
//         // messageTimeTextStyle: TextStyle(color: theme.messageTimeTextColor),
//         defaultGroupSeparatorConfig: DefaultGroupSeparatorConfiguration(
//           textStyle: TextStyle(
//             color: context.theme.iconTheme.color, // дата в чате
//             fontSize: 17,
//           ),
//         ),
//         backgroundColor: context.theme.scaffoldBackgroundColor,
//       ),
//       sendMessageConfig: SendMessageConfiguration(
//         imagePickerIconsConfig: ImagePickerIconsConfiguration(
//             // cameraIconColor: theme.cameraIconColor,
//             // galleryIconColor: theme.galleryIconColor,
//             ),
//         imagePickerConfiguration:
//             const ImagePickerConfiguration(imageQuality: 100),
//         // replyMessageColor: theme.replyMessageColor, // цвет пересселаемого текста
//         // defaultSendButtonColor: theme.sendButtonColor,
//         // replyDialogColor: theme.replyDialogColor, // цвет заднего фона пересылаемого сообщения
//         // replyTitleColor: theme.replyTitleColor, // цвет 'Переслать'
//         textFieldBackgroundColor: context
//             .theme.canvasColor, // цвет главного зданего пересылаемего сообщения
//         closeIconColor: Colors.black, // икона отмены пересылания ответа
//         textFieldConfig: TextFieldConfiguration(
//             onMessageTyping: (status) async {
//               // if (status == TypeWriterStatus.typing) {
//               //   await widget.serverpodController.module.typingIndicator
//               //       .sendStreamMessage(
//               //     cl.TypeIndicator(
//               //       status: true,
//               //       typerID: currentUser.id!,
//               //       channel: widget.serverpodController.channel,
//               //     ),
//               //   );
//               // }
//               // if (status == TypeWriterStatus.typed) {
//               //   await widget.serverpodController.module.typingIndicator
//               //       .sendStreamMessage(
//               //     cl.TypeIndicator(
//               //       status: false,
//               //       typerID: currentUser.id!,
//               //       channel: widget.serverpodController.channel,
//               //     ),
//               //   );
//               // }

//               /// Do with status
//               // debugPrint(status.toString());
//             },
//             compositionThresholdTime: const Duration(seconds: 1),
//             // textStyle: TextStyle(color: theme.textFieldTextColor),
//             textCapitalization: TextCapitalization.sentences // не работает
//             ),
//         // micIconColor: theme.replyMicIconColor,
//         voiceRecordingConfiguration: VoiceRecordingConfiguration(
//           // backgroundColor: theme.waveformBackgroundColor,
//           // recorderIconColor: theme.recordIconColor,
//           waveStyle: WaveStyle(
//             showMiddleLine: false,
//             // waveColor: theme.waveColor ?? Colors.white,
//             extendWaveform: true,
//           ),
//         ),
//       ),
//       chatBubbleConfig: ChatBubbleConfiguration(
//         outgoingChatBubbleConfig: ChatBubble(
//           textStyle: const TextStyle(
//             fontSize: 15,
//             color: Colors.black, // мой текст в сообщениях
//           ),
//           linkPreviewConfig: LinkPreviewConfiguration(
//             linkStyle: const TextStyle(
//               color: Colors.black,
//               decoration: TextDecoration.underline,
//             ),
//             // backgroundColor: theme.linkPreviewOutgoingChatColor,
//             // bodyStyle: theme.outgoingChatLinkBodyStyle,
//             titleStyle: context.textTheme.bodyMedium,
//           ),
//           receiptsWidgetConfig: const ReceiptsWidgetConfig(
//               showReceiptsIn: ShowReceiptsIn.lastMessage),
//           // color: theme.outgoingChatBubbleColor,
//           // TODO: вернуть
//           // readIndicatorColor: theme.indicatorReadColor,
//           // filledReadIndicatorColor: theme.filledReadIndicatorColor,
//         ),
//         inComingChatBubbleConfig: ChatBubble(
//           textStyle: TextStyle(
//             fontSize: 15,
//             color:
//                 context.theme.iconTheme.color, // текст собеседника в сообщении
//           ),
//           linkPreviewConfig: LinkPreviewConfiguration(
//             linkStyle: const TextStyle(
//               color: Colors.black,
//               decoration: TextDecoration.underline,
//             ),
//             // backgroundColor: theme.linkPreviewIncomingChatColor,
//             // bodyStyle: theme.incomingChatLinkBodyStyle,
//             titleStyle: context.textTheme.bodyMedium,
//           ),
//           onMessageRead: (message) {
//             debugPrint('Message Read: ${message.id}');
//             widget.serverpodController.markMessageRead(int.parse(message.id));
//           },
//           senderNameTextStyle: TextStyle(color: context.theme.iconTheme.color),
//           color: context.theme.canvasColor, // задний цвет сообщения собеседника
//         ),
//       ),
//       replyPopupConfig: ReplyPopupConfiguration(
//         // backgroundColor: theme.replyPopupColor,
//         onUnsendTap: (message) {
//           // TODO: вернуть
//           // widget.serverpodController.removeMessage(int.parse(message.id));
//           // _chatController.initialMessageList
//           //     .removeWhere((m) => m.id == message.id);

//           // setState(() {});
//         },
//         buttonTextStyle: TextStyle(color: Colors.black),
//         // topBorderColor: theme.replyPopupTopBorderColor,
//       ),
//       reactionPopupConfig: ReactionPopupConfiguration(
//         userReactionCallback: (message, emoji) async {
//           debugPrint(emoji);
//           // List<String>? reactionUsers = message.reaction.reactedUserIds;
//           // reactionUsers.add(currentUser.id.toString());
//           // List<String>? reactions = message.reaction.reactions;
//           // reactions.add(emoji);

//           // widget.serverpodController.setReaction(
//           //   int.parse(message.id),
//           //   reactions: message.reaction.reactions,
//           //   reactionsUsers: message.reaction.reactedUserIds,
//           // );
//         },
//         shadow: BoxShadow(
//           color: Colors.grey.shade400,
//           blurRadius: 20,
//         ),
//         backgroundColor:
//             context.theme.canvasColor, // заздний фон выбора реакций
//       ),
//       messageConfig: MessageConfiguration(
//         customMessageReplyViewBuilder: (rm) => Text(
//           'Объявление',
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//           style: TextStyle(
//             fontSize: 12,
//             // color: theme.replyMessageColor,
//           ),
//         ),
//         // adMessageModel: widget.getCustomModelViewFunction != null
//         //     ? (int id) => widget.getCustomModelViewFunction!(id)
//         //     : null,
//         messageReactionConfig: MessageReactionConfiguration(
//           // реакция под сообщением
//           backgroundColor: context.theme.canvasColor,
//           borderColor: context.theme.scaffoldBackgroundColor,
//           reactedUserCountTextStyle:
//               TextStyle(color: context.theme.iconTheme.color),
//           reactionCountTextStyle:
//               TextStyle(color: context.theme.iconTheme.color),
//           reactionsBottomSheetConfig: ReactionsBottomSheetConfiguration(
//             backgroundColor: context.theme.scaffoldBackgroundColor,
//             reactedUserTextStyle: TextStyle(
//               color: context.theme.iconTheme
//                   .color, // ник нейм при открыти ботом шита кто поставил эмоцию
//             ),
//             reactionWidgetDecoration: BoxDecoration(
//               color: context.theme.canvasColor, // задний фон ботом щита
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.shade200,
//                   offset: const Offset(0, 20),
//                   blurRadius: 40,
//                 )
//               ],
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ),
//         // imageMessageConfig: ImageMessageConfiguration(
//         //   onTap: (imageUrl) {
//         //     showModalBottomSheet(
//         //       context: context,
//         //       isScrollControlled: true,
//         //       builder: (BuildContext context) {
//         //         return GestureDetector(
//         //           onVerticalDragEnd: (details) {
//         //             Navigator.pop(context);
//         //           },
//         //           child: SizedBox(
//         //             height: MediaQuery.of(context).size.height,
//         //             child: PhotoView(
//         //               imageProvider: NetworkImage(imageUrl.),
//         //               loadingBuilder: (context, progress) =>
//         //                   const Center(child: CircularProgressIndicator()),
//         //             ),
//         //           ),
//         //         );
//         //       },
//         //     );
//         //   },
//         //   margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//         //   shareIconConfig: ShareIconConfiguration(
//         //     defaultIconBackgroundColor: context.theme.scaffoldBackgroundColor,
//         //     defaultIconColor: context.theme.iconTheme.color,
//         //   ),
//         // ),
//         // voiceMessageConfig: VoiceMessageConfiguration(
//         //   itemColor: theme.voiceMessageColor,
//         // ),
//       ),
//       profileCircleConfig: ProfileCircleConfiguration(
//         //аватарка
//         profileImageUrl: '',
//         onAvatarTap: (chatUser) =>
//             widget.onTitleTap != null ? widget.onTitleTap!() : null,
//       ),
//       repliedMessageConfig: RepliedMessageConfiguration(
//         // backgroundColor: theme.repliedMessageColor,
//         // verticalBarColor: theme.verticalBarColor,
//         repliedMsgAutoScrollConfig: RepliedMsgAutoScrollConfig(
//           enableHighlightRepliedMsg: true,
//           highlightColor: Colors.pinkAccent.shade100,
//           highlightScale: 1.1,
//         ),
//         textStyle: const TextStyle(
//           color: Colors.black,
//           fontWeight: FontWeight.bold,
//           letterSpacing: 0.25,
//         ),
//         // replyTitleTextStyle: TextStyle(color: theme.repliedTitleTextColor),
//       ),
//       swipeToReplyConfig: SwipeToReplyConfiguration(
//         replyIconColor: context.theme.iconTheme.color,
//       ),
//     );
//   }
// }
