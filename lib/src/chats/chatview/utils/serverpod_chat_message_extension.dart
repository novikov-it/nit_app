import 'package:chatview/chatview.dart';
import 'package:serverpod_chat_client/serverpod_chat_client.dart';
import 'serverpod_chat_message_attachment_extension.dart';

/// Converts a message to UI message.
extension ServerpodChatMessageExtension on ChatMessage {
  MessageType _getMessageType() {
    if (attachments?.firstOrNull?.messageType.isVoice == true) {
      return MessageType.voice;
    } else if (attachments?.firstOrNull?.messageType.isImage == true) {
      return MessageType.image;
      // } else if (attachments?.firstOrNull?.attachmentType ==
      //     ChatAttachmentTypeEnum.adShare) {
      //   return MessageType.custom;
    } else {
      return MessageType.text;
    }
  }

  // int? getCustomEntityId() {
  //   if (attachments?.firstOrNull?.attachmentType ==
  //           ChatAttachmentTypeEnum.adShare &&
  //       attachments?.firstOrNull?.fileName != null) {
  //     return int.parse(attachments!.firstOrNull!.fileName);
  //   }
  //   return null;
  // }

  /// Converts to UI message.
  Message convertToUIMessage(bool isRead) {
    return Message(
      id: id.toString(),
      message: _getMessageType() == MessageType.text
          ? message
          : attachments!.firstOrNull!.url,
      createdAt: time.toLocal(),
      sentBy: sender.toString(),
      status: isRead ? MessageStatus.read : MessageStatus.delivered,
      replyMessage:
          // TODO: реализовать ответ на сообщения
          // replyMessages != null
          //     ? toFormat(replyMessages!)
          //     :
          const ReplyMessage(),
      messageType: attachments?.firstOrNull?.messageType ?? MessageType.text,
      voiceMessageDuration: const Duration(seconds: 40),
      // reaction: Reaction(
      //   reactions: reactions ?? [],
      //   reactedUserIds: reactionsUsers ?? [],
      // ),
      // customEntityId: getCustomEntityId(),
    );
  }
}
