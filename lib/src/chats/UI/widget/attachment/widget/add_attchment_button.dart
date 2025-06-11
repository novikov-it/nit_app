import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_app/src/chats/UI/widget/attachment/state/attachment_state.dart';

class AddAttachmentButton extends ConsumerWidget {
  const AddAttachmentButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatTheme = ChatTheme.of(context);

    return IconButton(
      icon: Icon(
        Icons.attach_file,
        color: chatTheme.primaryColor,
      ),
      onPressed: () {
        ref.read(attachmentStateProvider.notifier).openMediaPicker(context);
      },
      splashColor:
          chatTheme.secondaryColor.withOpacity(0.2), // Эффект нажатия из темы
      tooltip: 'Прикрепить файл',
    );
  }
}
