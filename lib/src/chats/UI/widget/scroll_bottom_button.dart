part of 'nit_chat_widgets.dart';

class ScrollToBottomButton extends ConsumerWidget {
  final int chatId;

  const ScrollToBottomButton({super.key, required this.chatId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(chatUIStateProvider(chatId));
    final uiNotifier = ref.read(chatUIStateProvider(chatId).notifier);

    return AnimatedScale(
      scale: uiState.showScrollToBottom ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: () {
              uiNotifier.scrollToBottomForced();
            },
            child: Container(
              width: 56,
              height: 56,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 28,
                  ),

                  // Счетчик непрочитанных сообщений
                  if (uiState.unreadCount > 0)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Text(
                          uiState.unreadCount > 99
                              ? '99+'
                              : uiState.unreadCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
