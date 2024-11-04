// import 'package:collection/collection.dart';
// import 'package:flutter/foundation.dart';
// import 'package:nit_app/nit_app.dart';

// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:serverpod_chat_client/serverpod_chat_client.dart';

// import 'chat_controller_state.dart';

// part 'chat_list_state.g.dart';


// @Riverpod(keepAlive: true)
// class ChatListState extends _$ChatListState {
//   @override
//   Future<List<ChannelInfo>> build() async {
//     // ref.onDispose(() {
//     //   ChatDispatch.getInstance(client.modules.chat)
//     //       .removeListener('user$userId');
//     // });

//     final userId = ref.watch(nitSessionStateProvider).signedInUser?.id;
//     debugPrint('building chat list for $userId');

//     // final chats = <ChatManager>[];
//     if (userId == null) return [];

//     final channels = await chatsModuleCaller.channels.getPrivateChannels();

//     newChannelListener();

//     return channels;
//   }

//   void newChannelListener() async {
//     chatsModuleCaller.channels.resetStream();

//     await for (var update in chatsModuleCaller.channels.stream) {
//       if (update is ChannelInfo) {
//         final isInChatNow =
//             ref.exists(chatControllerStateProvider(update.channel));

//         final old = state.value?.indexWhere((e) => e.channel == update.channel);

//         if (old != null && old != -1) {
//           if (isInChatNow) return;
//           final newList = state.value!;
//           newList[old] = newList[old].copyWith(
//             hasUnreadMessages: update.hasUnreadMessages,
//             lastMessage: update.lastMessage,
//           );

//           state = AsyncValue.data(_sortList(newList));
//         } else {
//           state = AsyncValue.data(_sortList([update, ...state.value!]));
//         }
//       }
//     }
//   }

//   List<ChannelInfo> _sortList(List<ChannelInfo> list) {
//     try {
//       list.sort((a, b) => b.lastMessage!.time.compareTo(a.lastMessage!.time));
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//     return list;
//   }

//   void updateState(List<ChannelInfo> newList) {
//     state = AsyncValue.data(_sortList(newList));
//   }

//   void removeChannel(ChannelInfo channel) {
//     final res = AsyncValue.data(_sortList(state.value!
//         .where((element) => element.channel != channel.channel)
//         .toList()));
//     state = res;
//   }
// }

// @riverpod
// Future<ChannelInfo?> startChat(
//   StartChatRef ref,
//   int? chatWithId,
//   int? adId,
//   int? channelInfoId,
// ) async {
//   try {
//     final future = ref.watch(chatListStateProvider);
//     final value =
//         future.maybeWhen(data: (data) => data, orElse: List<ChannelInfo>.empty);

//     ChannelInfo? channel = value.firstWhereOrNull(
//       (e) => (e.chatWith?.id == chatWithId) || e.id == channelInfoId,
//     );

//     if (channel == null) {
//       channel = await chatsModuleCaller.channels
//           .getPrivateChatChannel(chatWithId, adId);

//       ref
//           .watch(chatListStateProvider.notifier)
//           .updateState([channel, ...value]);
//     }

//     return channel;
//   } catch (e) {
//     debugPrint(e.toString());
//     return null;
//   }
// }
