// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_ui_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatUIStateHash() => r'ef664210d5cc55437ecc4d683ed78c4fee74ad74';

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

abstract class _$ChatUIState
    extends BuildlessAutoDisposeNotifier<ChatUIStateModel> {
  late final int chatId;

  ChatUIStateModel build(
    int chatId,
  );
}

/// See also [ChatUIState].
@ProviderFor(ChatUIState)
const chatUIStateProvider = ChatUIStateFamily();

/// See also [ChatUIState].
class ChatUIStateFamily extends Family<ChatUIStateModel> {
  /// See also [ChatUIState].
  const ChatUIStateFamily();

  /// See also [ChatUIState].
  ChatUIStateProvider call(
    int chatId,
  ) {
    return ChatUIStateProvider(
      chatId,
    );
  }

  @override
  ChatUIStateProvider getProviderOverride(
    covariant ChatUIStateProvider provider,
  ) {
    return call(
      provider.chatId,
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
  String? get name => r'chatUIStateProvider';
}

/// See also [ChatUIState].
class ChatUIStateProvider
    extends AutoDisposeNotifierProviderImpl<ChatUIState, ChatUIStateModel> {
  /// See also [ChatUIState].
  ChatUIStateProvider(
    int chatId,
  ) : this._internal(
          () => ChatUIState()..chatId = chatId,
          from: chatUIStateProvider,
          name: r'chatUIStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chatUIStateHash,
          dependencies: ChatUIStateFamily._dependencies,
          allTransitiveDependencies:
              ChatUIStateFamily._allTransitiveDependencies,
          chatId: chatId,
        );

  ChatUIStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chatId,
  }) : super.internal();

  final int chatId;

  @override
  ChatUIStateModel runNotifierBuild(
    covariant ChatUIState notifier,
  ) {
    return notifier.build(
      chatId,
    );
  }

  @override
  Override overrideWith(ChatUIState Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChatUIStateProvider._internal(
        () => create()..chatId = chatId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chatId: chatId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ChatUIState, ChatUIStateModel>
      createElement() {
    return _ChatUIStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatUIStateProvider && other.chatId == chatId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chatId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ChatUIStateRef on AutoDisposeNotifierProviderRef<ChatUIStateModel> {
  /// The parameter `chatId` of this provider.
  int get chatId;
}

class _ChatUIStateProviderElement
    extends AutoDisposeNotifierProviderElement<ChatUIState, ChatUIStateModel>
    with ChatUIStateRef {
  _ChatUIStateProviderElement(super.provider);

  @override
  int get chatId => (origin as ChatUIStateProvider).chatId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
