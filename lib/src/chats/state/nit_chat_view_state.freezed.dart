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
mixin _$NitChatViewStateModel {
  ScrollController get scrollController => throw _privateConstructorUsedError;
  ChatViewState get viewState => throw _privateConstructorUsedError;
  List<NitChatMessage> get messages => throw _privateConstructorUsedError;
  int? get lastReadMessageId => throw _privateConstructorUsedError;
  bool get isTyping => throw _privateConstructorUsedError;

  /// Create a copy of NitChatViewStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NitChatViewStateModelCopyWith<NitChatViewStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NitChatViewStateModelCopyWith<$Res> {
  factory $NitChatViewStateModelCopyWith(NitChatViewStateModel value,
          $Res Function(NitChatViewStateModel) then) =
      _$NitChatViewStateModelCopyWithImpl<$Res, NitChatViewStateModel>;
  @useResult
  $Res call(
      {ScrollController scrollController,
      ChatViewState viewState,
      List<NitChatMessage> messages,
      int? lastReadMessageId,
      bool isTyping});
}

/// @nodoc
class _$NitChatViewStateModelCopyWithImpl<$Res,
        $Val extends NitChatViewStateModel>
    implements $NitChatViewStateModelCopyWith<$Res> {
  _$NitChatViewStateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NitChatViewStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scrollController = null,
    Object? viewState = null,
    Object? messages = null,
    Object? lastReadMessageId = freezed,
    Object? isTyping = null,
  }) {
    return _then(_value.copyWith(
      scrollController: null == scrollController
          ? _value.scrollController
          : scrollController // ignore: cast_nullable_to_non_nullable
              as ScrollController,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NitChatViewStateModelImplCopyWith<$Res>
    implements $NitChatViewStateModelCopyWith<$Res> {
  factory _$$NitChatViewStateModelImplCopyWith(
          _$NitChatViewStateModelImpl value,
          $Res Function(_$NitChatViewStateModelImpl) then) =
      __$$NitChatViewStateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ScrollController scrollController,
      ChatViewState viewState,
      List<NitChatMessage> messages,
      int? lastReadMessageId,
      bool isTyping});
}

/// @nodoc
class __$$NitChatViewStateModelImplCopyWithImpl<$Res>
    extends _$NitChatViewStateModelCopyWithImpl<$Res,
        _$NitChatViewStateModelImpl>
    implements _$$NitChatViewStateModelImplCopyWith<$Res> {
  __$$NitChatViewStateModelImplCopyWithImpl(_$NitChatViewStateModelImpl _value,
      $Res Function(_$NitChatViewStateModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of NitChatViewStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scrollController = null,
    Object? viewState = null,
    Object? messages = null,
    Object? lastReadMessageId = freezed,
    Object? isTyping = null,
  }) {
    return _then(_$NitChatViewStateModelImpl(
      scrollController: null == scrollController
          ? _value.scrollController
          : scrollController // ignore: cast_nullable_to_non_nullable
              as ScrollController,
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
    ));
  }
}

/// @nodoc

class _$NitChatViewStateModelImpl implements _NitChatViewStateModel {
  const _$NitChatViewStateModelImpl(
      {required this.scrollController,
      required this.viewState,
      final List<NitChatMessage> messages = const [],
      this.lastReadMessageId,
      this.isTyping = false})
      : _messages = messages;

  @override
  final ScrollController scrollController;
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
  String toString() {
    return 'NitChatViewStateModel(scrollController: $scrollController, viewState: $viewState, messages: $messages, lastReadMessageId: $lastReadMessageId, isTyping: $isTyping)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NitChatViewStateModelImpl &&
            (identical(other.scrollController, scrollController) ||
                other.scrollController == scrollController) &&
            (identical(other.viewState, viewState) ||
                other.viewState == viewState) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.lastReadMessageId, lastReadMessageId) ||
                other.lastReadMessageId == lastReadMessageId) &&
            (identical(other.isTyping, isTyping) ||
                other.isTyping == isTyping));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      scrollController,
      viewState,
      const DeepCollectionEquality().hash(_messages),
      lastReadMessageId,
      isTyping);

  /// Create a copy of NitChatViewStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NitChatViewStateModelImplCopyWith<_$NitChatViewStateModelImpl>
      get copyWith => __$$NitChatViewStateModelImplCopyWithImpl<
          _$NitChatViewStateModelImpl>(this, _$identity);
}

abstract class _NitChatViewStateModel implements NitChatViewStateModel {
  const factory _NitChatViewStateModel(
      {required final ScrollController scrollController,
      required final ChatViewState viewState,
      final List<NitChatMessage> messages,
      final int? lastReadMessageId,
      final bool isTyping}) = _$NitChatViewStateModelImpl;

  @override
  ScrollController get scrollController;
  @override
  ChatViewState get viewState;
  @override
  List<NitChatMessage> get messages;
  @override
  int? get lastReadMessageId;
  @override
  bool get isTyping;

  /// Create a copy of NitChatViewStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NitChatViewStateModelImplCopyWith<_$NitChatViewStateModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
