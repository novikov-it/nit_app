import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nit_app/nit_app.dart';

class MessageTime extends ConsumerWidget {
  const MessageTime({super.key, required this.message});

  final NitChatMessage message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ChatTheme.of(context);
    return Text(
      '${message.sentAt.toLocal().hour}:${message.sentAt.toLocal().minute.toString().padLeft(2, '0')}',
      style: theme.mainTheme.timeTextStyle,
    );
  }
}
