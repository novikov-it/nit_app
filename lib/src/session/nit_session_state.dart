import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_tools_client/nit_tools_client.dart' as nit_tools;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_client/module.dart' as auth;
import 'package:serverpod_auth_client/serverpod_auth_client.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

part 'nit_session_state.freezed.dart';
part 'nit_session_state.g.dart';

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

  @override
  NitSessionStateModel build() {
    return NitSessionStateModel(
      serverpodSessionManager: null,
      signedInUserId: null,
      scopeNames: [],
      websocketStatus: StreamingConnectionStatus.disconnected,
      // notificationsEnabled: false,
    );
  }

  Future<bool> init({
    // required ServerpodClientShared? client,
    required auth.Caller authModuleCaller,
  }) async {
    // if (client != null) {
    //   _connectionHandler = StreamingConnectionHandler(
    //     client: client,
    //     retryEverySeconds: 1,
    //     listener: (connectionState) async {
    //       debugPrint('listener called ${connectionState.status}');
    //       _refresh();
    //     },
    //   );

    //   _connectionHandler!.connect();
    // }

    // if (authModuleCaller != null) {
    _sessionManager = SessionManager(
      caller: authModuleCaller,
    );

    if (!await _sessionManager.initialize()) return false;

    if (_sessionManager.signedInUser != null) await _updateRepository();

    state = state.copyWith(
      serverpodSessionManager: _sessionManager,
      signedInUserId: _sessionManager.signedInUser?.id,
      scopeNames: _sessionManager.signedInUser?.scopeNames ?? [],
    );

    _sessionManager.addListener(_refresh);

    return true;

    // return true;
  }

  _updateRepository() async {
    await nitToolsCaller!.nitCrud.getOneCustom(
      className: 'UserProfile',
      filters: [
        NitBackendFilter(
          fieldName: 'userId',
          equalsTo: _sessionManager.signedInUser!.id!.toString(),
        )
      ],
    ).then(
      (response) => ref.processApiResponse<int>(response),
    );
    // ref.manualUpdate<UserInfo>(
    //   _sessionManager.signedInUser!.id!,
    //   _sessionManager.signedInUser!,
    // );
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

      if (_sessionManager.signedInUser != null) await _updateRepository();

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
