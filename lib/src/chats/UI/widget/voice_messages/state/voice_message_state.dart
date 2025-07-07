import 'package:nit_app/nit_app.dart';
import 'package:nit_ui_kit/nit_ui_kit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'voice_message_state.g.dart';

@riverpod
class VoiceMessageState extends _$VoiceMessageState {
  @override
  NitMedia? build(int chatId) {
    return null;
  }

  Future<void> uploadVoiceMessage(XFile file, int duration) async {
    final nitMedia =
        await ref.uploadXFileToServer(xFile: file, duration: duration);
    await ref
        .read(chatStateProvider(chatId).notifier)
        .sendMessage('Голосовое сообщение', nitMedia);
  }
}
