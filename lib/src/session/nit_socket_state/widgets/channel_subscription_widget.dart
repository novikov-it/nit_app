import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_client/serverpod_client.dart';

import '../nit_socket_state.dart'; // где лежит nitSocketStateProvider и StreamingConnectionStatus

class ChannelSubscription extends ConsumerStatefulWidget {
  final String channel;
  final Widget child;

  const ChannelSubscription({
    super.key,
    required this.channel,
    required this.child,
  });

  @override
  ConsumerState<ChannelSubscription> createState() =>
      _ChannelSubscriptionState();
}

class _ChannelSubscriptionState extends ConsumerState<ChannelSubscription> {
  @override
  void initState() {
    super.initState();

    // если уже подключены — подпишемся после первой отрисовки
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final status = ref.read(nitSocketStateProvider).websocketStatus;
      if (status == StreamingConnectionStatus.connected) {
        ref
            .read(nitSocketStateProvider.notifier)
            .subscribeToChannel(widget.channel);
      }
    });
  }

  @override
  void dispose() {
    // гарантированно отписываемся при уходе виджета
    ref
        .read(nitSocketStateProvider.notifier)
        .unsubscribeFromChannel(widget.channel);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // слушаем статус соединения и подписываемся при переходе в connected
    ref.listen<NitSocketStateModel>(
      nitSocketStateProvider,
      (prev, next) {
        if (next.websocketStatus == StreamingConnectionStatus.connected) {
          ref
              .read(nitSocketStateProvider.notifier)
              .subscribeToChannel(widget.channel);
        }
      },
    );

    return widget.child;
  }
}
