// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nit_app/nit_app.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'unread_chats_provider.g.dart';

// @riverpod
// AsyncValue<int> unreadChatsCount(
//   Ref ref,
// ) {
//   return ref.watch(chatListStateProvider).whenData((data) => data.channels
//       .where(
//         (e) =>
//             ref
//                 .watch(
//                   chatControllerStateProvider(e.channelName),
//                 )
//                 .unreadMessageCount >
//             0,
//         // .maybeWhen(
//         //   data: (data) => data.unreadMessageCount > 0 ? 1 : 0,
//         //   orElse: () => 0,
//         // ),
//       )
//       .length);

//   // return res.isEmpty ? 0 : res.reduce((value, element) => value + element);
// }
