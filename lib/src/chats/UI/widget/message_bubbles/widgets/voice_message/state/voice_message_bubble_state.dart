// audio_provider.dart
import 'dart:developer';
import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

part 'voice_message_bubble_state.freezed.dart';
part 'voice_message_bubble_state.g.dart';

@Riverpod(keepAlive: true)
class VoiceMessageBubbleState extends _$VoiceMessageBubbleState {
  @override
  VoiceMessageBubbleStateModel build(String url) {
    final playerController = PlayerController();
    ref.onDispose(() {
      playerController.dispose();
    });

    playerController.onCompletion.listen((_) async {
      await playerController.seekTo(0);
      await playerController.pausePlayer();
    });

    return VoiceMessageBubbleStateModel(
      playerController: playerController,
      type: AudioStateType.initial,
    );
  }

  Future<void> initializeAudio() async {
    if (state.type == AudioStateType.loading ||
        state.type == AudioStateType.loaded) return;

    state = VoiceMessageBubbleStateModel(
        type: AudioStateType.loading, playerController: state.playerController);

    try {
      final localPath = await _downloadFile(url);
      if (localPath == null) {
        throw Exception('Failed to download audio file');
      }

      // Подготавливаем плеер с локальным путем
      await state.playerController.preparePlayer(
        path: localPath,
        shouldExtractWaveform: true,
        noOfSamples: 20,
      );
      state.playerController.setFinishMode(finishMode: FinishMode.pause);
      state = VoiceMessageBubbleStateModel(
          type: AudioStateType.loaded,
          playerController: state.playerController);
    } catch (e) {
      state = VoiceMessageBubbleStateModel(
        type: AudioStateType.error,
        playerController: state.playerController,
      );
    }
  }

  Future<void> togglePlay() async {
    if (state.type == AudioStateType.error ||
        state.type == AudioStateType.initial) {
      await initializeAudio();
    }
    if (state.type == AudioStateType.loaded) {
      final controller = state.playerController;
      if (controller.playerState == PlayerState.playing) {
        await controller.pausePlayer();
      } else {
        await controller.startPlayer();
      }
      state = VoiceMessageBubbleStateModel(
          type: AudioStateType.loaded, playerController: controller);
    }
  }

  Future<String?> _downloadFile(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception(
            'Failed to download file: Status ${response.statusCode}');
      }

      // Получаем временную директорию
      final tempDir = await getTemporaryDirectory();
      // Создаем уникальное имя файла на основе URL или текущего времени
      final fileName = url.split('/').last;
      final filePath = '${tempDir.path}/$fileName';
      // Записываем данные в файл
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    } catch (e) {
      log('Error downloading file: $e');
      return null;
    }
  }
}

enum AudioStateType {
  initial,
  loading,
  loaded,
  error,
}

@freezed
class VoiceMessageBubbleStateModel with _$VoiceMessageBubbleStateModel {
  const factory VoiceMessageBubbleStateModel({
    required AudioStateType type,
    required PlayerController playerController,
  }) = _VoiceMessageBubbleStateModel;
}
