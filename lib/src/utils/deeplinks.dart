import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

extension DeeplinksExtension on WidgetRef {
  Future<bool> handleDeeplinks(
    Function(WidgetRef, String)? deeplinkHandler,
  ) async {
    AppLinks().stringLinkStream.listen(
      (link) {
        debugPrint("deeplink $link");

        // if (link ) return;

        deeplinkHandler!(this, link);
      },
    );

    final link = await AppLinks().getInitialLinkString();

    if (link != null) {
      debugPrint("Initial deeplink: $link");
      deeplinkHandler!(this, link);
    }
    return true;
  }
}
