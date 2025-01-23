import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/src/nit_auth/config/nit_auth_mode.dart';

class NitAuthConfig {
  const NitAuthConfig({
    required this.mode,
    required this.phoneInputInstructions,
    required this.otpInputInstructions,
    this.authExtraParamsProvider,
  });

  final NitAuthMode mode;
  final String phoneInputInstructions;
  final String otpInputInstructions;
  final AutoDisposeProvider<Map<String, String>>? authExtraParamsProvider;

  static late final NitAuthConfig config;
}
