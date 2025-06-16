import 'package:fcm_token_manager/fcm_token_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:nit_app/nit_app.dart';

// import 'package:firebase_messaging/firebase_messaging.dart';

// import 'package:flutter/material.dart';

class FirebaseInitializer {
  static late final bool inited;
  FirebaseInitializer._internal();
  factory FirebaseInitializer() => _instance;
  static final FirebaseInitializer _instance = FirebaseInitializer._internal();

  static init({FirebaseOptions? options}) async {
    await Firebase.initializeApp(
      options: options,
    );
    FcmTokenManager.initialize(
      apiInterface: NitFcmAppBackendInterface(),
      tokenTtl: const Duration(days: 1),
    );

    // await FirebaseMessaging.instance
    //     .setForegroundNotificationPresentationOptions(
    //         alert: false, badge: false, sound: false);

    // Инициализация сервиса push уведомлений

    inited = true;

    // final firebaseMessaging = FirebaseMessaging.instance;
    // firebaseMessaging.requestPermission();

    // // Set the background messaging handler early on, as a named top-level function
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // await setupFlutterNotifications();

    // final FirebaseMessaging messaging = FirebaseMessaging.instance;

    // final NotificationSettings settings = await messaging.requestPermission();

    // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    //   debugPrint('User granted permission');
    // } else if (settings.authorizationStatus ==
    //     AuthorizationStatus.provisional) {
    //   debugPrint('User granted provisional permission');
    // } else {
    //   debugPrint('User declined or has not accepted permission');
    // }
  }
}
