// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_message_bubble_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$voiceMessageBubbleStateHash() =>
    r'8f09e75caf69a39b6a27286489fc30e64eff631d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$VoiceMessageBubbleState
    extends BuildlessNotifier<VoiceMessageBubbleStateModel> {
  late final String url;

  VoiceMessageBubbleStateModel build(
    String url,
  );
}

/// See also [VoiceMessageBubbleState].
@ProviderFor(VoiceMessageBubbleState)
const voiceMessageBubbleStateProvider = VoiceMessageBubbleStateFamily();

/// See also [VoiceMessageBubbleState].
class VoiceMessageBubbleStateFamily
    extends Family<VoiceMessageBubbleStateModel> {
  /// See also [VoiceMessageBubbleState].
  const VoiceMessageBubbleStateFamily();

  /// See also [VoiceMessageBubbleState].
  VoiceMessageBubbleStateProvider call(
    String url,
  ) {
    return VoiceMessageBubbleStateProvider(
      url,
    );
  }

  @override
  VoiceMessageBubbleStateProvider getProviderOverride(
    covariant VoiceMessageBubbleStateProvider provider,
  ) {
    return call(
      provider.url,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'voiceMessageBubbleStateProvider';
}

/// See also [VoiceMessageBubbleState].
class VoiceMessageBubbleStateProvider extends NotifierProviderImpl<
    VoiceMessageBubbleState, VoiceMessageBubbleStateModel> {
  /// See also [VoiceMessageBubbleState].
  VoiceMessageBubbleStateProvider(
    String url,
  ) : this._internal(
          () => VoiceMessageBubbleState()..url = url,
          from: voiceMessageBubbleStateProvider,
          name: r'voiceMessageBubbleStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$voiceMessageBubbleStateHash,
          dependencies: VoiceMessageBubbleStateFamily._dependencies,
          allTransitiveDependencies:
              VoiceMessageBubbleStateFamily._allTransitiveDependencies,
          url: url,
        );

  VoiceMessageBubbleStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.url,
  }) : super.internal();

  final String url;

  @override
  VoiceMessageBubbleStateModel runNotifierBuild(
    covariant VoiceMessageBubbleState notifier,
  ) {
    return notifier.build(
      url,
    );
  }

  @override
  Override overrideWith(VoiceMessageBubbleState Function() create) {
    return ProviderOverride(
      origin: this,
      override: VoiceMessageBubbleStateProvider._internal(
        () => create()..url = url,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        url: url,
      ),
    );
  }

  @override
  NotifierProviderElement<VoiceMessageBubbleState, VoiceMessageBubbleStateModel>
      createElement() {
    return _VoiceMessageBubbleStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is VoiceMessageBubbleStateProvider && other.url == url;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, url.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin VoiceMessageBubbleStateRef
    on NotifierProviderRef<VoiceMessageBubbleStateModel> {
  /// The parameter `url` of this provider.
  String get url;
}

class _VoiceMessageBubbleStateProviderElement extends NotifierProviderElement<
    VoiceMessageBubbleState,
    VoiceMessageBubbleStateModel> with VoiceMessageBubbleStateRef {
  _VoiceMessageBubbleStateProviderElement(super.provider);

  @override
  String get url => (origin as VoiceMessageBubbleStateProvider).url;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
