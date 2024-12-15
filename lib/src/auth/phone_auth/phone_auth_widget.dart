import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nit_app/src/auth/phone_auth/widgets/otp_verification_widget.dart';
import 'package:nit_app/src/auth/phone_auth/widgets/phone_input_widget.dart';
import 'state/phone_auth_state.dart';

class PhoneAuthWidget extends HookConsumerWidget {
  const PhoneAuthWidget({
    super.key,
    this.onSuccess,
  });

  final Function()? onSuccess;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(phoneAuthStateProvider);

    return state.otpRequested
        ? OtpVerificationWidget(
            onSuccess: onSuccess,
          )
        : PhoneInputWidget();
  }
}
