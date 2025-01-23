import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';

import '../state/phone_auth_state.dart';

class PhoneInputWidget extends ConsumerWidget {
  const PhoneInputWidget({
    super.key,
    this.extraParams,
  });

  final Map<String, String>? extraParams;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(phoneAuthStateProvider);

    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            NitAuthConfig.config.phoneInputInstructions,
          ),
          TextFormField(
            inputFormatters: [PhoneInputFormatter()],
            decoration: const InputDecoration(
              labelText: 'Телефон',
            ),
            controller: state.phoneController,
            validator: (phone) {
              if (phone?.isNotEmpty != true) return 'Обязательное поле';

              if (!isPhoneValid(
                toNumericString(phone, allowHyphen: false),
                allowEndlessPhone: false,
              )) {
                return 'Неверный формат номера';
              }

              return null;
            },
          ),
          Gap(4),
          FormField<bool>(
            validator: (value) =>
                value != true ? 'Примите соглашения, чтобы продолжить' : null,
            builder: (field) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  transform: Matrix4.translationValues(-6, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                          value:
                              field.value ?? false, // state.everythingAccepted,
                          onChanged: field.didChange
                          //  (_) => ref
                          //     .read(phoneAuthStateProvider.notifier)
                          //     .toggleAcceptance(),
                          ),
                      Gap(4),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            "Даю согласие на обработку персональных данных и подтверждаю согласие с условиями оферты",
                            style: context.textTheme.bodySmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (field.hasError)
                  Text(
                    field.errorText!,
                    style: context.textTheme.bodySmall!.copyWith(
                      color: context.colorScheme.error,
                    ),
                  )
              ],
            ),
          ),
          Gap(20),
          Builder(
            builder: (context) => FilledButton(
              onPressed: () => Form.maybeOf(context)?.validate() == true
                  ? ref.read(phoneAuthStateProvider.notifier).requestOtp(
                        extraParams: extraParams,
                      )
                  : {},
              child: const Text('Запросить код подтверждения'),
            ),
          ),
        ],
      ),
    );
  }
}
