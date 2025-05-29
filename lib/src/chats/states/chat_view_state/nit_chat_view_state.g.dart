// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nit_chat_view_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatStateHash() => r'5d80e141cdbf2ff5bc4e7c14566f3831f8229e02';

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

abstract class _$ChatState
    extends BuildlessAutoDisposeNotifier<ChatStateModel> {
  late final int chatId;

  ChatStateModel build(
    int chatId,
  );
}

/// See also [ChatState].
@ProviderFor(ChatState)
const chatStateProvider = ChatStateFamily();

/// See also [ChatState].
class ChatStateFamily extends Family<ChatStateModel> {
  /// See also [ChatState].
  const ChatStateFamily();

  /// See also [ChatState].
  ChatStateProvider call(
    int chatId,
  ) {
    return ChatStateProvider(
      chatId,
    );
  }

  @override
  ChatStateProvider getProviderOverride(
    covariant ChatStateProvider provider,
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
  String? get name => r'chatStateProvider';
}

/// See also [ChatState].
class ChatStateProvider
    extends AutoDisposeNotifierProviderImpl<ChatState, ChatStateModel> {
  /// See also [ChatState].
  ChatStateProvider(
    int chatId,
  ) : this._internal(
          () => ChatState()..chatId = chatId,
          from: chatStateProvider,
          name: r'chatStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chatStateHash,
          dependencies: ChatStateFamily._dependencies,
          allTransitiveDependencies: ChatStateFamily._allTransitiveDependencies,
          chatId: chatId,
        );

  ChatStateProvider._internal(
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
  ChatStateModel runNotifierBuild(
    covariant ChatState notifier,
  ) {
    return notifier.build(
      chatId,
    );
  }

  @override
  Override overrideWith(ChatState Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChatStateProvider._internal(
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
  AutoDisposeNotifierProviderElement<ChatState, ChatStateModel>
      createElement() {
    return _ChatStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatStateProvider && other.chatId == chatId;
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
mixin ChatStateRef on AutoDisposeNotifierProviderRef<ChatStateModel> {
  /// The parameter `chatId` of this provider.
  int get chatId;
}

class _ChatStateProviderElement
    extends AutoDisposeNotifierProviderElement<ChatState, ChatStateModel>
    with ChatStateRef {
  _ChatStateProviderElement(super.provider);

  @override
  int get chatId => (origin as ChatStateProvider).chatId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
