import 'package:fcm_token_manager/fcm_token_manager.dart';
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
    return await _checkNotificationsStatus();
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

  Future<bool> updateFcm() async {
    if (ref.signedInUserId == null) return false;
    try {
      if (!kIsWeb) {
        // await FcmTokenManager.instance()
        //     .getAppNotificationPreference(ref.signedInUserId.toString());
        await FcmTokenManager.instance()
            .onLogin(userId: ref.signedInUserId.toString());
        return true;
      }

      await FirebaseMessaging.instance
          .getToken(
            vapidKey: vapidKey,
          )
          .then(
            (token) async => token != null
                ? NitFcmAppBackendInterface().updateOnServer(
                    userId: ref.signedInUserId.toString(), fcmToken: token)
                : {},
          );
      return true;
    } catch (e) {
      debugPrint(e.toString());
      ref.notifyUser(NitNotification.error(e.toString()));
      return false;
    }
    // } else {
    //   return false;
    // }
    //   },
    // );
  }

  //TODO: do on logout
  Future<bool> deleteToken() async {
    if (!kIsWeb) {
      await FcmTokenManager.instance()
          .onLogout(userId: ref.signedInUserId.toString());
    }
    return true;
  }

  Future<NitFirebaseNotificationsStateModel> _checkNotificationsStatus({
    bool requestPermission = false,
  }) async {
    debugPrint("Updating Notifications Token");
    final settings = requestPermission
        ? await FirebaseMessaging.instance.requestPermission()
        : await FirebaseMessaging.instance.getNotificationSettings();

    if (requestPermission &&
        [AuthorizationStatus.authorized, AuthorizationStatus.provisional]
            .contains(settings.authorizationStatus)) updateFcm();

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

  // requestNotificationsPermission() async {
  //   state = state.copyWith(
  //     notificationsEnabled: await _checkNotificationsStatus(
  //       refreshFcmToken: true,
  //       requestPermission: true,
  //     ),
  //   );
  // }
}

class NitFcmAppBackendInterface implements FcmAppBackendInterface {
  @override
  FutureOr<void> updateOnServer({
    required String userId,
    required String fcmToken,
  }) async {
    await nitToolsCaller!.services.setFcmToken(fcmToken: fcmToken);
  }

  @override
  FutureOr<void> deleteOnServer({
    required String userId,
  }) async {
    await nitToolsCaller!.services.deleteFcmToken(userId: int.parse(userId));
  }
}
