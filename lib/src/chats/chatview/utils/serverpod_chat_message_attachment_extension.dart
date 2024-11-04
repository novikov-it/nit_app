import 'package:chatview/chatview.dart';
import 'package:serverpod_chat_client/serverpod_chat_client.dart';

extension ServerpodChatMessageAttachmentExtension on ChatMessageAttachment {
  MessageType get messageType {
    if (contentType == 'image') {
      return MessageType.image;
    } else if (contentType == 'audio') {
      return MessageType.voice;
      // } else if (attachmentType == ChatAttachmentTypeEnum.adShare) {
      //   return MessageType.custom;
    } else {
      return MessageType.text;
    }
  }
}
