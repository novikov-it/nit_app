// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nit_chat_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChatStateModel {
  ChatViewState get viewState => throw _privateConstructorUsedError;
  List<NitChatMessage> get messages => throw _privateConstructorUsedError;
  int? get lastReadMessageId => throw _privateConstructorUsedError;
  bool get isTyping => throw _privateConstructorUsedError;
  ScrollController get scrollController => throw _privateConstructorUsedError;
  ListObserverController get observerController =>
      throw _privateConstructorUsedError;
  ChatScrollObserver get chatObserver => throw _privateConstructorUsedError;
  NitChatMessage? get repliedMessage => throw _privateConstructorUsedError;

  /// Create a copy of ChatStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatStateModelCopyWith<ChatStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatStateModelCopyWith<$Res> {
  factory $ChatStateModelCopyWith(
          ChatStateModel value, $Res Function(ChatStateModel) then) =
      _$ChatStateModelCopyWithImpl<$Res, ChatStateModel>;
  @useResult
  $Res call(
      {ChatViewState viewState,
      List<NitChatMessage> messages,
      int? lastReadMessageId,
      bool isTyping,
      ScrollController scrollController,
      ListObserverController observerController,
      ChatScrollObserver chatObserver,
      NitChatMessage? repliedMessage});
}

/// @nodoc
class _$ChatStateModelCopyWithImpl<$Res, $Val extends ChatStateModel>
    implements $ChatStateModelCopyWith<$Res> {
  _$ChatStateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? viewState = null,
    Object? messages = null,
    Object? lastReadMessageId = freezed,
    Object? isTyping = null,
    Object? scrollController = null,
    Object? observerController = null,
    Object? chatObserver = null,
    Object? repliedMessage = freezed,
  }) {
    return _then(_value.copyWith(
      viewState: null == viewState
          ? _value.viewState
          : viewState // ignore: cast_nullable_to_non_nullable
              as ChatViewState,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<NitChatMessage>,
      lastReadMessageId: freezed == lastReadMessageId
          ? _value.lastReadMessageId
          : lastReadMessageId // ignore: cast_nullable_to_non_nullable
              as int?,
      isTyping: null == isTyping
          ? _value.isTyping
          : isTyping // ignore: cast_nullable_to_non_nullable
              as bool,
      scrollController: null == scrollController
          ? _value.scrollController
          : scrollController // ignore: cast_nullable_to_non_nullable
              as ScrollController,
      observerController: null == observerController
          ? _value.observerController
          : observerController // ignore: cast_nullable_to_non_nullable
              as ListObserverController,
      chatObserver: null == chatObserver
          ? _value.chatObserver
          : chatObserver // ignore: cast_nullable_to_non_nullable
              as ChatScrollObserver,
      repliedMessage: freezed == repliedMessage
          ? _value.repliedMessage
          : repliedMessage // ignore: cast_nullable_to_non_nullable
              as NitChatMessage?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatStateModelImplCopyWith<$Res>
    implements $ChatStateModelCopyWith<$Res> {
  factory _$$ChatStateModelImplCopyWith(_$ChatStateModelImpl value,
          $Res Function(_$ChatStateModelImpl) then) =
      __$$ChatStateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ChatViewState viewState,
      List<NitChatMessage> messages,
      int? lastReadMessageId,
      bool isTyping,
      ScrollController scrollController,
      ListObserverController observerController,
      ChatScrollObserver chatObserver,
      NitChatMessage? repliedMessage});
}

/// @nodoc
class __$$ChatStateModelImplCopyWithImpl<$Res>
    extends _$ChatStateModelCopyWithImpl<$Res, _$ChatStateModelImpl>
    implements _$$ChatStateModelImplCopyWith<$Res> {
  __$$ChatStateModelImplCopyWithImpl(
      _$ChatStateModelImpl _value, $Res Function(_$ChatStateModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? viewState = null,
    Object? messages = null,
    Object? lastReadMessageId = freezed,
    Object? isTyping = null,
    Object? scrollController = null,
    Object? observerController = null,
    Object? chatObserver = null,
    Object? repliedMessage = freezed,
  }) {
    return _then(_$ChatStateModelImpl(
      viewState: null == viewState
          ? _value.viewState
          : viewState // ignore: cast_nullable_to_non_nullable
              as ChatViewState,
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<NitChatMessage>,
      lastReadMessageId: freezed == lastReadMessageId
          ? _value.lastReadMessageId
          : lastReadMessageId // ignore: cast_nullable_to_non_nullable
              as int?,
      isTyping: null == isTyping
          ? _value.isTyping
          : isTyping // ignore: cast_nullable_to_non_nullable
              as bool,
      scrollController: null == scrollController
          ? _value.scrollController
          : scrollController // ignore: cast_nullable_to_non_nullable
              as ScrollController,
      observerController: null == observerController
          ? _value.observerController
          : observerController // ignore: cast_nullable_to_non_nullable
              as ListObserverController,
      chatObserver: null == chatObserver
          ? _value.chatObserver
          : chatObserver // ignore: cast_nullable_to_non_nullable
              as ChatScrollObserver,
      repliedMessage: freezed == repliedMessage
          ? _value.repliedMessage
          : repliedMessage // ignore: cast_nullable_to_non_nullable
              as NitChatMessage?,
    ));
  }
}

/// @nodoc

class _$ChatStateModelImpl implements _ChatStateModel {
  const _$ChatStateModelImpl(
      {required this.viewState,
      final List<NitChatMessage> messages = const [],
      this.lastReadMessageId,
      this.isTyping = false,
      required this.scrollController,
      required this.observerController,
      required this.chatObserver,
      this.repliedMessage})
      : _messages = messages;

  @override
  final ChatViewState viewState;
  final List<NitChatMessage> _messages;
  @override
  @JsonKey()
  List<NitChatMessage> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  final int? lastReadMessageId;
  @override
  @JsonKey()
  final bool isTyping;
  @override
  final ScrollController scrollController;
  @override
  final ListObserverController observerController;
  @override
  final ChatScrollObserver chatObserver;
  @override
  final NitChatMessage? repliedMessage;

  @override
  String toString() {
    return 'ChatStateModel(viewState: $viewState, messages: $messages, lastReadMessageId: $lastReadMessageId, isTyping: $isTyping, scrollController: $scrollController, observerController: $observerController, chatObserver: $chatObserver, repliedMessage: $repliedMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatStateModelImpl &&
            (identical(other.viewState, viewState) ||
                other.viewState == viewState) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.lastReadMessageId, lastReadMessageId) ||
                other.lastReadMessageId == lastReadMessageId) &&
            (identical(other.isTyping, isTyping) ||
                other.isTyping == isTyping) &&
            (identical(other.scrollController, scrollController) ||
                other.scrollController == scrollController) &&
            (identical(other.observerController, observerController) ||
                other.observerController == observerController) &&
            (identical(other.chatObserver, chatObserver) ||
                other.chatObserver == chatObserver) &&
            (identical(other.repliedMessage, repliedMessage) ||
                other.repliedMessage == repliedMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      viewState,
      const DeepCollectionEquality().hash(_messages),
      lastReadMessageId,
      isTyping,
      scrollController,
      observerController,
      chatObserver,
      repliedMessage);

  /// Create a copy of ChatStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatStateModelImplCopyWith<_$ChatStateModelImpl> get copyWith =>
      __$$ChatStateModelImplCopyWithImpl<_$ChatStateModelImpl>(
          this, _$identity);
}

abstract class _ChatStateModel implements ChatStateModel {
  const factory _ChatStateModel(
      {required final ChatViewState viewState,
      final List<NitChatMessage> messages,
      final int? lastReadMessageId,
      final bool isTyping,
      required final ScrollController scrollController,
      required final ListObserverController observerController,
      required final ChatScrollObserver chatObserver,
      final NitChatMessage? repliedMessage}) = _$ChatStateModelImpl;

  @override
  ChatViewState get viewState;
  @override
  List<NitChatMessage> get messages;
  @override
  int? get lastReadMessageId;
  @override
  bool get isTyping;
  @override
  ScrollController get scrollController;
  @override
  ListObserverController get observerController;
  @override
  ChatScrollObserver get chatObserver;
  @override
  NitChatMessage? get repliedMessage;

  /// Create a copy of ChatStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatStateModelImplCopyWith<_$ChatStateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
