// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'chat_list_state.dart';

// part 'unread_chats_provider.g.dart';

// @riverpod
// AsyncValue<bool> hasUnreadChat(
//   HasUnreadChatRef ref,
// ) {
//   return ref.watch(chatListStateProvider).maybeWhen(
//         orElse: () => const AsyncData(false),
//         data: (channels) => AsyncData(
//           channels.isEmpty
//               ? false
//               : channels.any((element) => element.hasUnreadMessages),
//         ),
//       );

//   // return ref.watch(chatListStateProvider).whenData(
//   //       (channels) => channels.isEmpty
//   //           ? false
//   //           : channels.any((element) => element.hasUnreadMessages),
//   //     );
// }
