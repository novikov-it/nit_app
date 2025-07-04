import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_ui_kit/nit_ui_kit.dart';

import '../nit_auth/phone_auth/phone_auth_widget.dart';
import 'file_upload_handler.dart';

extension NitAppWidgetRefExtension on WidgetRef {
  requireLogin({
    Function()? thenAction,
  }) async {
    final userLoggedIn = read(nitSessionStateProvider).signedInUserId != null ||
        true ==
            await context.showBottomSheetOrDialog<bool>(
              NitDialogLayout(
                title: 'Войдите в приложение',
                child: PhoneAuthWidget(
                  onSuccess: context.pop,
                  extraParams:
                      NitAuthConfig.config.authExtraParamsProvider == null
                          ? null
                          : read(
                              NitAuthConfig.config.authExtraParamsProvider!,
                            ),
                ),
              ),
            );

    if (userLoggedIn && thenAction != null) thenAction();
  }

  Future<NitMedia> uploadXFileToServer({
    required XFile xFile,
  }) async =>
      await FileUploaderHandler.uploadXFileToServer(xFile: xFile);

  Future<NitMedia> uploadBytesToServer({
    required Uint8List bytes,
    required String path,
  }) async =>
      await FileUploaderHandler.uploadBytesToServer(bytes: bytes, path: path);

  Future<NitMedia?> pickAndUploadImage({
    ImageSource imageSource = ImageSource.gallery,
  }) async =>
      await FileUploaderHandler.pickAndUploadImage(
        imageSource: imageSource,
      );
}
