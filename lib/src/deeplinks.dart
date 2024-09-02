import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uni_links/uni_links.dart';

extension DeeplinksExtension on WidgetRef {
  Future<bool> handleDeeplinks(
      Function(WidgetRef, String)? deeplinkHandler) async {
    linkStream.listen(
      (link) {
        debugPrint("deeplink $link");

        if (link == null) return;

        deeplinkHandler!(this, link);
      },
    );

    final link = await getInitialLink();

    if (link != null) {
      debugPrint("Initial deeplink: $link");
      deeplinkHandler!(this, link);
    }
    return true;
  }
}
