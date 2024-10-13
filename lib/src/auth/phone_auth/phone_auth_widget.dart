import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'state/phone_auth_state.dart';

class PhoneAuthWidget extends HookConsumerWidget {
  const PhoneAuthWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(phoneAuthStateProvider);

    return Column(
      children: [
        if (!state.otpRequested)
          TextField(
            decoration: const InputDecoration(
              labelText: 'Телефон',
            ),
            controller: state.phoneController,
          ),
        if (!state.otpRequested)
          ElevatedButton(
            onPressed: ref.read(phoneAuthStateProvider.notifier).requestOtp,
            child: const Text('Запросить код подтверждения'),
          ),
        if (state.otpRequested)
          TextField(
            decoration: const InputDecoration(
              labelText: 'Код из СМС',
            ),
            controller: state.otpController,
          ),
        if (state.otpRequested)
          ElevatedButton(
            onPressed: ref.read(phoneAuthStateProvider.notifier).verifyOtp,
            child: const Text('Запросить код подтверждения'),
          )
      ],
    );
  }
}
