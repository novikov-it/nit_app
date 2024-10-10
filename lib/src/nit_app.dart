import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nit_app/src/tools/deeplinks.dart';
import 'package:nit_app/src/session_manager/session_manager_state.dart';
import 'package:nit_router/nit_router.dart';
import 'package:oktoast/oktoast.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart';

import 'tools/firebase.dart';

class NitApp extends HookConsumerWidget {
  static preInitialization({
    bool? goRouterOptionURLReflectsImperativeAPIs,
    FirebaseOptions? firebaseOptions,
  }) async {
    if (goRouterOptionURLReflectsImperativeAPIs != null) {
      GoRouter.optionURLReflectsImperativeAPIs =
          goRouterOptionURLReflectsImperativeAPIs;
    }

    WidgetsFlutterBinding.ensureInitialized();

    if (firebaseOptions != null) {
      await FirebaseInitializer.init(firebaseOptions);
    }
  }

  // static sessionBasedRouter({
  //   required List<List<NavigationZoneEnum>> navigationZones,
  // }) =>
  //     (ProviderRef ref) {
  //       return NitRouter.prepareRouter(
  //         navigationZones: navigationZones,
  //         refreshListenable: sessionManager,
  //         redirect: (context, route) => null,
  //       );
  //     };

  const NitApp({
    super.key,
    required this.title,
    this.routerProvider,
    this.navigationZones,
    this.authCaller,
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

  final String locale;
  final String title;
  // final GoRouter Function() routerInitializer;
  final List<List<NavigationZoneEnum>>? navigationZones;
  final Provider<GoRouter>? routerProvider;
  final Caller? authCaller;
  final void Function(WidgetRef, String)? deeplinkHandler;

  final List<Future<bool> Function()>? initializers;
  final Widget loadingScreen;
  final Widget loadingFailedScreen;

  final ThemeData? themeData;

  static late final GoRouter _router;

  Future<bool> _futuresQueue(List<Future<bool> Function()> initializers) async {
    if (initializers.isEmpty) return true;

    debugPrint('Running ${initializers.first.toString()}');
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
    assert(
      routerProvider != null || (navigationZones != null && authCaller != null),
      'You need to provide router configuration. Either routerProvider should be passed, or both navigationZones and authCaller',
    );
    final initialization = useFuture(
      useMemoized(
        () => _futuresQueue(
          [
            () async {
              await initializeDateFormatting('ru');

              return true;
            },
            if (authCaller != null)
              // () => initializeServerpodSessionManager(authCaller: authCaller!),
              () => ref
                  .read(sessionManagerStateProvider.notifier)
                  .initializeServerpodSessionManager(authCaller: authCaller!),
            ...(initializers ?? []),
            () async {
              if (routerProvider != null) {
                _router = ref.read(routerProvider!);
              } else {
                _router = ref
                    .read(sessionManagerStateProvider.notifier)
                    .prepareRouter(navigationZones: navigationZones!);
              }
              return true;
            },
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
        routerDelegate: _router.routerDelegate,
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
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
