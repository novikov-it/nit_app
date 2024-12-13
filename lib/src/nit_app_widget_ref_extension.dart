import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:serverpod_client/serverpod_client.dart';

import 'repository/entity_manager_state.dart';

extension NitAppWidgetRefExtension on WidgetRef {
  Future<String?> uploadImageToServer(XFile image) async {
    final imageBytes = await image.readAsBytes();

    final byteData = ByteData.view(imageBytes.buffer);

    final path =
        '${DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())}-${image.name}';

    var uploadDescription = await nitToolsCaller.upload.getUploadDescription(
      path: path,
      // '${folder != null ? '$folder/' : ''}
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

        uploadImageToServer(image);
      },
    );
  }
}
