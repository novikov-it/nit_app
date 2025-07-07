import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_app/src/chats/UI/widget/message_bubbles/widgets/voice_message/state/voice_message_bubble_state.dart';

class VoiceMessageBubble extends HookConsumerWidget {
  const VoiceMessageBubble({
    super.key,
    required this.nitMedia,
  });

  final NitMedia nitMedia;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioState =
        ref.watch(voiceMessageBubbleStateProvider(nitMedia.publicUrl));
    final audioNotifier =
        ref.read(voiceMessageBubbleStateProvider(nitMedia.publicUrl).notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(
              audioState.type == AudioStateType.loading
                  ? Icons.hourglass_empty
                  : audioState.playerController.playerState ==
                          PlayerState.playing
                      ? Icons.pause
                      : Icons.play_arrow,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: audioState.type == AudioStateType.loading
                ? null
                : () async {
                    await audioNotifier.togglePlay();
                  },
          ),
          Expanded(
            child: audioState.type == AudioStateType.loaded
                ? AudioFileWaveforms(
                    size: Size(1000, 15),
                    playerController: audioState.playerController,
                    enableSeekGesture: true,
                    waveformType: WaveformType.fitWidth,
                    // waveformData: [],
                    playerWaveStyle: PlayerWaveStyle(
                      scaleFactor: 350,
                      fixedWaveColor: Colors.grey.shade300,
                      liveWaveColor: Theme.of(context).primaryColor,
                      waveThickness: 2.0,
                    ),
                  )
                : SizedBox(
                    height: 30,
                    // decoration: BoxDecoration(
                    //   color: Colors.grey.shade200,
                    //   borderRadius: BorderRadius.circular(8),
                    // ),
                    child: Center(
                        child: audioState.type == AudioStateType.error
                            ? Text(
                                'Error loading audio',
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 14),
                              )
                            : AudioFileWaveforms(
                                size: Size(100, 30),
                                playerController: audioState.playerController,
                                enableSeekGesture: true,
                                waveformType: WaveformType.fitWidth,
                                waveformData: [
                                  0.1,
                                  0.2,
                                  0.3,
                                  0.4,
                                  0.5,
                                  0.2,
                                  0.5,
                                  0.2,
                                  0.1,
                                  0.2,
                                  0.3
                                ],
                                playerWaveStyle: PlayerWaveStyle(
                                  fixedWaveColor: Colors.grey.shade300,
                                  liveWaveColor: Theme.of(context).primaryColor,
                                  waveThickness: 2.0,
                                ),
                              )),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              _formatDuration(nitMedia.duration ?? 0),
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Форматирование длительности в формат MM:SS
  String _formatDuration(int milliseconds) {
    final seconds = milliseconds ~/ 1000;
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }
}
