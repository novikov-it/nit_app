import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_ui_kit/nit_ui_kit.dart';

import 'nit_auth/phone_auth/phone_auth_widget.dart';

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

  static String Function(XFile file) defaultUploadNameTemplate = (XFile file) =>
      '${DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())}-${file.name}';

  Future<String> uploadXFileToServer({
    required XFile xFile,
  }) async =>
      uploadBytesToServer(
        bytes: await xFile.readAsBytes(),
        path: defaultUploadNameTemplate(
          xFile,
        ),
      );

  Future<String> uploadBytesToServer({
    required Uint8List bytes,
    required String path,
  }) async {
    final byteData = ByteData.view(bytes.buffer);

    var uploadDescription =
        await nitToolsCaller!.nitUpload.getUploadDescription(
      path: path,
    );

    if (uploadDescription == null) {
      throw Exception("Не удалось инициализировать загрузку файла");
    }
    debugPrint(uploadDescription);
    var uploader = FileUploader(uploadDescription);
    await uploader.uploadByteData(byteData);
    var publicUrl = await nitToolsCaller!.nitUpload.verifyUpload(
      path: path,
    );

    if (publicUrl == null) {
      throw Exception("Не удалось загрузить файл");
    }

    debugPrint(publicUrl);

    return publicUrl;
  }

  Future<String?> pickAndUploadImage({
    ImageSource imageSource = ImageSource.gallery,
  }) async {
    final file = await ImagePicker().pickImage(source: imageSource);

    if (file == null) {
      debugPrint('no image');
      return null;
    }

    return await uploadXFileToServer(
      xFile: file,
    );
  }
}
