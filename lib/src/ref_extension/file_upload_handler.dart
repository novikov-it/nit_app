import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:heif_converter/heif_converter.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nit_app/nit_app.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FileUploaderHandler {
  static String Function(
      XFile file, String extension) defaultUploadNameTemplate = (
    XFile file,
    String extension,
  ) =>
      '${DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())}-${file.name}$extension';

  static Future<String?> pickAndUploadImageUrl({
    ImageSource imageSource = ImageSource.gallery,
  }) async =>
      pickAndUploadImage(imageSource: imageSource)
          .then((media) => media?.publicUrl);

  static Future<NitMedia?> pickAndUploadImage({
    ImageSource imageSource = ImageSource.gallery,
  }) async {
    final file = await ImagePicker().pickImage(source: imageSource);

    if (file == null) {
      log('no image');
      return null;
    }

    return await uploadXFileToServer(
      xFile: file,
    );
  }

  static Future<String?> uploadXFileToServerUrl({
    required XFile xFile,
    String? path,
  }) async =>
      uploadXFileToServer(xFile: xFile, path: path)
          .then((media) => media.publicUrl);

  static Future<NitMedia> uploadXFileToServer({
    required XFile xFile,
    String? path,
  }) async {
    final fileExtension = extension(xFile.path).toLowerCase();

    final originalBytes = await xFile.readAsBytes();

    final jpegBytes = await _convertToJpeg(originalBytes, fileExtension);

    final bytesToUpload = jpegBytes ?? originalBytes;

    final uploadPath = path == null
        ? defaultUploadNameTemplate(xFile, fileExtension)
        : '$path/${defaultUploadNameTemplate(xFile, fileExtension)}';

    return uploadBytesToServer(
      bytes: bytesToUpload,
      path: uploadPath,
    );
  }

  static Future<String?> uploadBytesToServerUrl({
    required Uint8List bytes,
    required String path,
  }) async =>
      uploadBytesToServer(
        bytes: bytes,
        path: path,
      ).then(
        (media) => media.publicUrl,
      );

  static Future<NitMedia> uploadBytesToServer({
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
    log(uploadDescription);

    var uploader = FileUploader(uploadDescription);
    await uploader.uploadByteData(byteData);

    var nitMedia = await nitToolsCaller!.nitUpload.verifyUpload(
      path: path,
    );

    if (nitMedia == null) {
      throw Exception("Не удалось загрузить файл");
    }

    log(nitMedia.publicUrl);

    return nitMedia;
  }

  static Future<Uint8List?> _convertToJpeg(
    Uint8List bytes,
    String fileExtension,
  ) async {
    switch (fileExtension.toLowerCase()) {
      case '.heic':
      case '.heif':
        try {
          final tempDir = await getTemporaryDirectory();
          final tempInputFile = File('${tempDir.path}/temp.heic');
          await tempInputFile.writeAsBytes(bytes);

          final tempOutputFile = File('${tempDir.path}/temp.jpg');

          final convertedPath = await HeifConverter.convert(
            tempInputFile.path,
            output: tempOutputFile.path,
            format: 'jpeg',
          );

          if (convertedPath != null) {
            return await File(convertedPath).readAsBytes();
          } else {
            log('Конвертация HEIC/HEIF не удалась');
            return null;
          }
        } catch (e) {
          log('Ошибка при конвертации HEIC/HEIF: $e');
          return null;
        }

      case '.jpg':
      case '.jpeg':
        return bytes;

      default:
        try {
          final image = img.decodeImage(Uint8List.fromList(bytes));
          if (image != null) {
            return Uint8List.fromList(img.encodeJpg(image));
          }

          log('Файл с расширением $fileExtension не поддерживается');
          break;
        } catch (e) {
          log('Ошибка при конвертации файла: $e');
          break;
        }
    }
    return null;
  }
}
