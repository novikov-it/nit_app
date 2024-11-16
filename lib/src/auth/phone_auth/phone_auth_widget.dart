import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!state.otpRequested)
          TextField(
            decoration: const InputDecoration(
              labelText: 'Телефон',
            ),
            controller: state.phoneController,
          ),
        if (!state.otpRequested)
          Row(
            children: [
              Checkbox(
                value: state.everythingAccepted,
                onChanged: (_) => ref
                    .read(phoneAuthStateProvider.notifier)
                    .toggleAcceptance(),
              ),
              const Expanded(
                child: Text(
                  "Даю согласие на обработку персональных данных и подтверждаю согласие с условиями оферты",
                ),
              ),
            ],
          ),
        const Gap(16),
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
            onPressed: () async {
              await ref
                  .read(phoneAuthStateProvider.notifier)
                  .verifyOtp()
                  .then((res) => res && onSuccess != null ? onSuccess!() : {});
            },
            child: const Text('Проверить код'),
          ),
        const Gap(16),
      ],
    );
  }
}
