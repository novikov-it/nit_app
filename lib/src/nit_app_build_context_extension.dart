import 'dart:math';

import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_app/src/auth/phone_auth/phone_auth_widget.dart';

extension NitAppBuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  popOnTrue(bool value) => value ? pop() : {};

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
            // TODO: change to OverlayPortal - https://github.com/rrousselGit/riverpod/issues/3261#issuecomment-1992492897
            parent: ProviderScope.containerOf(context),
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
    Widget child,
  ) =>
      showModalBottomSheet<T>(
        context: this,
        constraints: BoxConstraints.loose(
          Size(
            MediaQuery.of(this).size.width,
            MediaQuery.of(this).size.height * 0.8,
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
          return Padding(
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
          );
        },
      );
}
