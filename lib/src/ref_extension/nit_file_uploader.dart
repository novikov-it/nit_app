import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as http_parser;

/// The file uploader uploads files to Serverpod's cloud storage. On the server
/// you can setup a custom storage service, such as S3 or Google Cloud. To
/// directly upload a file, you first need to retrieve an upload description
/// from your server. After the file is uploaded, make sure to notify the server
/// by calling the verifyDirectFileUpload on the current Session object.
class NitFileUploader {
  late final _UploadDescription _uploadDescription;
  bool _attemptedUpload = false;

  /// Creates a new FileUploader from an [uploadDescription] created by the
  /// server.
  NitFileUploader(String uploadDescription) {
    _uploadDescription = _UploadDescription(uploadDescription);
  }

  /// Uploads a file contained by a [ByteData] object, returns true if
  /// successful.
  Future<bool> uploadByteData(ByteData byteData) async {
    var stream = http.ByteStream.fromBytes(byteData.buffer.asUint8List());
    return upload(stream, byteData.lengthInBytes);
  }

  /// Uploads a file from a [Stream], returns true if successful.
  Future<bool> upload(Stream<List<int>> stream, int length) async {
    if (_attemptedUpload) {
      throw Exception(
          'Data has already been uploaded using this FileUploader.');
    }
    _attemptedUpload = true;

    if (_uploadDescription.type == _UploadType.binary) {
      //TODO: implement
    } else if (_uploadDescription.type == _UploadType.multipart) {
      try {
        final fileName = _uploadDescription.fileName!;
        final mimeType = _uploadDescription.requestFields['Content-Type'] ??
            'application/octet-stream';
        final contentType = http_parser.MediaType.parse(mimeType);

        final request = http.MultipartRequest('POST', _uploadDescription.url);

        _uploadDescription.requestFields.forEach((key, value) {
          request.fields[key] = value;
        });

        final multipartFile = http.MultipartFile(
          _uploadDescription.field!,
          stream,
          length,
          filename: fileName,
          contentType: contentType,
        );

        request.files.add(multipartFile);

        final result = await request.send();

        if (result.statusCode != 204 && result.statusCode != 200) {
          final responseBody = await result.stream.bytesToString();
          log('Response body: $responseBody');
        }

        final success = result.statusCode == 204 || result.statusCode == 200;

        return success;
      } catch (e, stackTrace) {
        log('Upload failed with exception: $e');
        log('Stack trace: $stackTrace');
        return false;
      }
    }

    throw UnimplementedError('Unknown upload type');
  }

  // Future<String?> _readBody(http.ByteStream stream) async {
  //   // TODO: Find more efficient solution?
  //   var len = 0;
  //   var data = <int>[];
  //   await for (var segment in stream) {
  //     len += segment.length;
  //     data += segment;
  //   }
  //   return Utf8Decoder().convert(data);
  // }

  Future<List<int>> _readStreamData(Stream<List<int>> stream) async {
    // TODO: Find more efficient solution?
    var data = <int>[];
    await for (var segment in stream) {
      data += segment;
    }
    return data;
  }
}

enum _UploadType {
  binary,
  multipart,
}

class _UploadDescription {
  late _UploadType type;
  late Uri url;
  String? field;
  String? fileName;
  Map<String, String> requestFields = {};

  _UploadDescription(String description) {
    var data = jsonDecode(description);
    if (data['type'] == 'binary') {
      type = _UploadType.binary;
    } else if (data['type'] == 'multipart') {
      type = _UploadType.multipart;
    } else {
      throw const FormatException('Missing type, can be binary or multipart');
    }

    url = Uri.parse(data['url']);

    field = data['field'];
    fileName = data['file-name'];
    requestFields = (data['request-fields'] as Map).cast<String, String>();

    // if (type == _UploadType.multipart) {}
  }
}
