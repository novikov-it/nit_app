import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nit_app/src/repository/repository.dart';
import 'package:nit_riverpod_notifications/nit_riverpod_notifications.dart';
import 'package:nit_tools_client/nit_tools_client.dart' as nit_tools;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_client/module.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

import '../repository/entity_manager_state.dart';

part 'nit_session_state.g.dart';
part 'nit_session_state.freezed.dart';

late final Caller? authModuleCaller;

@freezed
class NitSessionStateModel with _$NitSessionStateModel {
  const factory NitSessionStateModel({
    required SessionManager? serverpodSessionManager,
    required UserInfo? signedInUser,
    required StreamingConnectionStatus websocketStatus,
    required bool notificationsEnabled,
  }) = _NitSessionStateModel;
}

@Riverpod(keepAlive: true)
class NitSessionState extends _$NitSessionState {
  StreamingConnectionHandler? _connectionHandler;
  SessionManager? _sessionManager;
  static late final String? vapidKey;

  @override
  NitSessionStateModel build() {
    return NitSessionStateModel(
      serverpodSessionManager: _sessionManager,
      signedInUser: _sessionManager?.signedInUser,
      websocketStatus: StreamingConnectionStatus.disconnected,
      notificationsEnabled: false,
    );
  }

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

  Future<bool> init({
    required ServerpodClientShared? client,
    required bool enableAppNotifications,
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

    if (enableAppNotifications) {
      ref.addUpdatesListener<nit_tools.AppNotification>(
        (id, model) => ref.notifyUser<nit_tools.AppNotification>(
          model as nit_tools.AppNotification,
        ),
      );
    }

    if (authModuleCaller != null) {
      _sessionManager = SessionManager(
        caller: authModuleCaller!,
      );

      if (await _sessionManager!.initialize()) {
        state = state.copyWith(
            serverpodSessionManager: _sessionManager!,
            signedInUser: _sessionManager!.signedInUser,
            notificationsEnabled: await _checkNotificationsStatus(
              refreshFcmToken: true,
            ));

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
      _connectionHandler?.client.closeStreamingConnection();
    }

    if (nitToolsCaller != null &&
        state.websocketStatus != StreamingConnectionStatus.connected &&
        _connectionHandler?.status.status ==
            StreamingConnectionStatus.connected) {
      _listenToUpdates();
    }

    state = NitSessionStateModel(
        serverpodSessionManager: _sessionManager,
        signedInUser: _sessionManager?.signedInUser,
        websocketStatus: _connectionHandler?.status.status ??
            StreamingConnectionStatus.disconnected,
        notificationsEnabled: await _checkNotificationsStatus(
            refreshFcmToken:
                state.signedInUser?.id != _sessionManager?.signedInUser?.id));
  }

  requestNotificationsPermission() async {
    state = state.copyWith(
      notificationsEnabled: await _checkNotificationsStatus(
        refreshFcmToken: true,
        requestPermission: true,
      ),
    );
  }

  Future<bool> _checkNotificationsStatus({
    required bool refreshFcmToken,
    bool requestPermission = false,
  }) async {
    debugPrint("Updating Notifications Token");
    final settings = requestPermission
        ? await FirebaseMessaging.instance.requestPermission()
        : await FirebaseMessaging.instance.getNotificationSettings();

    if ([AuthorizationStatus.authorized, AuthorizationStatus.provisional]
        .contains(
      settings.authorizationStatus,
    )) {
      if (refreshFcmToken) _updateFcm();
      return true;
    } else {
      return false;
    }
  }

  _updateFcm() async => await FirebaseMessaging.instance
      .getToken(
        vapidKey: vapidKey,
      )
      .then(
        (token) async => token != null
            ? await nitToolsCaller!.services.setFcmToken(fcmToken: token)
            : {},
      );

  Future<void> _listenToUpdates() async {
    nitToolsCaller!.crud.resetStream();
    await for (var update in nitToolsCaller!.crud.stream) {
      if (update is nit_tools.ObjectWrapper) {
        ref.notifyUser(update.className);
        ref.updateFromStream(update);
      }

      // ref.notifyUser(
      //   NitNotification.warning(
      //     update.toString(),
      //   ),
      // );
    }
  }

  Future<bool> signOut() async {
    if (_sessionManager != null && await _sessionManager!.signOut()) {
      return true;
    }

    return false;
  }
}
