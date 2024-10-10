import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// import 'package:flutter/material.dart';

class FirebaseInitializer {
  static init(FirebaseOptions options) async {
    await Firebase.initializeApp(
      options: options,
    );

    final firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.requestPermission();

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
