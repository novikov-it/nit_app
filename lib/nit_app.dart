library nit_app;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nit_app/src/deeplinks.dart';
import 'package:oktoast/oktoast.dart';

import 'src/firebase.dart';

class NitApp extends HookConsumerWidget {
  static preInitialization({
    FirebaseOptions? firebaseOptions,
  }) async {
    WidgetsFlutterBinding.ensureInitialized();

    if (firebaseOptions != null) {
      await FirebaseInitializer.init(firebaseOptions);
    }
  }

  const NitApp({
    super.key,
    required this.locale,
    required this.title,
    required this.routerProvider,
    this.deeplinkHandler,
    required this.initializers,
    required this.loadingScreen,
    required this.loadingFailedScreen,
    this.themeData,
  });

  final String locale;
  final String title;
  // final GoRouter Function() routerInitializer;
  final Provider<GoRouter> routerProvider;
  final void Function(WidgetRef, String)? deeplinkHandler;

  final List<Future<bool> Function()> initializers;
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
    final initialization = useFuture(
      useMemoized(
        () => _futuresQueue(
          [
            () async {
              await initializeDateFormatting('ru');

              return true;
            },
            ...initializers,
            () async {
              _router = ref.read(routerProvider);
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
