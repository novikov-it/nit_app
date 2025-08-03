// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voice_message_bubble_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VoiceMessageBubbleStateModel {
  AudioStateType get type => throw _privateConstructorUsedError;
  PlayerController get playerController => throw _privateConstructorUsedError;

  /// Create a copy of VoiceMessageBubbleStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoiceMessageBubbleStateModelCopyWith<VoiceMessageBubbleStateModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoiceMessageBubbleStateModelCopyWith<$Res> {
  factory $VoiceMessageBubbleStateModelCopyWith(
          VoiceMessageBubbleStateModel value,
          $Res Function(VoiceMessageBubbleStateModel) then) =
      _$VoiceMessageBubbleStateModelCopyWithImpl<$Res,
          VoiceMessageBubbleStateModel>;
  @useResult
  $Res call({AudioStateType type, PlayerController playerController});
}

/// @nodoc
class _$VoiceMessageBubbleStateModelCopyWithImpl<$Res,
        $Val extends VoiceMessageBubbleStateModel>
    implements $VoiceMessageBubbleStateModelCopyWith<$Res> {
  _$VoiceMessageBubbleStateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VoiceMessageBubbleStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? playerController = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AudioStateType,
      playerController: null == playerController
          ? _value.playerController
          : playerController // ignore: cast_nullable_to_non_nullable
              as PlayerController,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoiceMessageBubbleStateModelImplCopyWith<$Res>
    implements $VoiceMessageBubbleStateModelCopyWith<$Res> {
  factory _$$VoiceMessageBubbleStateModelImplCopyWith(
          _$VoiceMessageBubbleStateModelImpl value,
          $Res Function(_$VoiceMessageBubbleStateModelImpl) then) =
      __$$VoiceMessageBubbleStateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AudioStateType type, PlayerController playerController});
}

/// @nodoc
class __$$VoiceMessageBubbleStateModelImplCopyWithImpl<$Res>
    extends _$VoiceMessageBubbleStateModelCopyWithImpl<$Res,
        _$VoiceMessageBubbleStateModelImpl>
    implements _$$VoiceMessageBubbleStateModelImplCopyWith<$Res> {
  __$$VoiceMessageBubbleStateModelImplCopyWithImpl(
      _$VoiceMessageBubbleStateModelImpl _value,
      $Res Function(_$VoiceMessageBubbleStateModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoiceMessageBubbleStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? playerController = null,
  }) {
    return _then(_$VoiceMessageBubbleStateModelImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AudioStateType,
      playerController: null == playerController
          ? _value.playerController
          : playerController // ignore: cast_nullable_to_non_nullable
              as PlayerController,
    ));
  }
}

/// @nodoc

class _$VoiceMessageBubbleStateModelImpl
    implements _VoiceMessageBubbleStateModel {
  const _$VoiceMessageBubbleStateModelImpl(
      {required this.type, required this.playerController});

  @override
  final AudioStateType type;
  @override
  final PlayerController playerController;

  @override
  String toString() {
    return 'VoiceMessageBubbleStateModel(type: $type, playerController: $playerController)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoiceMessageBubbleStateModelImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.playerController, playerController) ||
                other.playerController == playerController));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type, playerController);

  /// Create a copy of VoiceMessageBubbleStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoiceMessageBubbleStateModelImplCopyWith<
          _$VoiceMessageBubbleStateModelImpl>
      get copyWith => __$$VoiceMessageBubbleStateModelImplCopyWithImpl<
          _$VoiceMessageBubbleStateModelImpl>(this, _$identity);
}

abstract class _VoiceMessageBubbleStateModel
    implements VoiceMessageBubbleStateModel {
  const factory _VoiceMessageBubbleStateModel(
          {required final AudioStateType type,
          required final PlayerController playerController}) =
      _$VoiceMessageBubbleStateModelImpl;

  @override
  AudioStateType get type;
  @override
  PlayerController get playerController;

  /// Create a copy of VoiceMessageBubbleStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoiceMessageBubbleStateModelImplCopyWith<
          _$VoiceMessageBubbleStateModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
