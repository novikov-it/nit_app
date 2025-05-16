part of 'nit_chat_widgets.dart';

class ChatInputWidget extends HookConsumerWidget {
  const ChatInputWidget({
    super.key,
    required this.chatId,
  });

  final int chatId;

  void sendMessage(
    ValueNotifier<bool> notifier,
    Future<void> Function() future,
  ) async {
    notifier.value = true;
    try {
      await future();
    } finally {
      notifier.value = false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = nitChatViewStateProvider(chatId);
    // final chatState = ref.watch(provider);
    final controller = useTextEditingController();
    final isFieldLoading = useState(false);

    useEffect(() {
      Timer? typingTimer;
      bool wasTyping = false;
      void listener() {
        final isTyping = controller.text.isNotEmpty;
        if (isTyping && !wasTyping) {
          ref.read(provider.notifier).typingToggle(true);
          wasTyping = true;
        }
        typingTimer?.cancel();
        if (isTyping) {
          typingTimer = Timer(const Duration(seconds: 2), () {
            ref.read(provider.notifier).typingToggle(false);
            wasTyping = false;
          });
        } else {
          ref.read(provider.notifier).typingToggle(false);
          wasTyping = false;
        }
      }

      controller.addListener(listener);
      return () {
        controller.removeListener(listener);
        typingTimer?.cancel();
      };
    }, [controller]);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IgnorePointer(
            ignoring: isFieldLoading.value,
            child: AttachmentList(),
          ),
          Row(
            children: [
              AddAttachmentButton(),
              Expanded(
                child: TextField(
                  readOnly: isFieldLoading.value,
                  controller: controller,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 3,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Введите сообщение',
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      sendMessage(
                        isFieldLoading,
                        () async {
                          await ref.read(provider.notifier).onMessageTap(value);
                          controller.clear();
                        },
                      );
                    }
                  },
                  style: const TextStyle(fontSize: 16),
                  textInputAction: TextInputAction.send,
                ),
              ),
              if (isFieldLoading.value)
                const CircularProgressIndicator()
              else
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    final value = controller.text;
                    if (value.isNotEmpty) {
                      sendMessage(
                        isFieldLoading,
                        () async {
                          await ref.read(provider.notifier).onMessageTap(value);
                          controller.clear();
                        },
                      );
                    }
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
