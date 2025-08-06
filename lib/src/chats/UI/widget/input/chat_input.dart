part of '../nit_chat_widgets.dart';

class ChatInputWidget extends HookConsumerWidget {
  final int chatId;

  const ChatInputWidget({
    super.key,
    required this.chatId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatTheme = ChatTheme.of(context);
    final inputTheme = chatTheme.inputTheme;
    final controller = useTextEditingController();
    final focusNode = useFocusNode();
    final chatNotifier = ref.read(chatStateProvider(chatId).notifier);
    final isSending = useState(false);
    final isTyping = useState(false);
    final typingTimer = useRef<Timer?>(null);
    final isAudioMode = useState(false);

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
      if (isSending.value) return;

      try {
        isSending.value = true;
        if (isTyping.value) {
          isTyping.value = false;
          chatNotifier.typingToggle(false);
        }
        typingTimer.value?.cancel();
        controller.clear();
        if (chatNotifier.isEditMode) {
          await chatNotifier.editMessage(text);
        } else {
          await chatNotifier.sendMessage(text);
        }
      } finally {
        isSending.value = false;
      }
    }

    final isAttachmentEmpty = ref.watch(attachmentStateProvider).items.isEmpty;

    return Stack(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isAudioMode.value
              ? AudioRecorderWidget(
                  chatId: chatId,
                  isAudioMode: isAudioMode,
                )
              : Container(
                  padding: inputTheme.padding,
                  decoration: BoxDecoration(
                    color: inputTheme.backgroundColor,
                    border: Border(
                      top: BorderSide(
                        color: chatTheme.mainTheme.dividerColor,
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
                  child: Column(
                    children: [
                      AttachmentList(),
                      Gap(8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: inputTheme.backgroundColor,
                                  borderRadius: BorderRadius.circular(
                                      inputTheme.borderRadius),
                                  border: Border.all(
                                    color: chatTheme.mainTheme.dividerColor,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AddAttachmentButton(),
                                    Expanded(
                                      child: TextField(
                                        controller: controller,
                                        focusNode: focusNode,
                                        maxLines: 5,
                                        minLines: 1,
                                        style: inputTheme.textStyle,
                                        decoration: InputDecoration(
                                          hintText: 'Введите сообщение...',
                                          border: inputTheme.border ??
                                              InputBorder.none,
                                          contentPadding: inputTheme.padding,
                                          hintStyle:
                                              inputTheme.hintStyle?.copyWith(
                                                    color: isTyping.value
                                                        ? chatTheme.mainTheme
                                                            .primaryColor
                                                        : inputTheme.hintColor,
                                                  ) ??
                                                  TextStyle(
                                                    color: isTyping.value
                                                        ? chatTheme.mainTheme
                                                            .primaryColor
                                                        : inputTheme.hintColor,
                                                  ),
                                        ),
                                        cursorColor: inputTheme.cursorColor,
                                        onSubmitted: (_) => sendMessage(),
                                        textInputAction: TextInputAction.send,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            //TODO: вынести в отдельный виджет
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              child: FloatingActionButton.small(
                                onPressed: isSending.value
                                    ? null
                                    : chatTheme.settings.enableVoiceMessages &&
                                            controller.text.trim().isEmpty &&
                                            isAttachmentEmpty
                                        ? () => isAudioMode.value = true
                                        : sendMessage,
                                backgroundColor: isSending.value
                                    ? chatTheme.mainTheme.secondaryColor
                                    : chatTheme.mainTheme.primaryColor,
                                foregroundColor: Colors.white,
                                child: isSending.value
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        ),
                                      )
                                    : Icon(
                                        chatTheme.settings.enableVoiceMessages &&
                                                controller.text
                                                    .trim()
                                                    .isEmpty &&
                                                isAttachmentEmpty &&
                                                !chatNotifier.isEditMode
                                            ? Icons.mic
                                            : Icons.send,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
