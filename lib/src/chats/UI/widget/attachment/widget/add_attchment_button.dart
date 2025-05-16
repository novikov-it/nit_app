import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nit_app/src/chats/UI/widget/attachment/state/attachment_state.dart';

class AddAttachmentButton extends ConsumerWidget {
  const AddAttachmentButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.attach_file),
      onPressed: () {
        ref.read(attachmentStateProvider.notifier).openMediaPicker(context);
      },
    );
  }
}
