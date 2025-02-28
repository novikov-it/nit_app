// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nit_chat_view_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$nitChatViewStateHash() => r'23b439efa356a4fc8ba8c1f7d4c0dc8f02ab78f6';

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

abstract class _$NitChatViewState
    extends BuildlessAutoDisposeNotifier<NitChatViewStateModel> {
  late final int chatId;

  NitChatViewStateModel build(
    int chatId,
  );
}

/// See also [NitChatViewState].
@ProviderFor(NitChatViewState)
const nitChatViewStateProvider = NitChatViewStateFamily();

/// See also [NitChatViewState].
class NitChatViewStateFamily extends Family<NitChatViewStateModel> {
  /// See also [NitChatViewState].
  const NitChatViewStateFamily();

  /// See also [NitChatViewState].
  NitChatViewStateProvider call(
    int chatId,
  ) {
    return NitChatViewStateProvider(
      chatId,
    );
  }

  @override
  NitChatViewStateProvider getProviderOverride(
    covariant NitChatViewStateProvider provider,
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
  String? get name => r'nitChatViewStateProvider';
}

/// See also [NitChatViewState].
class NitChatViewStateProvider extends AutoDisposeNotifierProviderImpl<
    NitChatViewState, NitChatViewStateModel> {
  /// See also [NitChatViewState].
  NitChatViewStateProvider(
    int chatId,
  ) : this._internal(
          () => NitChatViewState()..chatId = chatId,
          from: nitChatViewStateProvider,
          name: r'nitChatViewStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$nitChatViewStateHash,
          dependencies: NitChatViewStateFamily._dependencies,
          allTransitiveDependencies:
              NitChatViewStateFamily._allTransitiveDependencies,
          chatId: chatId,
        );

  NitChatViewStateProvider._internal(
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
  NitChatViewStateModel runNotifierBuild(
    covariant NitChatViewState notifier,
  ) {
    return notifier.build(
      chatId,
    );
  }

  @override
  Override overrideWith(NitChatViewState Function() create) {
    return ProviderOverride(
      origin: this,
      override: NitChatViewStateProvider._internal(
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
  AutoDisposeNotifierProviderElement<NitChatViewState, NitChatViewStateModel>
      createElement() {
    return _NitChatViewStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NitChatViewStateProvider && other.chatId == chatId;
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
mixin NitChatViewStateRef
    on AutoDisposeNotifierProviderRef<NitChatViewStateModel> {
  /// The parameter `chatId` of this provider.
  int get chatId;
}

class _NitChatViewStateProviderElement
    extends AutoDisposeNotifierProviderElement<NitChatViewState,
        NitChatViewStateModel> with NitChatViewStateRef {
  _NitChatViewStateProviderElement(super.provider);

  @override
  int get chatId => (origin as NitChatViewStateProvider).chatId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
