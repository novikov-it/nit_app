part of 'nit_chat_widgets.dart';

class ChatInputWidget extends HookConsumerWidget {
  final int chatId;

  const ChatInputWidget({
    super.key,
    required this.chatId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final focusNode = useFocusNode();
    final chatNotifier = ref.read(chatStateProvider(chatId).notifier);
    final isSending = useState(false);
    final isTyping = useState(false);
    final typingTimer = useRef<Timer?>(null);
    useEffect(() {
      void onTextChanged() {
        final hasText = controller.text.trim().isNotEmpty;

        if (hasText) {
          if (!isTyping.value) {
            isTyping.value = true;
            chatNotifier.typingToggle(true);
          }
          typingTimer.value?.cancel();
          typingTimer.value = Timer(const Duration(seconds: 2), () {
            if (isTyping.value) {
              isTyping.value = false;
              chatNotifier.typingToggle(false);
            }
          });
        } else {
          if (isTyping.value) {
            isTyping.value = false;
            chatNotifier.typingToggle(false);
          }
          typingTimer.value?.cancel();
        }
      }

      controller.addListener(onTextChanged);

      return () {
        controller.removeListener(onTextChanged);
        typingTimer.value?.cancel();
        if (isTyping.value) {
          chatNotifier.typingToggle(false);
        }
      };
    }, [controller]);

    useEffect(() {
      void onFocusChanged() {
        if (!focusNode.hasFocus && isTyping.value) {
          isTyping.value = false;
          chatNotifier.typingToggle(false);
          typingTimer.value?.cancel();
        }
      }

      focusNode.addListener(onFocusChanged);
      return () => focusNode.removeListener(onFocusChanged);
    }, [focusNode]);

    Future<void> sendMessage() async {
      final text = controller.text.trim();
      if (text.isEmpty || isSending.value) return;

      try {
        isSending.value = true;

        if (isTyping.value) {
          isTyping.value = false;
          chatNotifier.typingToggle(false);
        }
        typingTimer.value?.cancel();

        controller.clear();

        await chatNotifier.sendMessage(text);
      } finally {
        isSending.value = false;
      }
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 0.5,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          AddAttachmentButton(),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
              ),
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                maxLines: 5,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: 'Введите сообщение...',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  hintStyle: TextStyle(
                    color: isTyping.value
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).hintColor,
                  ),
                ),
                onSubmitted: (_) => sendMessage(),
                textInputAction: TextInputAction.send,
              ),
            ),
          ),
          const SizedBox(width: 8),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: FloatingActionButton.small(
              onPressed: isSending.value ? null : sendMessage,
              backgroundColor: controller.text.trim().isEmpty
                  ? Colors.grey
                  : Theme.of(context).primaryColor,
              child: isSending.value
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Icon(
                      isTyping.value ? Icons.edit : Icons.send,
                      color: Colors.white,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
