

// _connectionHandler = StreamingConnectionHandler(
//       client: client,
//       listener: (connectionState) async {
//         debugPrint('listener called ${connectionState.status}');
//         _refresh(connectionState.status);
//       },
//     );

//     sessionManager.addListener(() {
//       _refresh(_connectionHandler.status.status);
//     });

//     _connectionHandler.connect();