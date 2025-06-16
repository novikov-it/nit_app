import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:nit_app/src/session/notifications/nit_firebase_notifications_state.dart';
import 'package:nit_app/src/session/notifications/nit_push_handler.dart';
import 'package:nit_router/nit_router.dart';
import 'package:oktoast/oktoast.dart';

import 'utils/firebase.dart';

class NitApp extends HookConsumerWidget {
  static Future<void> preInitialization({
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
      NitFirebaseNotificationsState.vapidKey = firebaseVapidKey;
      await FirebaseInitializer.init(options: firebaseOptions);
    }
  }

  const NitApp({
    super.key,
    required this.title,
    required this.routerProvider,
    // this.deeplinkHandler,
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
  final NitRouterStateProvider routerProvider;
  // final Provider<Map<NavigationZoneEnum, NavigationZoneEnum>>?

  // Provider<NitRedirectsStateModel>? redirectProvider;

  // final void Function(WidgetRef, String)? deeplinkHandler;

  final List<FutureOr<bool> Function()>? initializers;
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
            ...(initializers?.map((e) => () async => e()) ?? []),
            // if (!kIsWeb && deeplinkHandler != null)
            //   () => ref.handleDeeplinks(deeplinkHandler),
          ],
        ),
      ),
    );
    useMemoized(
      () async {
        if (FirebaseInitializer.inited) {
          FirebaseNotificationService.routerProvider = routerProvider;
          ref.read(firebaseNotificationServiceProvider);
        }
      },
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
