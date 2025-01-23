import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nit_app/src/session/nit_session_state.dart';
import 'package:nit_router/nit_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_phone_flutter/serverpod_auth_phone_flutter.dart';

import '../../config/nit_auth_config.dart';

part 'phone_auth_state.g.dart';
part 'phone_auth_state.freezed.dart';

@riverpod
class PhoneAuthState extends _$PhoneAuthState {
  // Map<String, String>? _extraParams;

  @override
  PhoneAuthStateModel build() {
    return PhoneAuthStateModel(
      otpRequested: false,
      // everythingAccepted: false,
      phoneController: TextEditingController(),
      otpController: TextEditingController(),
    );
  }

  String get _phone => toNumericString(
        state.phoneController.text,
        allowHyphen: false,
      );

  // toggleAcceptance() {
  //   state = state.copyWith(everythingAccepted: !state.everythingAccepted);
  // }

  requestOtp({
    Map<String, String>? extraParams,
  }) async {
    debugPrint("requesting OTP");
    // if (!state.everythingAccepted) {
    //   ref.notifyUser(
    //     NitNotification.error(
    //       'Примите соглашение, чтобы продолжить',
    //     ),
    //   );

    //   return;
    // }

    await PhoneAuthController(
            ref.read(nitSessionStateProvider).serverpodSessionManager!)
        .sendOTP(
      _phone,
      extraParams: extraParams,
    )
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
        .verifyOTP(
      _phone,
      state.otpController.text,
    );

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
    // required bool everythingAccepted,
    required TextEditingController phoneController,
    required TextEditingController otpController,
    int? otpRequestTimer,
  }) = _PhoneAuthStateModel;
}
