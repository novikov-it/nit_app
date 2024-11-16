// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_controller_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatControllerStateHash() =>
    r'0cd0397c57369a78cdfd55d434caef3a6dee7151';

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

abstract class _$ChatControllerState
    extends BuildlessAutoDisposeNotifier<ChatControllerStateData> {
  late final String channel;

  ChatControllerStateData build(
    String channel,
  );
}

/// See also [ChatControllerState].
@ProviderFor(ChatControllerState)
const chatControllerStateProvider = ChatControllerStateFamily();

/// See also [ChatControllerState].
class ChatControllerStateFamily extends Family<ChatControllerStateData> {
  /// See also [ChatControllerState].
  const ChatControllerStateFamily();

  /// See also [ChatControllerState].
  ChatControllerStateProvider call(
    String channel,
  ) {
    return ChatControllerStateProvider(
      channel,
    );
  }

  @override
  ChatControllerStateProvider getProviderOverride(
    covariant ChatControllerStateProvider provider,
  ) {
    return call(
      provider.channel,
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
  String? get name => r'chatControllerStateProvider';
}

/// See also [ChatControllerState].
class ChatControllerStateProvider extends AutoDisposeNotifierProviderImpl<
    ChatControllerState, ChatControllerStateData> {
  /// See also [ChatControllerState].
  ChatControllerStateProvider(
    String channel,
  ) : this._internal(
          () => ChatControllerState()..channel = channel,
          from: chatControllerStateProvider,
          name: r'chatControllerStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chatControllerStateHash,
          dependencies: ChatControllerStateFamily._dependencies,
          allTransitiveDependencies:
              ChatControllerStateFamily._allTransitiveDependencies,
          channel: channel,
        );

  ChatControllerStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.channel,
  }) : super.internal();

  final String channel;

  @override
  ChatControllerStateData runNotifierBuild(
    covariant ChatControllerState notifier,
  ) {
    return notifier.build(
      channel,
    );
  }

  @override
  Override overrideWith(ChatControllerState Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChatControllerStateProvider._internal(
        () => create()..channel = channel,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        channel: channel,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ChatControllerState,
      ChatControllerStateData> createElement() {
    return _ChatControllerStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatControllerStateProvider && other.channel == channel;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, channel.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ChatControllerStateRef
    on AutoDisposeNotifierProviderRef<ChatControllerStateData> {
  /// The parameter `channel` of this provider.
  String get channel;
}

class _ChatControllerStateProviderElement
    extends AutoDisposeNotifierProviderElement<ChatControllerState,
        ChatControllerStateData> with ChatControllerStateRef {
  _ChatControllerStateProviderElement(super.provider);

  @override
  String get channel => (origin as ChatControllerStateProvider).channel;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
