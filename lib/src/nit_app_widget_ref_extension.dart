import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nit_app/nit_app.dart';
import 'auth/phone_auth/phone_auth_widget.dart';

extension NitAppWidgetRefExtension on WidgetRef {
  requireLogin({
    Function()? thenAction,
  }) async {
    final userLoggedIn = read(nitSessionStateProvider).signedInUser != null ||
        true ==
            await context.showBottomSheetOrDialog<bool>(
              NitDialogLayout(
                title: 'Войдите в приложение',
                child: PhoneAuthWidget(
                  onSuccess: context.pop,
                ),
              ),
            );

    if (userLoggedIn && thenAction != null) thenAction();
  }

  Future<String?> uploadFileToServer({
    required Uint8List bytes,
    required String path,
  }) async {
    final byteData = ByteData.view(bytes.buffer);

    var uploadDescription = await nitToolsCaller.upload.getUploadDescription(
      path: path,
    );

    if (uploadDescription == null) {
      return null;
    }
    debugPrint(uploadDescription);
    var uploader = FileUploader(uploadDescription);
    await uploader.uploadByteData(byteData);
    var publicUrl = await nitToolsCaller.upload.verifyUpload(
      path: path,
    );

    debugPrint('$publicUrl');

    return publicUrl;
  }

  Future<String?> pickImage() async {
    return ImagePicker().pickImage(source: ImageSource.gallery).then(
      (image) async {
        if (image == null) {
          debugPrint('no image');
          return null;
        }

        uploadFileToServer(
          bytes: await image.readAsBytes(),
          path:
              '${DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())}-${image.name}',
        );
      },
    );
  }
}
