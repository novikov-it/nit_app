import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nit_app/nit_app.dart';

class EmojiBubble extends ConsumerWidget {
  final NitChatMessage message;

  const EmojiBubble({
    super.key,
    required this.message,
  });

  final double maxEmojiSize = 96;

  // Извлекаем эмодзи из текста
  List<String> _extractEmojis(String text) {
    final emojiRegExp = RegExp(
        r'[\u{1F300}-\u{1F5FF}\u{1F600}-\u{1F64F}\u{1F680}-\u{1F6FF}\u{1F700}-\u{1F77F}\u{1F780}-\u{1F7FF}\u{1F800}-\u{1F8FF}\u{1F900}-\u{1F9FF}\u{1FA00}-\u{1FA6F}\u{1FA70}-\u{1FAFF}\u{2702}-\u{27B0}\u{24C2}-\u{1F251}]',
        unicode: true);
    return emojiRegExp
        .allMatches(text)
        .map((match) => match.group(0)!)
        .toList();
  }

  // Определяем размер эмодзи в зависимости от их количества
  double _getEmojiSize(int count) {
    if (count == 1) return maxEmojiSize * 1.0;
    if (count == 2) return maxEmojiSize * 0.7;
    if (count == 3) return maxEmojiSize * 0.5;
    return maxEmojiSize * 0.2;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ChatTheme.of(context);

    final bubbleTheme = message.userId == ref.signedInUserId
        ? theme.outgoingBubble
        : theme.incomingBubble;

    final emojis = _extractEmojis(message.text!);
    final emojiSize = _getEmojiSize(emojis.length);

    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      alignment: WrapAlignment.start,
      children: emojis.map((emoji) {
        return Text(
          emoji,
          style: bubbleTheme.textStyle?.copyWith(fontSize: emojiSize),
        );
      }).toList(),
    );
  }
}
