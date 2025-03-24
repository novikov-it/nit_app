import 'package:collection/collection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nit_app/src/nit_auth/config/nit_auth_config.dart';
import 'package:nit_app/src/notifications/nit_firebase_notifications_state.dart';
// import 'package:nit_app/src/chats/state/chat_controller_state.dart';
import 'package:nit_app/src/utils/deeplinks.dart';
// import 'package:nit_router/nit_router.dart';
import 'package:nit_tools_client/nit_tools_client.dart' as nit_tools;
import 'package:nit_tools_client/nit_tools_client.dart';
import 'package:oktoast/oktoast.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as auth;

import 'repository/entity_manager_state.dart';
import 'session/nit_session_state.dart';
import 'utils/firebase.dart';

class NitApp extends HookConsumerWidget {
  static preInitialization({
    bool? goRouterOptionURLReflectsImperativeAPIs,

    /// Used to remove hash sign from URLs using
    bool? removeHashSignFromUrl,
    FirebaseOptions? firebaseOptions,
    String? firebaseVapidKey,
  }) async {
    if (removeHashSignFromUrl == true) {
      usePathUrlStrategy();
    }

    if (goRouterOptionURLReflectsImperativeAPIs != null) {
      GoRouter.optionURLReflectsImperativeAPIs =
          goRouterOptionURLReflectsImperativeAPIs;
    }

    WidgetsFlutterBinding.ensureInitialized();

    if (firebaseOptions != null) {
      await FirebaseInitializer.init(firebaseOptions);
      NitFirebaseNotificationsState.vapidKey = firebaseVapidKey;

      // // Handle when the app is in foreground
      // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //   print("📩 Foreground Notification: ${message.notification?.title}");
      // });

      // // Handle when the app is opened by clicking on a notification
      // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //   print("📩 Background Notification: ${message.notification?.title}");
      //   // _handleMessageClick(message);
      // });
    }
  }

  const NitApp({
    super.key,
    required this.title,
    required this.routerProvider,
    // this.navigationZones,
    // this.redirectProvider,
    this.client,
    this.nitAuthConfig,
    this.deeplinkHandler,
    this.initializers,
    this.loadingScreen = const Center(
      child: CircularProgressIndicator(),
    ),
    this.loadingFailedScreen = const Center(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: Text(
            'Не удалось подключиться к серверу',
          ),
        ),
      ),
    ),
    this.locale = 'ru',
    this.themeData,
  });
  //  {
  // assert(
  //   routerProvider != null || navigationZones != null,
  //   'You need to provide router configuration. Either routerProvider or navigationZones should be passed',
  // );
  // _routerProvider = routerProvider ??
  //     nitRouterStateProvider(navigationZones!, redirectProvider);
  // NitRouter.prepareRouterProvider(
  //     navigationZones: navigationZones!,
  //     redirectProvider: redirectProvider);
  // }

  final String locale;
  final String title;
  // final List<List<NavigationZoneEnum>>? navigationZones;
  // final Provider<RouterConfig<Object>> routerProvider;
  final ProviderBase<RouterConfig<Object>> routerProvider;
  // final Provider<Map<NavigationZoneEnum, NavigationZoneEnum>>?

  // Provider<NitRedirectsStateModel>? redirectProvider;

  final ServerpodClientShared? client;
  final NitAuthConfig? nitAuthConfig;
  final void Function(WidgetRef, String)? deeplinkHandler;

  final List<Future<bool> Function()>? initializers;
  final Widget loadingScreen;
  final Widget loadingFailedScreen;

  final ThemeData? themeData;

  // late final ProviderBase<GoRouter> _routerProvider;

  Future<bool> _futuresQueue(List<Future<bool> Function()> initializers) async {
    if (initializers.isEmpty) return true;

    // debugPrint('Running ${initializers.first.toString()}');
    return await initializers.first().then(
      (value) async {
        return value &&
            await _futuresQueue(
              initializers.sublist(1),
            );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialization = useFuture(
      useMemoized(
        () => _futuresQueue(
          [
            () async {
              await initializeDateFormatting('ru');

              return true;
            },
            if (client != null)
              () async {
                final nitTools = client!.moduleLookup.values
                    .firstWhereOrNull((e) => e is nit_tools.Caller);

                if (nitTools != null) {
                  nitToolsCaller = nitTools as nit_tools.Caller;
                }

                final authCaller = client!.moduleLookup.values
                    .firstWhereOrNull((e) => e is auth.Caller);

                if (authCaller == null) {
                  throw Exception(
                      'Auth module not enabled, can not init session. Add serverpod_auth module to the client');
                }

                // if (authCaller != null) {
                //   authModuleCaller = authCaller as auth.Caller;
                // }

                // authModuleCaller = client!.moduleLookup.values
                //     .firstWhereOrNull((e) => e is auth.Caller) as auth.Caller;

                // final chatsCaller = client!.moduleLookup.values
                //     .firstWhereOrNull((e) => e is chats.Caller);

                // if (chatsCaller != null) {
                //   chatsModuleCaller = chatsCaller as chats.Caller;
                // }
                // chatsModuleCaller = client!.moduleLookup.values
                //     .firstWhereOrNull((e) => e is chats.Caller) as chats.Caller;

                NitToolsClient.protocol = client!.serializationManager;

                return ref.read(nitSessionStateProvider.notifier).init(
                      authModuleCaller: authCaller as auth.Caller,
                      // enableAppNotifications: true,
                    );
              },
            if (nitAuthConfig != null)
              () async {
                NitAuthConfig.config = nitAuthConfig!;
                return true;
              },
            ...(initializers ?? []),
            // () async {
            //   if (routerProvider != null) {
            //     _router = ref.watch(routerProvider!);
            //   } else {
            //     _router = NitRouter.prepareRouter(
            //       navigationZones: navigationZones!,
            //       refreshListenable: authModuleCaller != null
            //           ? ref
            //               .read(nitSessionStateProvider)
            //               .serverpodSessionManager
            //           : null,
            //       redirect: null,
            //     );
            //   }
            //   return true;
            // },
            if (!kIsWeb && deeplinkHandler != null)
              () => ref.handleDeeplinks(deeplinkHandler),
          ],
        ),
      ),
    );

    if (initialization.connectionState != ConnectionState.done) {
      return loadingScreen;
    }

    if (!initialization.hasData || initialization.data! != true) {
      debugPrint(initialization.error?.toString());
      debugPrint(initialization.stackTrace?.toString());
      return loadingFailedScreen;
    }

    return OKToast(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: themeData,
        title: title,
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown,
          },
        ),
        routerConfig: ref.watch(
          routerProvider,
          // routerProvider ??
          //     NitRouter.prepareRouterProvider(
          //       navigationZones: navigationZones!,
          //       redirectProvider: redirectProvider,
          //     ),
        ),
        // routerDelegate: _router.routerDelegate,
        // routeInformationProvider: _router.routeInformationProvider,
        // routeInformationParser: _router.routeInformationParser,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: Locale(locale, ''),
        supportedLocales: [
          Locale(locale, ''),
        ],
      ),
    );
  }
}
