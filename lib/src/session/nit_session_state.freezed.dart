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
  SessionManager? get serverpodSessionManager =>
      throw _privateConstructorUsedError;
  UserInfo? get signedInUser => throw _privateConstructorUsedError;
  nit_tools.StreamingConnectionStatus get websocketStatus =>
      throw _privateConstructorUsedError;
  bool get notificationsEnabled => throw _privateConstructorUsedError;

  /// Create a copy of NitSessionStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {SessionManager? serverpodSessionManager,
      UserInfo? signedInUser,
      nit_tools.StreamingConnectionStatus websocketStatus,
      bool notificationsEnabled});
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

  /// Create a copy of NitSessionStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serverpodSessionManager = freezed,
    Object? signedInUser = freezed,
    Object? websocketStatus = null,
    Object? notificationsEnabled = null,
  }) {
    return _then(_value.copyWith(
      serverpodSessionManager: freezed == serverpodSessionManager
          ? _value.serverpodSessionManager
          : serverpodSessionManager // ignore: cast_nullable_to_non_nullable
              as SessionManager?,
      signedInUser: freezed == signedInUser
          ? _value.signedInUser
          : signedInUser // ignore: cast_nullable_to_non_nullable
              as UserInfo?,
      websocketStatus: null == websocketStatus
          ? _value.websocketStatus
          : websocketStatus // ignore: cast_nullable_to_non_nullable
              as nit_tools.StreamingConnectionStatus,
      notificationsEnabled: null == notificationsEnabled
          ? _value.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
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
      {SessionManager? serverpodSessionManager,
      UserInfo? signedInUser,
      nit_tools.StreamingConnectionStatus websocketStatus,
      bool notificationsEnabled});
}

/// @nodoc
class __$$NitSessionStateModelImplCopyWithImpl<$Res>
    extends _$NitSessionStateModelCopyWithImpl<$Res, _$NitSessionStateModelImpl>
    implements _$$NitSessionStateModelImplCopyWith<$Res> {
  __$$NitSessionStateModelImplCopyWithImpl(_$NitSessionStateModelImpl _value,
      $Res Function(_$NitSessionStateModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of NitSessionStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serverpodSessionManager = freezed,
    Object? signedInUser = freezed,
    Object? websocketStatus = null,
    Object? notificationsEnabled = null,
  }) {
    return _then(_$NitSessionStateModelImpl(
      serverpodSessionManager: freezed == serverpodSessionManager
          ? _value.serverpodSessionManager
          : serverpodSessionManager // ignore: cast_nullable_to_non_nullable
              as SessionManager?,
      signedInUser: freezed == signedInUser
          ? _value.signedInUser
          : signedInUser // ignore: cast_nullable_to_non_nullable
              as UserInfo?,
      websocketStatus: null == websocketStatus
          ? _value.websocketStatus
          : websocketStatus // ignore: cast_nullable_to_non_nullable
              as nit_tools.StreamingConnectionStatus,
      notificationsEnabled: null == notificationsEnabled
          ? _value.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$NitSessionStateModelImpl implements _NitSessionStateModel {
  const _$NitSessionStateModelImpl(
      {required this.serverpodSessionManager,
      required this.signedInUser,
      required this.websocketStatus,
      required this.notificationsEnabled});

  @override
  final SessionManager? serverpodSessionManager;
  @override
  final UserInfo? signedInUser;
  @override
  final nit_tools.StreamingConnectionStatus websocketStatus;
  @override
  final bool notificationsEnabled;

  @override
  String toString() {
    return 'NitSessionStateModel(serverpodSessionManager: $serverpodSessionManager, signedInUser: $signedInUser, websocketStatus: $websocketStatus, notificationsEnabled: $notificationsEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NitSessionStateModelImpl &&
            (identical(
                    other.serverpodSessionManager, serverpodSessionManager) ||
                other.serverpodSessionManager == serverpodSessionManager) &&
            (identical(other.signedInUser, signedInUser) ||
                other.signedInUser == signedInUser) &&
            (identical(other.websocketStatus, websocketStatus) ||
                other.websocketStatus == websocketStatus) &&
            (identical(other.notificationsEnabled, notificationsEnabled) ||
                other.notificationsEnabled == notificationsEnabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, serverpodSessionManager,
      signedInUser, websocketStatus, notificationsEnabled);

  /// Create a copy of NitSessionStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NitSessionStateModelImplCopyWith<_$NitSessionStateModelImpl>
      get copyWith =>
          __$$NitSessionStateModelImplCopyWithImpl<_$NitSessionStateModelImpl>(
              this, _$identity);
}

abstract class _NitSessionStateModel implements NitSessionStateModel {
  const factory _NitSessionStateModel(
      {required final SessionManager? serverpodSessionManager,
      required final UserInfo? signedInUser,
      required final nit_tools.StreamingConnectionStatus websocketStatus,
      required final bool notificationsEnabled}) = _$NitSessionStateModelImpl;

  @override
  SessionManager? get serverpodSessionManager;
  @override
  UserInfo? get signedInUser;
  @override
  nit_tools.StreamingConnectionStatus get websocketStatus;
  @override
  bool get notificationsEnabled;

  /// Create a copy of NitSessionStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NitSessionStateModelImplCopyWith<_$NitSessionStateModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
