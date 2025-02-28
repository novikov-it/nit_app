import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_tools_client/nit_tools_client.dart' as nit_tools;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_client/module.dart' as auth;
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

part 'nit_session_state.freezed.dart';
part 'nit_session_state.g.dart';

late final auth.Caller? authModuleCaller;

@freezed
class NitSessionStateModel with _$NitSessionStateModel {
  const factory NitSessionStateModel({
    required SessionManager? serverpodSessionManager,
    required int? signedInUserId,
    required List<String> scopeNames,
    required StreamingConnectionStatus websocketStatus,
    // required bool notificationsEnabled,
  }) = _NitSessionStateModel;
}

@Riverpod(keepAlive: true)
class NitSessionState extends _$NitSessionState {
  StreamingConnectionHandler? _connectionHandler;
  late final SessionManager _sessionManager;

  // StreamSubscription<SerializableModel>? _updatesSubscription;

  @override
  NitSessionStateModel build() {
    // ref.onDispose(
    //   () async {
    //     print("Cancelling subscription on dispose");
    //     await _updatesSubscription?.cancel();
    //   },
    // );

    return NitSessionStateModel(
      serverpodSessionManager: null,
      signedInUserId: null, // _sessionManager?.signedInUser,
      scopeNames: [],
      websocketStatus: StreamingConnectionStatus.disconnected,
      // notificationsEnabled: false,
    );
  }

  // May be useful for debug
  // toggleSocket() {
  //   if (_connectionHandler?.status.status ==
  //       StreamingConnectionStatus.disconnected) {
  //     _connectionHandler!.connect();
  //   }

  //   if (_connectionHandler?.status.status ==
  //       StreamingConnectionStatus.connected) {
  //     _connectionHandler!.close();
  //   }
  // }

  // int? _previousServerpodUserId;
  // Future<int?> get _getUserId async {
  //   final serverpodUserId = _sessionManager.signedInUser?.id;
  //   if (serverpodUserId == _previousServerpodUserId) {
  //     return state.signedInUserId;
  //   }

  //   _previousServerpodUserId = serverpodUserId;

  //   if (serverpodUserId == null) return null;

  //   return await nitToolsCaller!.crud
  //       .getOneCustom(
  //         className: 'User',
  //         filters: [
  //           NitBackendFilter(
  //               fieldName: 'userInfoId', equalsTo: serverpodUserId.toString())
  //         ],
  //       )
  //       .then((response) => ref.processApiResponse<int>(response))
  //       .then((res) => res);
  // }

  Future<bool> init({
    required ServerpodClientShared? client,
    // required bool enableAppNotifications,
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

    if (authModuleCaller != null) {
      _sessionManager = SessionManager(
        caller: authModuleCaller!,
      );

      if (await _sessionManager.initialize()) {
        // if (nitToolsCaller != null) {
        //   await _openUpdatesStream();
        // }

        // if (_sessionManager.isSignedIn) {
        // _updateFcm();
        // }

        state = state.copyWith(
          serverpodSessionManager: _sessionManager,
          signedInUserId: _sessionManager.signedInUser?.id,
          scopeNames: _sessionManager.signedInUser?.scopeNames ?? [],
        );

        _sessionManager.addListener(_refresh);

        return true;
      }
      return false;
    }
    return true;
  }

  _refresh() async {
    if (state.signedInUserId != _sessionManager.signedInUser?.id &&
        _connectionHandler?.status.status ==
            StreamingConnectionStatus.connected) {
      _connectionHandler?.client.closeStreamingConnection();
    }

    if (nitToolsCaller != null &&
        state.websocketStatus != StreamingConnectionStatus.connected &&
        _connectionHandler?.status.status ==
            StreamingConnectionStatus.connected) {
      _listenToUpdates();
    }
    if (_sessionManager.signedInUser?.id != state.signedInUserId) {
      // if (nitToolsCaller != null) {
      //   await _openUpdatesStream();
      // }
      // _updateFcm();

      state = NitSessionStateModel(
        serverpodSessionManager: _sessionManager,
        signedInUserId: _sessionManager.signedInUser?.id,
        scopeNames: _sessionManager.signedInUser?.scopeNames ?? [],
        websocketStatus: _connectionHandler?.status.status ??
            StreamingConnectionStatus.disconnected,
      );
    }
  }

  Future<void> _listenToUpdates() async {
    nitToolsCaller!.nitUpdates.resetStream();

    // final t = nitToolsCaller!.nitCrud.stream.listen(onData)

    await for (var update in nitToolsCaller!.nitUpdates.stream) {
      if (update is nit_tools.ObjectWrapper) {
        print("Received ${update.className} with id ${update.modelId}");
        // ref.notifyUser(update.model);
        ref.updateFromStream(update);
      }

      // May be useful for debug
      // ref.notifyUser(
      //   NitNotification.warning(
      //     update.toString(),
      //   ),
      // );
    }
  }

  // _openUpdatesStream() async {
  //   await _updatesSubscription?.cancel();

  //   print("Subscribing to updates");

  //   _updatesSubscription = nitToolsCaller!.crud
  //       .updatesStream(StreamController<SerializableModel>().stream)
  //       .listen(
  //     (update) {
  //       if (update is nit_tools.ObjectWrapper) {
  //         ref.notifyUser(update.model);
  //         ref.updateFromStream(update);
  //       }

  //       // May be useful for debug
  //       ref.notifyUser(
  //         NitNotification.warning(
  //           update.toString(),
  //         ),
  //       );
  //     },
  //     onError: (Object error, StackTrace stackTrace) =>
  //         debugPrint('$error\n$stackTrace'),
  //   );
  // }

  Future<bool> signOut() async {
    return await _sessionManager.signOut();
  }
}
