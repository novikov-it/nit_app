import 'package:flutter/foundation.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

/// Controller for phone authentication.
class PhoneAuthController {
  /// A reference to the session manager as retrieved from the client object.
  final SessionManager sessionManager;

  /// Private constructor for the singleton pattern.
  PhoneAuthController._internal(this.sessionManager);

  static PhoneAuthController? _instance;

  /// Factory constructor for creating or returning the singleton instance.
  factory PhoneAuthController(SessionManager sessionManager) {
    return _instance ??= PhoneAuthController._internal(sessionManager);
  }

  /// Attempts to sign in phone number and OTP. If successful, a [UserInfo]
  /// is returned. If the attempt is not a success, null is returned.
  Future<UserInfo?> verifyOTP(
    String phoneNubmer,
    String otp, {
    Map<String, String>? userExtraData,
  }) async {
    try {
      var serverResponse = await sessionManager.caller.phone.verifyOTP(
        phoneNubmer,
        otp,
        userExtraData: userExtraData,
      );
      if (!serverResponse.success ||
          serverResponse.userInfo == null ||
          serverResponse.keyId == null ||
          serverResponse.key == null) {
        if (kDebugMode) {
          debugPrint(
            'serverpod_auth_phone: Failed to authenticate with '
            'Serverpod backend: '
            '${serverResponse.failReason ?? 'reason unknown'}'
            '${serverResponse.failText}'
            '. Aborting.',
          );
        }
        return null;
      }

      // Authentication was successful, store the key.
      sessionManager.registerSignedInUser(
        serverResponse.userInfo!,
        serverResponse.keyId!,
        serverResponse.key!,
      );
      return serverResponse.userInfo;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('$e');
        print('$stackTrace');
      }
      return null;
    }
  }

  /// Attempts to send an OTP. null
  Future<AuthenticationResponse> sendOTP(
    String phoneNumber, {
    Map<String, String>? userExtraData,
    Map<String, String>? extraParams,
    bool resend = false,
  }) async {
    try {
      return await (resend
          ? sessionManager.caller.phone.resendOTP
          : sessionManager.caller.phone.sendOTP)(
        phoneNumber,
        userExtraData: userExtraData,
        extraParams: extraParams,
      );
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('$e');
        print('$stackTrace');
      }
      return AuthenticationResponse(
        success: false,
        failReason: AuthenticationFailReason.internalError,
        failText: e.toString(),
      );
    }
  }

  /// Attempts to resend an OTP.
  Future<AuthenticationResponse> resendOTP(
    String phoneNumber, {
    Map<String, String>? extraParams,
  }) async {
    return sendOTP(
      phoneNumber,
      extraParams: extraParams,
      resend: true,
    );
  }
}
