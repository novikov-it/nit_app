part of 'nit_chat_widgets.dart';

class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final chatTheme = ChatTheme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: chatTheme.incomingBubble.backgroundColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _TypingDot(
                  delay: 0,
                  color: chatTheme.typingIndicatorColor,
                  size: chatTheme.typingIndicatorSize,
                ),
                const SizedBox(width: 4),
                _TypingDot(
                  delay: 200,
                  color: chatTheme.typingIndicatorColor,
                  size: chatTheme.typingIndicatorSize,
                ),
                const SizedBox(width: 4),
                _TypingDot(
                  delay: 400,
                  color: chatTheme.typingIndicatorColor,
                  size: chatTheme.typingIndicatorSize,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TypingDot extends HookWidget {
  final int delay;
  final Color color;
  final double size;

  const _TypingDot({
    required this.delay,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final animation = useAnimationController(
      duration: const Duration(milliseconds: 600),
    );
    final animationValue = useAnimation<double>(
      Tween<double>(begin: 0.4, end: 1.0).animate(animation),
    );

    useEffect(() {
      Future.delayed(Duration(milliseconds: delay), () {
        animation.repeat(reverse: true);
      });
      return animation.dispose;
    }, [delay]);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
          opacity: animationValue,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
