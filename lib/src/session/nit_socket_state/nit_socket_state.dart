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

  @override
  NitSocketStateModel build() {
    ref.listen(
      nitSessionStateProvider,
      (previousState, nextState) {
        if (nextState.signedInUserId != previousState?.signedInUserId
            //  &&
            //     _connectionHandler?.status.status ==
            //         StreamingConnectionStatus.connected
            ) {
          _connectionHandler?.client.closeStreamingConnection();
        }
      },
    );

    // final sessionState = ref.watch(nitSessionStateProvider);

    return NitSocketStateModel(
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

  _refresh() async {
    if (nitToolsCaller != null &&
        state.websocketStatus != StreamingConnectionStatus.connected &&
        _connectionHandler?.status.status ==
            StreamingConnectionStatus.connected) {
      _listenToUpdates();
    }
    // if (_sessionManager.signedInUser?.id != state.signedInUserId) {
    //   // if (nitToolsCaller != null) {
    //   //   await _openUpdatesStream();
    //   // }
    //   // _updateFcm();

    //   if (_sessionManager.signedInUser != null) await _updateRepository();

    state = NitSocketStateModel(
      websocketStatus: _connectionHandler?.status.status ??
          StreamingConnectionStatus.disconnected,
    );
    // }
  }

  Future<void> _listenToUpdates() async {
    nitToolsCaller!.nitUpdates.resetStream();

    // final t = nitToolsCaller!.nitCrud.stream.listen(onData)

    await for (var update in nitToolsCaller!.nitUpdates.stream) {
      if (update is ObjectWrapper) {
        print("Received ${update.className} with id ${update.modelId}");
        if (update.model is NitAppNotification) {
          ref.notifyUser(update.model as NitAppNotification);
          for (var enclosedObject
              in (update.model as NitAppNotification).updatedEntities ?? []) {
            ref.updateFromStream(enclosedObject);
          }
        }

        ref.updateFromStream(update);
      }

      // May be useful for debug
      // ref.notifyUser(
      //   NitNotification.warning(
      //     update.toString(),
      //   ),
      // );
    }
  }
}
