import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_app/src/utils/firebase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_client/module.dart' as auth;
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

part 'nit_session_state.freezed.dart';
part 'nit_session_state.g.dart';

@freezed
class NitSessionStateModel with _$NitSessionStateModel {
  const factory NitSessionStateModel({
    required SessionManager? serverpodSessionManager,
    required int? signedInUserId,
    required List<String> scopeNames,
  }) = _NitSessionStateModel;
}

@Riverpod(keepAlive: true)
class NitSessionState extends _$NitSessionState {
  late final SessionManager _sessionManager;
  late final Future<int?> Function(int? userId)?
      _signedInUserIdPreloadProcessing;
  // Future<void> Function(int? userId)? _preloadActions;

  @override
  NitSessionStateModel build() {
    return NitSessionStateModel(
      serverpodSessionManager: null,
      signedInUserId: null,
      scopeNames: [],
    );
  }

  Future<bool> init({
    required auth.Caller authModuleCaller,
    Future<int?> Function(int? userId)? signedInUserIdPreloadProcessing,
  }) async {
    // _preloadActions = preloadActions;
    _sessionManager = SessionManager(
      caller: authModuleCaller,
    );
    _signedInUserIdPreloadProcessing = signedInUserIdPreloadProcessing;

    if (!await _sessionManager.initialize()) return false;

    state = state.copyWith(
      serverpodSessionManager: _sessionManager,
      signedInUserId: await _processUserInfoId(
        _sessionManager.signedInUser?.id,
      ), // ,
      scopeNames: _sessionManager.signedInUser?.scopeNames ?? [],
    );

    _sessionManager.addListener(_refresh);

    return true;
  }

  Future<bool> signOut() async {
    return await _sessionManager.signOut();
  }

  Future<int?> _processUserInfoId(int? serverpodUserInfoId) async =>
      _signedInUserIdPreloadProcessing == null
          ? serverpodUserInfoId
          : await _signedInUserIdPreloadProcessing.call(
              serverpodUserInfoId,
            );

  _refresh() async {
    // if (state.signedInUserId != _sessionManager.signedInUser?.id &&
    //     _connectionHandler?.status.status ==
    //         StreamingConnectionStatus.connected) {
    //   _connectionHandler?.client.closeStreamingConnection();
    // }

    // if (nitToolsCaller != null &&
    //     state.websocketStatus != StreamingConnectionStatus.connected &&
    //     _connectionHandler?.status.status ==
    //         StreamingConnectionStatus.connected) {
    //   _listenToUpdates();
    // }
    if (_sessionManager.signedInUser?.id != state.signedInUserId) {
      if (FirebaseInitializer.inited) {
        if (_sessionManager.signedInUser?.id == null) {
          ref
              .read(nitFirebaseNotificationsStateProvider.notifier)
              .deleteToken(state.signedInUserId);
        } else {
          ref
              .read(nitFirebaseNotificationsStateProvider.notifier)
              .updateFcm(_sessionManager.signedInUser?.id.toString());
        }
      }

      // if (nitToolsCaller != null) {
      //   await _openUpdatesStream();
      // }
      // _updateFcm();

      final userId = await _processUserInfoId(
        _sessionManager.signedInUser?.id,
      );

      state = NitSessionStateModel(
        serverpodSessionManager: _sessionManager,
        signedInUserId: userId,
        //  await _processUserInfoId(
        //   _sessionManager.signedInUser?.id,
        // ),
        scopeNames: _sessionManager.signedInUser?.scopeNames ?? [],
        // websocketStatus: _connectionHandler?.status.status ??
        //     StreamingConnectionStatus.disconnected,
      );
    }
  }

  // Future<void> _listenToUpdates() async {
  //   nitToolsCaller!.nitUpdates.resetStream();

  //   // final t = nitToolsCaller!.nitCrud.stream.listen(onData)

  //   await for (var update in nitToolsCaller!.nitUpdates.stream) {
  //     if (update is nit_tools.ObjectWrapper) {
  //       print("Received ${update.className} with id ${update.modelId}");
  //       // ref.notifyUser(update.model);
  //       ref.updateFromStream(update);
  //     }

  //     // May be useful for debug
  //     // ref.notifyUser(
  //     //   NitNotification.warning(
  //     //     update.toString(),
  //     //   ),
  //     // );
  //   }
  // }

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
}
