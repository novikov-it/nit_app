// import 'package:collection/collection.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:serverpod_chat_client/module.dart';
// import 'chat_list_state.dart';

// part 'selected_chat_provider.g.dart';

// final selectedChatIdProvider = StateProvider<int?>(
//   (ref) => null,
// );

// @Riverpod()
// AsyncValue<ChannelInfo?> selectedChat(
//   SelectedChatRef ref,
// ) {
//   final chatId = ref.watch(
//     selectedChatIdProvider,
//   );

//   if (chatId == null) return const AsyncData(null);

//   return ref
//       .watch(
//         chatListStateProvider,
//       )
//       .whenData(
//         (value) => value.firstWhereOrNull(
//           (e) => e.id == chatId,
//         ),
//       );
// }
