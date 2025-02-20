// import 'package:collection/collection.dart';
// import 'package:kerla2_client/kerla2_client.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'chat_controller_state.dart';
// import 'chat_list_state.dart';

// part 'filtered_chat_list_provider.g.dart';

// @riverpod
// AsyncValue<List<ChannelInfo>> filteredChatList(
//   FilteredChatListRef ref,
// ) {
//   return ref.watch(chatListStateProvider).whenData(
//         (channels) => channels
//             .where(
//               (e) => ref
//                   .watch(
//                     chatControllerStateProvider(e.channel),
//                   )
//                   .maybeWhen(
//                     data: (data) =>
//                         // e.id == ref.watch(selectedChatIdProvider) ||
//                         data.lastMessage != null ? true : false,
//                     orElse: () => false,
//                   ),
//             )
//             .sortedBy((e) => ref
//                 .watch(
//                   chatControllerStateProvider(e.channel),
//                 )
//                 .value!
//                 .lastMessage!
//                 .time)
//             .reversed
//             .toList(),
//       );
// }
