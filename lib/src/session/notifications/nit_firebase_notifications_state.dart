// import 'package:fcm_token_manager/fcm_token_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_riverpod_notifications/nit_riverpod_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nit_firebase_notifications_state.freezed.dart';
part 'nit_firebase_notifications_state.g.dart';

@freezed
abstract class NitFirebaseNotificationsStateModel
    with _$NitFirebaseNotificationsStateModel {
  const factory NitFirebaseNotificationsStateModel({
    required bool notificationsAllowed,
    required bool mayRequest,
  }) = _NitFirebaseNotificationsStateModel;

  static const loadingModel = NitFirebaseNotificationsStateModel(
    notificationsAllowed: false,
    mayRequest: false,
  );
}

@riverpod
class NitFirebaseNotificationsState extends _$NitFirebaseNotificationsState {
  static late final String? vapidKey;

  @override
  Future<NitFirebaseNotificationsStateModel> build() async {
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      if (ref.signedIn) {
        nitToolsCaller!.services.setFcmToken(fcmToken: fcmToken);
      }
    });
    return await _checkNotificationsStatus(requestPermission: true);
  }

  Future<bool> requestPermission() async {
    await future.then(
      (currentState) async {
        state = AsyncData(
          await _checkNotificationsStatus(requestPermission: true),
        );
      },
    );

    return true;
  }

  Future<bool> updateFcm(String? userId) async {
    if (userId == null) return false;
    try {
      if (!kIsWeb) {
        final token = await FirebaseMessaging.instance.getToken();
        if (token != null) {
          nitToolsCaller!.services.setFcmToken(fcmToken: token);
        }
        return true;
      }

      await FirebaseMessaging.instance
          .getToken(
            vapidKey: vapidKey,
          )
          .then(
            (token) async => token != null
                ? nitToolsCaller!.services.setFcmToken(fcmToken: token)
                : {},
          );
      return true;
    } catch (e) {
      debugPrint(e.toString());
      ref.notifyUser(NitNotification.error(e.toString()));
      return false;
    }
  }

  Future<bool> deleteToken(int? userId) async {
    if (!kIsWeb && userId != null) {
      await FirebaseMessaging.instance.deleteToken();
      nitToolsCaller!.services.deleteFcmToken(userId: userId);
    }
    return true;
  }

  Future<NitFirebaseNotificationsStateModel> _checkNotificationsStatus({
    bool requestPermission = false,
  }) async {
    debugPrint("Updating Notifications Token");
    final settings = requestPermission
        ? await FirebaseMessaging.instance.requestPermission(alert: false)
        : await FirebaseMessaging.instance.getNotificationSettings();

    // if (requestPermission &&
    //     [AuthorizationStatus.authorized, AuthorizationStatus.provisional]
    //         .contains(settings.authorizationStatus)) updateFcm();

    return switch (settings.authorizationStatus) {
      AuthorizationStatus.authorized ||
      AuthorizationStatus.provisional =>
        NitFirebaseNotificationsStateModel(
          notificationsAllowed: true,
          mayRequest: true,
        ),
      AuthorizationStatus.denied => NitFirebaseNotificationsStateModel(
          notificationsAllowed: false,
          mayRequest: false,
        ),
      AuthorizationStatus.notDetermined => NitFirebaseNotificationsStateModel(
          notificationsAllowed: false,
          mayRequest: true,
        ),
    };
  }
}
