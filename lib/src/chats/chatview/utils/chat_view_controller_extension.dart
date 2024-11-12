// import 'package:chatview/chatview.dart';
// import 'serverpod_chat_message_extension.dart';
// import 'package:serverpod_chat_client/serverpod_chat_client.dart';

// extension ChatViewControllerExtension on ChatController {
//   loadMessagesFromServerpod({
//     required List<ChatMessage> messages,
//     required int lastReadMessageId,
//   }) {
//     final List<Message> messageList = messages
//         .map(
//           (m) => m.convertToUIMessage(
//             m.id == null || m.id! <= lastReadMessageId,
//           ),
//         )
//         .toList();

//     final Map<String, ChatUser> usersMap = {};

//     for (var m in messages) {
//       final id = m.senderInfo?.id.toString();
//       if (
//           // TODO: проверить, как работает
//           // id != currentUser.id &&
//           usersMap[id] == null) {
//         usersMap[m.senderInfo?.id.toString() ?? '-'] = ChatUser(
//           id: m.senderInfo?.id.toString() ?? '-',
//           name: m.senderInfo?.fullName ?? 'XXX',
//           profilePhoto: m.senderInfo?.imageUrl,
//         );
//       }
//     }

//     otherUsers.addAll(
//       usersMap.values.where((e) => !otherUsers.contains(e)),
//     );
//     loadMoreData(messageList);
//   }
// }
