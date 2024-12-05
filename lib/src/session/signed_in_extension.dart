import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';

extension SignedInExtension on Ref {
  // bool get signedIn => watch(authRepositoryProvider.select(
  //       (value) => value.value?.isSignedIn ?? false,
  //     ));

  // int? get signedInUserId => watch(authRepositoryProvider.select(
  //       (value) => value.value?.extendedUser?.id,
  //     ));

  bool get signedIn => watch(
        nitSessionStateProvider.select(
          (value) => value.signedInUser != null,
        ),
      );

  int? get signedInUserId => watch(
        nitSessionStateProvider.select(
          (value) => value.signedInUser?.id,
        ),
      );
}

extension SignedInWidgetExtension on WidgetRef {
  // bool get signedIn => watch(authRepositoryProvider.select(
  //       (value) => value.value?.isSignedIn ?? false,
  //     ));

  // int? get signedInUserId => watch(authRepositoryProvider.select(
  //       (value) => value.value?.extendedUser?.id,
  //     ));

  bool get signedIn => watch(
        nitSessionStateProvider.select(
          (value) => value.signedInUser != null,
        ),
      );

  int? get signedInUserId => watch(
        nitSessionStateProvider.select(
          (value) => value.signedInUser?.id,
        ),
      );
}
