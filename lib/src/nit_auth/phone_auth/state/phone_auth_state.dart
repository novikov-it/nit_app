import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nit_app/src/session/nit_session_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_phone_flutter/serverpod_auth_phone_flutter.dart';

part 'phone_auth_state.g.dart';
part 'phone_auth_state.freezed.dart';

@riverpod
class PhoneAuthState extends _$PhoneAuthState {
  @override
  PhoneAuthStateModel build() {
    return PhoneAuthStateModel(
      otpRequested: false,
      phoneController: TextEditingController(),
      otpController: TextEditingController(),
      userNameController: TextEditingController(),
    );
  }

  String get _phone => toNumericString(
        state.phoneController.text,
        allowHyphen: false,
      );

  Future<bool> requestOtp({
    Map<String, String>? extraParams,
  }) async {
    debugPrint("requesting OTP");

    return await PhoneAuthController(
            ref.read(nitSessionStateProvider).serverpodSessionManager!)
        .sendOTP(
      _phone,
      extraParams: extraParams,
    )
        .then(
      (response) {
        if (response.success) {
          debugPrint("OTP requested");
          state = state.copyWith(
            otpRequested: true,
            otpRequestTimer: 60,
          );
        }
        return response.success;
      },
      onError: (_) => false,
    );
  }

  Future<bool> verifyOtp() async {
    String? userName = state.userNameController.text;

    if (userName.isEmpty) {
      userName = null;
    }

    final res = await PhoneAuthController(
            ref.read(nitSessionStateProvider).serverpodSessionManager!)
        .verifyOTP(
      _phone,
      state.otpController.text,
      userName,
    );

    debugPrint(res.toString());

    return res != null;
  }

  Future<bool> resendOTP({
    Map<String, String>? extraParams,
  }) async {
    debugPrint("requesting OTP");

    return await PhoneAuthController(
            ref.read(nitSessionStateProvider).serverpodSessionManager!)
        .resendOTP(
      _phone,
      extraParams: extraParams,
    )
        .then(
      (response) {
        if (response.success) {
          debugPrint("OTP requested");
          state = state.copyWith(
            otpRequested: true,
            otpRequestTimer: 60,
          );
        }
        return response.success;
      },
      onError: (_) => false,
    );
  }

  Future<bool> isUserByIdentifierExists() async {
    return await authModuleCaller!.user.isUserByIdentifierExists(_phone);
  }
}

@freezed
class PhoneAuthStateModel with _$PhoneAuthStateModel {
  const factory PhoneAuthStateModel({
    required bool otpRequested,
    required TextEditingController phoneController,
    required TextEditingController otpController,
    required TextEditingController userNameController,
    int? otpRequestTimer,
  }) = _PhoneAuthStateModel;
}
