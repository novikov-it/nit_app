// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_controller_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChatControllerStateData {
  bool get isReady =>
      throw _privateConstructorUsedError; // required chatview.ChatViewState status,
  serverpod_chat_flutter.ChatController? get serverpodController =>
      throw _privateConstructorUsedError;
  chatview.ChatController get chatViewController =>
      throw _privateConstructorUsedError; // required bool hasMessages,
  int get unreadMessageCount => throw _privateConstructorUsedError;
  ChatMessage? get lastMessage => throw _privateConstructorUsedError;

  /// Create a copy of ChatControllerStateData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatControllerStateDataCopyWith<ChatControllerStateData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatControllerStateDataCopyWith<$Res> {
  factory $ChatControllerStateDataCopyWith(ChatControllerStateData value,
          $Res Function(ChatControllerStateData) then) =
      _$ChatControllerStateDataCopyWithImpl<$Res, ChatControllerStateData>;
  @useResult
  $Res call(
      {bool isReady,
      serverpod_chat_flutter.ChatController? serverpodController,
      chatview.ChatController chatViewController,
      int unreadMessageCount,
      ChatMessage? lastMessage});
}

/// @nodoc
class _$ChatControllerStateDataCopyWithImpl<$Res,
        $Val extends ChatControllerStateData>
    implements $ChatControllerStateDataCopyWith<$Res> {
  _$ChatControllerStateDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatControllerStateData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isReady = null,
    Object? serverpodController = freezed,
    Object? chatViewController = null,
    Object? unreadMessageCount = null,
    Object? lastMessage = freezed,
  }) {
    return _then(_value.copyWith(
      isReady: null == isReady
          ? _value.isReady
          : isReady // ignore: cast_nullable_to_non_nullable
              as bool,
      serverpodController: freezed == serverpodController
          ? _value.serverpodController
          : serverpodController // ignore: cast_nullable_to_non_nullable
              as serverpod_chat_flutter.ChatController?,
      chatViewController: null == chatViewController
          ? _value.chatViewController
          : chatViewController // ignore: cast_nullable_to_non_nullable
              as chatview.ChatController,
      unreadMessageCount: null == unreadMessageCount
          ? _value.unreadMessageCount
          : unreadMessageCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as ChatMessage?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatControllerStateDataImplCopyWith<$Res>
    implements $ChatControllerStateDataCopyWith<$Res> {
  factory _$$ChatControllerStateDataImplCopyWith(
          _$ChatControllerStateDataImpl value,
          $Res Function(_$ChatControllerStateDataImpl) then) =
      __$$ChatControllerStateDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isReady,
      serverpod_chat_flutter.ChatController? serverpodController,
      chatview.ChatController chatViewController,
      int unreadMessageCount,
      ChatMessage? lastMessage});
}

/// @nodoc
class __$$ChatControllerStateDataImplCopyWithImpl<$Res>
    extends _$ChatControllerStateDataCopyWithImpl<$Res,
        _$ChatControllerStateDataImpl>
    implements _$$ChatControllerStateDataImplCopyWith<$Res> {
  __$$ChatControllerStateDataImplCopyWithImpl(
      _$ChatControllerStateDataImpl _value,
      $Res Function(_$ChatControllerStateDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatControllerStateData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isReady = null,
    Object? serverpodController = freezed,
    Object? chatViewController = null,
    Object? unreadMessageCount = null,
    Object? lastMessage = freezed,
  }) {
    return _then(_$ChatControllerStateDataImpl(
      isReady: null == isReady
          ? _value.isReady
          : isReady // ignore: cast_nullable_to_non_nullable
              as bool,
      serverpodController: freezed == serverpodController
          ? _value.serverpodController
          : serverpodController // ignore: cast_nullable_to_non_nullable
              as serverpod_chat_flutter.ChatController?,
      chatViewController: null == chatViewController
          ? _value.chatViewController
          : chatViewController // ignore: cast_nullable_to_non_nullable
              as chatview.ChatController,
      unreadMessageCount: null == unreadMessageCount
          ? _value.unreadMessageCount
          : unreadMessageCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as ChatMessage?,
    ));
  }
}

/// @nodoc

class _$ChatControllerStateDataImpl implements _ChatControllerStateData {
  const _$ChatControllerStateDataImpl(
      {required this.isReady,
      required this.serverpodController,
      required this.chatViewController,
      required this.unreadMessageCount,
      required this.lastMessage});

  @override
  final bool isReady;
// required chatview.ChatViewState status,
  @override
  final serverpod_chat_flutter.ChatController? serverpodController;
  @override
  final chatview.ChatController chatViewController;
// required bool hasMessages,
  @override
  final int unreadMessageCount;
  @override
  final ChatMessage? lastMessage;

  @override
  String toString() {
    return 'ChatControllerStateData(isReady: $isReady, serverpodController: $serverpodController, chatViewController: $chatViewController, unreadMessageCount: $unreadMessageCount, lastMessage: $lastMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatControllerStateDataImpl &&
            (identical(other.isReady, isReady) || other.isReady == isReady) &&
            (identical(other.serverpodController, serverpodController) ||
                other.serverpodController == serverpodController) &&
            (identical(other.chatViewController, chatViewController) ||
                other.chatViewController == chatViewController) &&
            (identical(other.unreadMessageCount, unreadMessageCount) ||
                other.unreadMessageCount == unreadMessageCount) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isReady, serverpodController,
      chatViewController, unreadMessageCount, lastMessage);

  /// Create a copy of ChatControllerStateData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatControllerStateDataImplCopyWith<_$ChatControllerStateDataImpl>
      get copyWith => __$$ChatControllerStateDataImplCopyWithImpl<
          _$ChatControllerStateDataImpl>(this, _$identity);
}

abstract class _ChatControllerStateData implements ChatControllerStateData {
  const factory _ChatControllerStateData(
      {required final bool isReady,
      required final serverpod_chat_flutter.ChatController? serverpodController,
      required final chatview.ChatController chatViewController,
      required final int unreadMessageCount,
      required final ChatMessage? lastMessage}) = _$ChatControllerStateDataImpl;

  @override
  bool get isReady; // required chatview.ChatViewState status,
  @override
  serverpod_chat_flutter.ChatController? get serverpodController;
  @override
  chatview.ChatController get chatViewController; // required bool hasMessages,
  @override
  int get unreadMessageCount;
  @override
  ChatMessage? get lastMessage;

  /// Create a copy of ChatControllerStateData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatControllerStateDataImplCopyWith<_$ChatControllerStateDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
