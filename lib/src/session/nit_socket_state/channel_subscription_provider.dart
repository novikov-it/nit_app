import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';

import 'nit_socket_state.dart';

final channelSubscriptionProvider =
    Provider.family<void, String>((ref, channel) {
  final sub = ref.read(nitSocketStateProvider.notifier);
  final socketState = ref.watch(nitSocketStateProvider);

  if (socketState.websocketStatus == StreamingConnectionStatus.connected) {
    sub.subscribeToChannel(channel);
  }

  ref.onDispose(() {
    sub.unsubscribeFromChannel(channel);
  });
});
