import 'package:flutter/material.dart';
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
      everythingAccepted: false,
      phoneController: TextEditingController(),
      otpController: TextEditingController(),
    );
  }

  toggleAcceptance() {
    state = state.copyWith(everythingAccepted: !state.everythingAccepted);
  }

  requestOtp() async {
    debugPrint("requesting OTP");
    await PhoneAuthController(
            ref.read(nitSessionStateProvider).serverpodSessionManager!)
        .sendOTP(state.phoneController.text)
        .then((response) {
      if (response.success) {
        debugPrint("OTP requested");
        state = state.copyWith(
          otpRequested: true,
          otpRequestTimer: 60,
        );
      } else {}
    });
  }

  Future<bool> verifyOtp() async {
    // return null !=
    final res = await PhoneAuthController(
            ref.read(nitSessionStateProvider).serverpodSessionManager!)
        .verifyOTP(state.phoneController.text, state.otpController.text);

    debugPrint(res.toString());

    return res != null;
    // .then((userInfo) {
    //   if(userInfo == null) {

    //   }
    // });
  }
}

@freezed
class PhoneAuthStateModel with _$PhoneAuthStateModel {
  const factory PhoneAuthStateModel({
    required bool otpRequested,
    required bool everythingAccepted,
    required TextEditingController phoneController,
    required TextEditingController otpController,
    int? otpRequestTimer,
  }) = _PhoneAuthStateModel;
}
