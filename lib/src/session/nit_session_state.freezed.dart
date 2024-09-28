// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nit_session_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NitSessionStateModel {
  UserInfo? get signedInUser => throw _privateConstructorUsedError;
  StreamingConnectionStatus get websocketStatus =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NitSessionStateModelCopyWith<NitSessionStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NitSessionStateModelCopyWith<$Res> {
  factory $NitSessionStateModelCopyWith(NitSessionStateModel value,
          $Res Function(NitSessionStateModel) then) =
      _$NitSessionStateModelCopyWithImpl<$Res, NitSessionStateModel>;
  @useResult
  $Res call(
      {UserInfo? signedInUser, StreamingConnectionStatus websocketStatus});
}

/// @nodoc
class _$NitSessionStateModelCopyWithImpl<$Res,
        $Val extends NitSessionStateModel>
    implements $NitSessionStateModelCopyWith<$Res> {
  _$NitSessionStateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedInUser = freezed,
    Object? websocketStatus = null,
  }) {
    return _then(_value.copyWith(
      signedInUser: freezed == signedInUser
          ? _value.signedInUser
          : signedInUser // ignore: cast_nullable_to_non_nullable
              as UserInfo?,
      websocketStatus: null == websocketStatus
          ? _value.websocketStatus
          : websocketStatus // ignore: cast_nullable_to_non_nullable
              as StreamingConnectionStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NitSessionStateModelImplCopyWith<$Res>
    implements $NitSessionStateModelCopyWith<$Res> {
  factory _$$NitSessionStateModelImplCopyWith(_$NitSessionStateModelImpl value,
          $Res Function(_$NitSessionStateModelImpl) then) =
      __$$NitSessionStateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UserInfo? signedInUser, StreamingConnectionStatus websocketStatus});
}

/// @nodoc
class __$$NitSessionStateModelImplCopyWithImpl<$Res>
    extends _$NitSessionStateModelCopyWithImpl<$Res, _$NitSessionStateModelImpl>
    implements _$$NitSessionStateModelImplCopyWith<$Res> {
  __$$NitSessionStateModelImplCopyWithImpl(_$NitSessionStateModelImpl _value,
      $Res Function(_$NitSessionStateModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedInUser = freezed,
    Object? websocketStatus = null,
  }) {
    return _then(_$NitSessionStateModelImpl(
      signedInUser: freezed == signedInUser
          ? _value.signedInUser
          : signedInUser // ignore: cast_nullable_to_non_nullable
              as UserInfo?,
      websocketStatus: null == websocketStatus
          ? _value.websocketStatus
          : websocketStatus // ignore: cast_nullable_to_non_nullable
              as StreamingConnectionStatus,
    ));
  }
}

/// @nodoc

class _$NitSessionStateModelImpl implements _NitSessionStateModel {
  const _$NitSessionStateModelImpl(
      {required this.signedInUser, required this.websocketStatus});

  @override
  final UserInfo? signedInUser;
  @override
  final StreamingConnectionStatus websocketStatus;

  @override
  String toString() {
    return 'NitSessionStateModel(signedInUser: $signedInUser, websocketStatus: $websocketStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NitSessionStateModelImpl &&
            (identical(other.signedInUser, signedInUser) ||
                other.signedInUser == signedInUser) &&
            (identical(other.websocketStatus, websocketStatus) ||
                other.websocketStatus == websocketStatus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, signedInUser, websocketStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NitSessionStateModelImplCopyWith<_$NitSessionStateModelImpl>
      get copyWith =>
          __$$NitSessionStateModelImplCopyWithImpl<_$NitSessionStateModelImpl>(
              this, _$identity);
}

abstract class _NitSessionStateModel implements NitSessionStateModel {
  const factory _NitSessionStateModel(
          {required final UserInfo? signedInUser,
          required final StreamingConnectionStatus websocketStatus}) =
      _$NitSessionStateModelImpl;

  @override
  UserInfo? get signedInUser;
  @override
  StreamingConnectionStatus get websocketStatus;
  @override
  @JsonKey(ignore: true)
  _$$NitSessionStateModelImplCopyWith<_$NitSessionStateModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
