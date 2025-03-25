import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_ui_kit/nit_ui_kit.dart';

import 'file_upload_handler.dart';

extension NitAppRefExtension on Ref {
  Future<String> uploadXFileToServer({
    required XFile xFile,
    required String path,
  }) async =>
      await FileUploaderHandler.uploadXFileToServer(xFile: xFile, path: path);

  Future<String> uploadBytesToServer({
    required Uint8List bytes,
    required String path,
  }) async =>
      await FileUploaderHandler.uploadBytesToServer(bytes: bytes, path: path);

  Future<String?> pickAndUploadImage({
    ImageSource imageSource = ImageSource.gallery,
  }) async =>
      await FileUploaderHandler.pickAndUploadImage(
        imageSource: imageSource,
      );
}
