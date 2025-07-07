import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';

class EditInputPanel extends ConsumerWidget {
  const EditInputPanel({super.key, required this.chatId});

  final int chatId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editedMessage = ref.watch(
        chatStateProvider(chatId).select((state) => state.editedMessage));
    final theme = ChatTheme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: editedMessage != null ? 70.0 : 0.0,
      decoration: BoxDecoration(
        color: theme.mainTheme.backgroundColor,
        border: editedMessage != null
            ? Border(
                top: BorderSide(
                  color: theme.mainTheme.dividerColor,
                  width: 1.0,
                ),
              )
            : Border.all(width: 0, color: Colors.transparent),
      ),
      child: editedMessage != null
          ? Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.reply,
                    color: Colors.black,
                    size: 20.0,
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Редактирование сообщения',
                          style: theme.inputTheme.textStyle,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          editedMessage.text ?? 'Медиафайл',
                          style: theme.inputTheme.textStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 20.0,
                    ),
                    onPressed: () {
                      ref
                          .read(chatStateProvider(chatId).notifier)
                          .setRepliedMessage(null);
                    },
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
