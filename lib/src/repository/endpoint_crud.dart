import 'package:serverpod_client/serverpod_client.dart';

import 'object_wrapper.dart';

class EndpointCrud extends EndpointRef {
  EndpointCrud(super.caller);

  @override
  String get name => 'crud';

  Future<ObjectWrapper?> getOne({
    required String className,
    required int id,
  }) =>
      caller.callServerEndpoint<ObjectWrapper?>(
        'crud',
        'getOne',
        {
          'className': className,
          'id': id,
        },
      );

  Future<List<ObjectWrapper>> getAll({required String className}) =>
      caller.callServerEndpoint<List<ObjectWrapper>>(
        'crud',
        'getAll',
        {'className': className},
      );

  Future<ObjectWrapper?> saveModel({required ObjectWrapper wrappedModel}) =>
      caller.callServerEndpoint<ObjectWrapper?>(
        'crud',
        'saveModel',
        {'wrappedModel': wrappedModel},
      );

  Future<bool> delete({required ObjectWrapper wrappedModel}) =>
      caller.callServerEndpoint<bool>(
        'crud',
        'delete',
        {'wrappedModel': wrappedModel},
      );

  Future<String?> getUploadDescription({required String path}) =>
      caller.callServerEndpoint<String?>(
        'crud',
        'getUploadDescription',
        {'path': path},
      );

  Future<String?> verifyUpload({required String path}) =>
      caller.callServerEndpoint<String?>(
        'crud',
        'verifyUpload',
        {'path': path},
      );
}
