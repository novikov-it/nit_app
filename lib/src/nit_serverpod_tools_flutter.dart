import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_app/src/session/nit_socket_state/nit_socket_state.dart';
import 'package:nit_tools_client/nit_tools_client.dart' as nit_tools;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as auth;

enum UserIdMode {
  userProfileId,
  userInfoId;
}

extension NitServerpodToolsExtension on WidgetRef {
  Future<bool> initNitServerpodApp({
    required ServerpodClientShared client,
    required Function() initRepositoryFunction,
    UserIdMode userIdMode = UserIdMode.userInfoId,
    List<NitRepositoryDescriptor>? customRepositoryDescriptors,
    NitAuthConfig? nitAuthConfig,
  }) async {
    final nitTools = client.moduleLookup.values
        .firstWhereOrNull((e) => e is nit_tools.Caller);

    if (nitTools != null) {
      nitToolsCaller = nitTools as nit_tools.Caller;
    }

    final authCaller =
        client.moduleLookup.values.firstWhereOrNull((e) => e is auth.Caller);

    if (authCaller == null) {
      throw Exception(
          'Auth module not enabled, can not init session. Add serverpod_auth module to the client');
    }

    // if (authCaller != null) {
    //   authModuleCaller = authCaller as auth.Caller;
    // }

    // authModuleCaller = client!.moduleLookup.values
    //     .firstWhereOrNull((e) => e is auth.Caller) as auth.Caller;

    // final chatsCaller = client!.moduleLookup.values
    //     .firstWhereOrNull((e) => e is chats.Caller);

    // if (chatsCaller != null) {
    //   chatsModuleCaller = chatsCaller as chats.Caller;
    // }
    // chatsModuleCaller = client!.moduleLookup.values
    //     .firstWhereOrNull((e) => e is chats.Caller) as chats.Caller;

    NitToolsClient.protocol = client.serializationManager;

    await initRepositoryFunction();

    for (var repo
        in customRepositoryDescriptors ?? <NitRepositoryDescriptor>[]) {
      repo.init();
    }

    await read(nitSessionStateProvider.notifier).init(
      authModuleCaller: authCaller as auth.Caller,
      signedInUserIdPreloadProcessing: (serverpodUserInfoId) async {
        if (serverpodUserInfoId != null) {
          final profileId = await nitToolsCaller!.nitCrud
              .getOneCustom(
                className: 'UserProfile',
                filter: NitBackendFilter<int>.value(
                  type: NitBackendFilterType.equals,
                  fieldName: 'userId',
                  fieldValue: serverpodUserInfoId,
                ),
              )
              .then(
                (response) => processApiResponse<int>(response),
              );

          return userIdMode == UserIdMode.userProfileId
              ? profileId
              : serverpodUserInfoId;
        }
        return null;
      },
    );

    if (nitAuthConfig != null) NitAuthConfig.config = nitAuthConfig;

    return read(nitSocketStateProvider.notifier).init(client: client);
  }
}
