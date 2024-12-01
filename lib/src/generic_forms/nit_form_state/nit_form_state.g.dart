// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'nit_form_state.dart';

// // **************************************************************************
// // RiverpodGenerator
// // **************************************************************************

// String _$nitFormStateHash() => r'fddb4d3888cbf62c6fe707cc8e98e9c7c59ca8cd';

// /// Copied from Dart SDK
// class _SystemHash {
//   _SystemHash._();

//   static int combine(int hash, int value) {
//     // ignore: parameter_assignments
//     hash = 0x1fffffff & (hash + value);
//     // ignore: parameter_assignments
//     hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
//     return hash ^ (hash >> 6);
//   }

//   static int finish(int hash) {
//     // ignore: parameter_assignments
//     hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
//     // ignore: parameter_assignments
//     hash = hash ^ (hash >> 11);
//     return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
//   }
// }

// abstract class _$NitFormState
//     extends BuildlessAutoDisposeNotifier<NitFormStateModel> {
//   late final Key formKey;

//   NitFormStateModel build(
//     Key formKey,
//   );
// }

// /// See also [NitFormState].
// @ProviderFor(NitFormState)
// const nitFormStateProvider = NitFormStateFamily();

// /// See also [NitFormState].
// class NitFormStateFamily extends Family<NitFormStateModel> {
//   /// See also [NitFormState].
//   const NitFormStateFamily();

//   /// See also [NitFormState].
//   NitFormStateProvider call(
//     Key formKey,
//   ) {
//     return NitFormStateProvider(
//       formKey,
//     );
//   }

//   @override
//   NitFormStateProvider getProviderOverride(
//     covariant NitFormStateProvider provider,
//   ) {
//     return call(
//       provider.formKey,
//     );
//   }

//   static const Iterable<ProviderOrFamily>? _dependencies = null;

//   @override
//   Iterable<ProviderOrFamily>? get dependencies => _dependencies;

//   static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

//   @override
//   Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
//       _allTransitiveDependencies;

//   @override
//   String? get name => r'nitFormStateProvider';
// }

// /// See also [NitFormState].
// class NitFormStateProvider
//     extends AutoDisposeNotifierProviderImpl<NitFormState, NitFormStateModel> {
//   /// See also [NitFormState].
//   NitFormStateProvider(
//     Key formKey,
//   ) : this._internal(
//           () => NitFormState()..formKey = formKey,
//           from: nitFormStateProvider,
//           name: r'nitFormStateProvider',
//           debugGetCreateSourceHash:
//               const bool.fromEnvironment('dart.vm.product')
//                   ? null
//                   : _$nitFormStateHash,
//           dependencies: NitFormStateFamily._dependencies,
//           allTransitiveDependencies:
//               NitFormStateFamily._allTransitiveDependencies,
//           formKey: formKey,
//         );

//   NitFormStateProvider._internal(
//     super._createNotifier, {
//     required super.name,
//     required super.dependencies,
//     required super.allTransitiveDependencies,
//     required super.debugGetCreateSourceHash,
//     required super.from,
//     required this.formKey,
//   }) : super.internal();

//   final Key formKey;

//   @override
//   NitFormStateModel runNotifierBuild(
//     covariant NitFormState notifier,
//   ) {
//     return notifier.build(
//       formKey,
//     );
//   }

//   @override
//   Override overrideWith(NitFormState Function() create) {
//     return ProviderOverride(
//       origin: this,
//       override: NitFormStateProvider._internal(
//         () => create()..formKey = formKey,
//         from: from,
//         name: null,
//         dependencies: null,
//         allTransitiveDependencies: null,
//         debugGetCreateSourceHash: null,
//         formKey: formKey,
//       ),
//     );
//   }

//   @override
//   AutoDisposeNotifierProviderElement<NitFormState, NitFormStateModel>
//       createElement() {
//     return _NitFormStateProviderElement(this);
//   }

//   @override
//   bool operator ==(Object other) {
//     return other is NitFormStateProvider && other.formKey == formKey;
//   }

//   @override
//   int get hashCode {
//     var hash = _SystemHash.combine(0, runtimeType.hashCode);
//     hash = _SystemHash.combine(hash, formKey.hashCode);

//     return _SystemHash.finish(hash);
//   }
// }

// @Deprecated('Will be removed in 3.0. Use Ref instead')
// // ignore: unused_element
// mixin NitFormStateRef on AutoDisposeNotifierProviderRef<NitFormStateModel> {
//   /// The parameter `formKey` of this provider.
//   Key get formKey;
// }

// class _NitFormStateProviderElement
//     extends AutoDisposeNotifierProviderElement<NitFormState, NitFormStateModel>
//     with NitFormStateRef {
//   _NitFormStateProviderElement(super.provider);

//   @override
//   Key get formKey => (origin as NitFormStateProvider).formKey;
// }
// // ignore_for_file: type=lint
// // ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
