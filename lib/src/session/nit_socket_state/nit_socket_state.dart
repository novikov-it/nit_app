import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_riverpod_notifications/nit_riverpod_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nit_socket_state.freezed.dart';
part 'nit_socket_state.g.dart';

@freezed
abstract class NitSocketStateModel with _$NitSocketStateModel {
  const factory NitSocketStateModel({
    required StreamingConnectionStatus websocketStatus,
  }) = _NitSocketStateModel;
}

@Riverpod(keepAlive: true)
class NitSocketState extends _$NitSocketState {
  StreamingConnectionHandler? _connectionHandler;
  final Map<String, StreamSubscription<SerializableModel>> _channelSubs = {};
  StreamSubscription<SerializableModel>? _mainStreamSub;

  @override
  NitSocketStateModel build() {
    ref.onDispose(() {
      _mainStreamSub?.cancel();
      unsubscribeAllChannels();
    });

    ref.listen(
      nitSessionStateProvider,
      (previousState, nextState) {
        if (nextState.signedInUserId != previousState?.signedInUserId) {
          _connectionHandler?.client.closeStreamingConnection();
          unsubscribeAllChannels();
        }
      },
    );

    return const NitSocketStateModel(
      websocketStatus: StreamingConnectionStatus.disconnected,
    );
  }

  Future<bool> init({
    required ServerpodClientShared client,
  }) async {
    _connectionHandler = StreamingConnectionHandler(
      client: client,
      retryEverySeconds: 1,
      listener: (connectionState) async {
        debugPrint('listener called ${connectionState.status}');
        _refresh();
      },
    );

    _connectionHandler!.connect();
    return true;
  }

  Future<void> _refresh() async {
    if (nitToolsCaller != null &&
        state.websocketStatus != StreamingConnectionStatus.connected &&
        _connectionHandler?.status.status ==
            StreamingConnectionStatus.connected) {
      await _startMainStream();
    }

    state = NitSocketStateModel(
      websocketStatus: _connectionHandler?.status.status ??
          StreamingConnectionStatus.disconnected,
    );
  }

  Future<void> _startMainStream() async {
    _mainStreamSub?.cancel();
    nitToolsCaller!.nitUpdates.resetStream();

    _mainStreamSub = nitToolsCaller!.nitUpdates.stream.listen((update) {
      _processUpdate(update);
    });
  }

  void _processUpdate(SerializableModel update) {
    if (update is ObjectWrapper) {
      debugPrint("Received ${update.className} with id ${update.modelId}");
      if (update.model is NitAppNotification) {
        ref.notifyUser(update.model as NitAppNotification);
      }

      ref.updateFromStream([update]);
    } else if (update is NitUpdatesTransport) {
      for (var e in update.updatedEntities) {
        if (e.model is NitAppNotification) {
          ref.notifyUser(e.model as NitAppNotification);
        }
        ref.updateFromStream(update.updatedEntities);
      }
    }
  }

  Future<void> subscribeToChannel(String channel) async {
    if (_connectionHandler?.status.status !=
        StreamingConnectionStatus.connected) {
      debugPrint("⚠️ Cannot subscribe, not connected yet");
      return;
    }

    if (_channelSubs.containsKey(channel)) {
      debugPrint("Already subscribed to $channel");
      return;
    }

    final sub =
        nitToolsCaller!.nitCrud.subscribeOnUpdates(channel: channel).listen(
      (update) => _processUpdate(update),
      onDone: () {
        // поток завершился (разрыв/переподключение) — освободим слот
        _channelSubs.remove(channel);
      },
      onError: (e, st) {
        debugPrint("Channel $channel error: $e");
        _channelSubs.remove(channel);
      },
      cancelOnError: true,
    );
    _channelSubs[channel] = sub;

    debugPrint("✅ Subscribed to $channel");
  }

  Future<void> unsubscribeFromChannel(String channel) async {
    if (_channelSubs.containsKey(channel)) {
      await _channelSubs[channel]!.cancel();
      _channelSubs.remove(channel);
      debugPrint("❌ Unsubscribed from $channel");
    }
  }

  Future<void> unsubscribeAllChannels() async {
    for (var sub in _channelSubs.values) {
      await sub.cancel();
    }
    _channelSubs.clear();
    debugPrint("❌ Unsubscribed from all channels");
  }
}
