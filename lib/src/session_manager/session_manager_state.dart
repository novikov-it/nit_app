// import 'package:go_router/go_router.dart';
// import 'package:nit_router/nit_router.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:serverpod_auth_client/module.dart';
// import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

// part 'session_manager_state.g.dart';
// // part 'nit_session_state.freezed.dart';

// // extension NitSessionStateExtension on WidgetRef {
// //   int get signedInUserId => read(signedInUserProvider)!.id!;
// //   bool get userIsBlocked => read(signedInUserProvider)!.blocked;
// // }

// // extension NitSessionStateRefExtension on Ref {
// //   int get signedInUserId => read(signedInUserProvider)!.id!;
// //   bool get userIsBlocked => read(signedInUserProvider)!.blocked;
// // }

// // @riverpod
// // UserInfo? signedInUser(SignedInUserRef ref) => null;

// // final signedInUserProvider = StateProvider<UserInfo?>(
// //   (ref) => null,
// // );

// @Riverpod(keepAlive: true)
// class SessionManagerState extends _$SessionManagerState {
//   // late final StreamingConnectionHandler _connectionHandler;
//   late SessionManager _sessionManager;

//   @override
//   SessionManager build() {
//     return _sessionManager;
//   }

//   Future<bool> initializeServerpodSessionManager({
//     required Caller authCaller,
//   }) async {
//     // The session manager keeps track of the signed-in state of the user. You
//     // can query it to see if the user is currently signed in and get information
//     // about the user.
//     _sessionManager = SessionManager(
//       caller: authCaller,
//     );

//     if (await _sessionManager.initialize()) {
//       state = _sessionManager;
//       return true;
//     }

//     return false;
//   }

//   // Provider<GoRouter> prepareRouter({
//   //   required List<List<NavigationZoneEnum>> navigationZones,
//   // }) =>
//   //     Provider<GoRouter>((ProviderRef ref) {
//   //       return NitRouter.prepareRouter(
//   //         navigationZones: navigationZones,
//   //         refreshListenable: _sessionManager,
//   //         redirect: (context, route) => null,
//   //       );
//   //     });

//   // GoRouter prepareRouter({
//   //   required List<List<NavigationZoneEnum>> navigationZones,
//   // }) =>
//   //     NitRouter.prepareRouter(
//   //       navigationZones: navigationZones,
//   //       refreshListenable: _sessionManager,
//   //       redirect: (context, route) => null,
//   //     );

//   // _updateConnectionStatus(StreamingConnectionStatus status) {
//   //   _refresh(status, state.signedInUser);
//   // }

//   // _refresh(StreamingConnectionStatus status) async {
//   //   if (sessionManager.signedInUser != null) {
//   //     if (status == StreamingConnectionStatus.connected) {
//   //       ref.read(signedInUserProvider.notifier).state =
//   //           sessionManager.signedInUser;
//   //       if (sessionManager.signedInUser!.currentRole == TelemedRole.doctor) {
//   //         client.notification.updateUserOnlineStatus(
//   //             doctorUserId: sessionManager.signedInUser!.id!, isOnline: true);
//   //       } else {
//   //         client.notification.updateUserOnlineStatus(
//   //             doctorUserId: sessionManager.signedInUser!.id!, isOnline: false);
//   //       }
//   //     } else {
//   //       if (status == StreamingConnectionStatus.disconnected) {
//   //         _connectionHandler.connect();
//   //       }
//   //     }

//   //     state = state.copyWith(
//   //       sessionReady: status == StreamingConnectionStatus.connected &&
//   //           sessionManager.signedInUser != null,
//   //       websocketStatus: status,
//   //     );
//   //   }
//   //   //   // if (user != null && status == StreamingConnectionStatus.connected) {

//   //   //   // }
//   //   //   return true;
//   //   // } else {
//   //   //   await client.closeStreamingConnection();
//   //   //   return false;
//   //   // }
//   // }

//   // Future<bool> signOut() async {
//   //   // final doctorUserId = sessionManager.signedInUser!.id!;
//   //   if (await sessionManager.signOut()
//   //       // &&
//   //       // await sessionManager.refreshSession()
//   //       ) {
//   //     // await client.notification
//   //     //     .updateUserOnlineStatus(doctorUserId: doctorUserId, isOnline: false);
//   //     // setUser(sessionManager.signedInUser);
//   //     _connectionHandler.close();
//   //     // await client.closeStreamingConnection();

//   //     // client.str

//   //     // sessionManager.registerSignedInUser(userInfo, authenticationKeyId, authenticationKey)

//   //     return true;
//   //   }

//   //   return false;
//   // }
// }

// // @freezed
// // class SessionManagerStateModel with _$NitSessionStateModel {
// //   const factory NitSessionStateModel({
// //     required UserInfo? signedInUser,
// //     required StreamingConnectionStatus websocketStatus,
// //   }) = _NitSessionStateModel;
// // }
