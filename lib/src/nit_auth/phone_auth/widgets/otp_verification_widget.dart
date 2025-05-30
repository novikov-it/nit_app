import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_ui_kit/nit_ui_kit.dart';

import '../../config/nit_auth_config.dart';
import '../state/phone_auth_state.dart';

class OtpVerificationWidget extends ConsumerWidget {
  const OtpVerificationWidget({
    super.key,
    this.onSuccess,
  });

  final Function()? onSuccess;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(phoneAuthStateProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          NitAuthConfig.config.otpInputInstructions,
        ),
        TextField(
          decoration: const InputDecoration(
            labelText: 'Код из СМС',
          ),
          controller: state.otpController,
        ),
        Gap(20),
        FilledButton(
          onPressed: () async {
            await ref
                .read(phoneAuthStateProvider.notifier)
                .verifyOtp()
                .then((res) => res && onSuccess != null ? onSuccess!() : {});
          },
          child: const Text('Проверить код'),
        ),
      ],
    );
  }
}
