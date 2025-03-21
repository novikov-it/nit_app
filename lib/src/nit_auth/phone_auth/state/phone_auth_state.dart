import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nit_app/src/session/nit_session_state.dart';
import 'package:nit_riverpod_notifications/nit_riverpod_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_phone_flutter/serverpod_auth_phone_flutter.dart';

part 'phone_auth_state.freezed.dart';
part 'phone_auth_state.g.dart';

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

  String get _otp => toNumericString(
        state.otpController.text,
        allowHyphen: false,
      );

  Future<bool> requestOtp({
    Map<String, String>? extraParams,
  }) async {
    debugPrint("requesting OTP");

    // TODO: убрать инициализацию контроллера в создание стейта
    final response = await PhoneAuthController(
            ref.read(nitSessionStateProvider).serverpodSessionManager!)
        .sendOTP(
      _phone,
      extraParams: extraParams,
    );

    if (response.success) {
      debugPrint("OTP requested");
      state = state.copyWith(
        otpRequested: true,
        otpRequestTimer: 60,
      );
    }
    return response.success;
  }

  Future<bool> verifyOtp() async {
    String? userName = state.userNameController.text;

    if (userName.isEmpty) {
      userName = null;
    }

    // TODO: убрать инициализацию контроллера в создание стейта
    final res = await PhoneAuthController(
            ref.read(nitSessionStateProvider).serverpodSessionManager!)
        .verifyOTP(
      _phone,
      _otp,
    );

    debugPrint(res.toString());

    return res != null;
  }

  Future<bool> resendOTP({
    Map<String, String>? extraParams,
  }) async {
    debugPrint("requesting OTP");

    final response = await PhoneAuthController(
            ref.read(nitSessionStateProvider).serverpodSessionManager!)
        .resendOTP(
      _phone,
      extraParams: extraParams,
    );

    // TODO: провести рефакторинг модуля в серверподе и это тоже поправить
    if (!response.success) {
      ref.notifyUser(
        NitNotification.error(
          response.failText ?? 'Не удалось отправить код подтверждения',
        ),
      );
    } else {
      debugPrint("OTP requested");
      state = state.copyWith(
        otpRequested: true,
        otpRequestTimer: 60,
      );
    }
    return response.success;
  }

  // Future<bool> isUserByIdentifierExists() async {
  //   return await authModuleCaller!.user.isUserByIdentifierExists(_phone);
  // }
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
