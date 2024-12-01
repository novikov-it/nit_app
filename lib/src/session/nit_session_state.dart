import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:nit_app/src/session_manager/session_manager_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_client/module.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

part 'nit_session_state.g.dart';
part 'nit_session_state.freezed.dart';

late final Caller? authModuleCaller;

@Riverpod(keepAlive: true)
class NitSessionState extends _$NitSessionState {
  StreamingConnectionHandler? _connectionHandler;
  SessionManager? _sessionManager;

  @override
  NitSessionStateModel build() {
    return NitSessionStateModel(
      serverpodSessionManager: _sessionManager,
      signedInUser: _sessionManager?.signedInUser,
      websocketStatus: StreamingConnectionStatus.disconnected,
    );
  }

  toggleSocket() {
    if (_connectionHandler?.status.status ==
        StreamingConnectionStatus.disconnected) {
      _connectionHandler!.connect();
    }

    if (_connectionHandler?.status.status ==
        StreamingConnectionStatus.connected) {
      _connectionHandler!.close();
    }
  }

  Future<bool> init({
    required ServerpodClientShared? client,
    // required Caller? authCaller,
  }) async {
    if (client != null) {
      _connectionHandler = StreamingConnectionHandler(
        client: client,
        retryEverySeconds: 1,
        listener: (connectionState) async {
          debugPrint('listener called ${connectionState.status}');
          _refresh();
        },
      );

      _connectionHandler!.connect();
    }

    // The session manager keeps track of the signed-in state of the user. You
    // can query it to see if the user is currently signed in and get information
    // about the user.
    if (authModuleCaller != null) {
      _sessionManager = SessionManager(
        caller: authModuleCaller!,
      );

      if (await _sessionManager!.initialize()) {
        state = state.copyWith(
          serverpodSessionManager: _sessionManager!,
          signedInUser: _sessionManager!.signedInUser,
        );

        _sessionManager!.addListener(_refresh);

        return true;
      }
      return false;
    }
    return true;
  }

  _refresh() async {
    if (state.signedInUser?.id != _sessionManager?.signedInUser?.id &&
        _connectionHandler?.status.status ==
            StreamingConnectionStatus.connected) {
      // _connectionHandler?.close();

      // _connectionHandler.client.openStreamingConnection()
      _connectionHandler?.client.closeStreamingConnection();
      // _connectionHandler?.client.openStreamingConnection();
      // _connectionHandler?.connect();
    }

    state = NitSessionStateModel(
      serverpodSessionManager: _sessionManager,
      signedInUser: _sessionManager?.signedInUser,
      websocketStatus: _connectionHandler?.status.status ??
          StreamingConnectionStatus.disconnected,
    );
    // state = state.copyWith(
    //   sessionReady: status == StreamingConnectionStatus.connected &&
    //       sessionManager.signedInUser != null,
    //   websocketStatus: status,
    // );

    //   // if (user != null && status == StreamingConnectionStatus.connected) {

    //   // }
    //   return true;
    // } else {
    //   await client.closeStreamingConnection();
    //   return false;
    // }
  }

  Future<bool> signOut() async {
    // final doctorUserId = sessionManager.signedInUser!.id!;
    if (_sessionManager != null && await _sessionManager!.signOut()) {
      // state = state.copyWith(signedInUser: null);
      // _connectionHandler.close();
      // await client.closeStreamingConnection();

      // client.str

      // sessionManager.registerSignedInUser(userInfo, authenticationKeyId, authenticationKey)

      return true;
    }

    return false;
  }

  // _updateConnectionStatus(StreamingConnectionStatus status) {
  //   _refresh(status, state.signedInUser);
  // }

  // _refresh(StreamingConnectionStatus status) async {
  //   if (sessionManager.signedInUser != null) {
  //     if (status == StreamingConnectionStatus.connected) {
  //       ref.read(signedInUserProvider.notifier).state =
  //           sessionManager.signedInUser;
  //       if (sessionManager.signedInUser!.currentRole == TelemedRole.doctor) {
  //         client.notification.updateUserOnlineStatus(
  //             doctorUserId: sessionManager.signedInUser!.id!, isOnline: true);
  //       } else {
  //         client.notification.updateUserOnlineStatus(
  //             doctorUserId: sessionManager.signedInUser!.id!, isOnline: false);
  //       }
  //     } else {
  //       if (status == StreamingConnectionStatus.disconnected) {
  //         _connectionHandler.connect();
  //       }
  //     }

  //     state = state.copyWith(
  //       sessionReady: status == StreamingConnectionStatus.connected &&
  //           sessionManager.signedInUser != null,
  //       websocketStatus: status,
  //     );
  //   }
  //   //   // if (user != null && status == StreamingConnectionStatus.connected) {

  //   //   // }
  //   //   return true;
  //   // } else {
  //   //   await client.closeStreamingConnection();
  //   //   return false;
  //   // }
  // }

  // Future<bool> signOut() async {
  //   // final doctorUserId = sessionManager.signedInUser!.id!;
  //   if (await sessionManager.signOut()
  //       // &&
  //       // await sessionManager.refreshSession()
  //       ) {
  //     // await client.notification
  //     //     .updateUserOnlineStatus(doctorUserId: doctorUserId, isOnline: false);
  //     // setUser(sessionManager.signedInUser);
  //     _connectionHandler.close();
  //     // await client.closeStreamingConnection();

  //     // client.str

  //     // sessionManager.registerSignedInUser(userInfo, authenticationKeyId, authenticationKey)

  //     return true;
  //   }

  //   return false;
  // }
}

@freezed
class NitSessionStateModel with _$NitSessionStateModel {
  const factory NitSessionStateModel({
    required SessionManager? serverpodSessionManager,
    required UserInfo? signedInUser,
    required StreamingConnectionStatus websocketStatus,
  }) = _NitSessionStateModel;
}
