import 'dart:math';

import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_app/src/auth/phone_auth/phone_auth_widget.dart';

extension NitAppBuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  popOnTrue(bool value) => mounted && value ? pop() : {};
  popIfNotNull(dynamic value) => mounted && value != null ? pop() : {};

  // mountedAction(BuildContext context, ())
  mountedPushNamed(String name) => mounted ? pushNamed(name) : {};
  mountedGoNamed(String name) => mounted ? goNamed(name) : {};

  static final maxMobileScreenWidth =
      (defaultTargetPlatform == TargetPlatform.android ||
              defaultTargetPlatform == TargetPlatform.iOS)
          ? AdaptiveWindowType.medium.widthRangeValues.end
          : AdaptiveWindowType.small.widthRangeValues.end;

  bool get isMobile => MediaQuery.sizeOf(this).width <= maxMobileScreenWidth;

  requireLogin(
    WidgetRef ref, {
    Function()? thenAction,
  }) async {
    final userLoggedIn =
        ref.read(nitSessionStateProvider).signedInUser != null ||
            true ==
                await showBottomSheetOrDialog<bool>(
                  NitDialogLayout(
                    title: 'Войдите в приложение',
                    child: PhoneAuthWidget(
                      onSuccess: pop,
                    ),
                  ),
                );

    if (userLoggedIn && thenAction != null) thenAction();
  }

  Future<T?> showBottomSheetOrDialog<T>(
    Widget child,
  ) =>
      isMobile ? showForceBottomSheetDialog(child) : showForceDialog(child);

  Future<T?> showForceDialog<T>(
    Widget child,
  ) =>
      showDialog<T>(
        context: this,
        builder: (context) {
          return ProviderScope(
            overrides: [
              navigationPathParametersProvider.overrideWith(
                (ref) => ProviderScope.containerOf(this)
                    .read(navigationPathParametersProvider),
              )
            ],
            child: Dialog(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  16,
                ),
              ),
              child: SizedBox(
                width: 450,
                child: Container(
                  margin: EdgeInsets.only(
                    top: 24,
                    left: 24,
                    right: 24,
                    bottom: max(24, MediaQuery.of(context).viewInsets.bottom),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(
                            Icons.clear,
                            size: 16,
                          ),
                          onPressed: () {
                            context.pop();
                          },
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: child,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );

  Future<T?> showForceBottomSheetDialog<T>(
    Widget child, {
    double maxHeightPercentage = 0.8,
  }) =>
      showModalBottomSheet<T>(
        context: this,
        constraints: BoxConstraints.loose(
          Size(
            MediaQuery.of(this).size.width,
            MediaQuery.of(this).size.height * maxHeightPercentage,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        isScrollControlled: true,
        builder: (BuildContext context) {
          return ProviderScope(
            overrides: [
              navigationPathParametersProvider.overrideWith(
                (ref) => ProviderScope.containerOf(this)
                    .read(navigationPathParametersProvider),
              )
            ],
            child: Padding(
              // height: MediaQuery.of(context).size.height * 0.7,
              padding: EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
                bottom: max(
                  16,
                  MediaQuery.of(context).viewInsets.bottom,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      height: 4,
                      width: MediaQuery.sizeOf(context).width * 0.15,
                      decoration: BoxDecoration(
                        color: context.theme.colorScheme.outline,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const Gap(16),
                  // child,
                  Flexible(
                    fit: FlexFit.loose,
                    child: child,
                  ),
                ],
              ),
            ),
          );
        },
      );
}
