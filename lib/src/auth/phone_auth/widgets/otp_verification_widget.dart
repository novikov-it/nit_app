import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

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
