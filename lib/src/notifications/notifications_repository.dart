// import 'dart:developer';

// import 'package:collection/collection.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nit_app/src/admin_panel/entity_manager_block.dart';
// import 'package:nit_riverpod_notifications/nit_riverpod_notifications.dart';
// import 'package:nit_tools_client/nit_tools_client.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// import '../repository/entity_list_config.dart';
// import '../repository/entity_manager_state.dart';
// import '../repository/repository.dart';

// import '../repository/single_item_custom_provider_config.dart';
// import '../session/nit_session_state.dart';
// import '../session/signed_in_extension.dart';

// part 'notifications_repository.g.dart';

// @Riverpod(keepAlive: true)
// class NotificationsRepository extends _$NotificationsRepository {
//   static late final String? vapidKey;

//   late AsyncNotifierFamilyProvider<EntityManagerState<AppNotification>,
//       List<int>, EntityListConfig> _notificationsRepository;

//   @override
//   Future<List<int>> build() async {
//     // _listenToUpdates();
//     // ref.watch(nitSessionStateProvider);
//     // if (ref.signedInUserId == null) {
//     return [];
//     // }

//     // log('NotificationsRepository: build');

//     // final firebaseMessaging = FirebaseMessaging.instance;
//     // await firebaseMessaging.requestPermission();
//     // _getFirebaseToken();
//     // _notificationsRepository = entityManagerStateProvider<AppNotification>()(
//     //   EntityListConfig(
//     //     backendFilters: [
//     //       NitBackendFilter(
//     //         fieldName: 'toUserId',
//     //         equalsTo: ref.signedInUserId.toString(),
//     //       ),
//     //     ],
//     //   ),
//     // );

//     // final ids = await ref.watch(_notificationsRepository.future);

//     // return ids.sorted(
//     //   (a, b) => ref
//     //       .readModel<AppNotification>(a)!
//     //       .timestamp
//     //       .compareTo(ref.readModel<AppNotification>(b)!.timestamp),
//     // );
//   }

//   // Future<bool> markRead() async {
//   //   return await future.then((value) async {
//   //     final lastReadId = await client.notification.markNotificationsRead();
//   //     ref.processApiResponse(lastReadId);
//   //     return true;
//   //   });
//   // }

//   Future<void> resetStream() async {
//     _listenToUpdates();
//   }

//   // _getFirebaseToken() async {
//   //   // if (kDebugMode) {
//   //   if (ref.signedInUserId == null) {
//   //     return;
//   //   }

//   //   await FirebaseMessaging.instance
//   //       .getToken(
//   //     vapidKey: vapidKey,
//   //   )
//   //       .then((value) async {

//   //     final config = SingleItemCustomProviderConfig(
//   //       backendFilters: [
//   //         NitBackendFilter(
//   //           fieldName: 'userId',
//   //           equalsTo: ref.signedInUserId.toString(),
//   //         ),
//   //       ],
//   //     );

//   //     final token = ref.watchEntityCustomState<FcmToken>(config);
//   //     token.maybeWhen(
//   //       data: (data) async {
//   //         if (data == null) {
//   //           if ((await ref.saveModel(
//   //                 FcmToken(
//   //                   fcmToken: value,
//   //                   userId: ref.signedInUserId!,
//   //                 ),
//   //               )) !=
//   //               null) {
//   //             debugPrint("FCM Token $value successfully saved to serverpod");
//   //           } else {
//   //             debugPrint("Failed to save FCM Token $value to serverpod");
//   //           }
//   //         } else if (data.fcmToken != value) {
//   //           if ((await ref.saveModel(
//   //                 data.copyWith(fcmToken: value),
//   //               )) !=
//   //               null) {
//   //             debugPrint("FCM Token $value successfully saved to serverpod");
//   //           } else {
//   //             debugPrint("Failed to save FCM Token $value to serverpod");
//   //           }
//   //         }
//   //       },
//   //       orElse: () {
//   //         debugPrint("No data yet or an error occurred.");
//   //       },
//   //     );
//   //   });
//   //   // }
//   // }

//   Future<void> _listenToUpdates() async {
//     nitToolsCaller.crud.resetStream();
//     await for (var update in nitToolsCaller.crud.stream) {
//       ref.notifyUser(NitNotification.warning(update.toString()));
//     }
//     // client.notification.resetStream();
//     // log('Listening to notification updates with user ${ref.signedInUserId}');
//     // await for (var update in client.notification.stream) {
//     //   log('Notification update: $update');
//     //   if (update is AppNotification) {
//     //     ref.notifyUser(
//     //         NitNotification.success('${update.title}\n${update.body ?? ''}'));
//     //     ref
//     //         .read(_notificationsRepository.notifier)
//     //         .manualInsert(update.id!, update);
//     //     state = AsyncData(
//     //       [...state.value!, update.id!],
//     //     );
//     //   } else if (update is Friendship) {
//     //     // ref.read(friendRepositoryProvider.notifier).updateFriendship(update);
//     //   } else if (update is DogOwner) {
//     //     ref
//     //         .read(dogOwnerRepositoryProvider(update.dogId).notifier)
//     //         .updateDogOwner(update);
//     //     ref
//     //         .read(dogOwnerRepositoryProvider(null).notifier)
//     //         .updateDogOwner(update);
//     //   } else if (update is ExtendedUser) {
//     //     ref.read(userRepositoryProvider.notifier).addUser(update);
//     //     ref.read(gpsPageStateProvider.notifier).updateUser(update);
//     //   }
//     // }
//   }
// }
