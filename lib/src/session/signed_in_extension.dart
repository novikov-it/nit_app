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
          (value) => value.signedInUserId != null,
        ),
      );

  int? get signedInUserId => watch(
        nitSessionStateProvider.select(
          (value) => value.signedInUserId,
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
          (value) => value.signedInUserId != null,
        ),
      );

  int? get signedInUserId => watch(
        nitSessionStateProvider.select(
          (value) => value.signedInUserId,
        ),
      );

  // bool hasAccess(String scopeName) =>
  //     watch(nitSessionStateProvider.select((value) => value.scopeNames))
  //         .contains(scopeName);
}
