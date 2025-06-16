// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nit_firebase_notifications_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NitFirebaseNotificationsStateModel {
  bool get notificationsAllowed => throw _privateConstructorUsedError;
  bool get mayRequest => throw _privateConstructorUsedError;

  /// Create a copy of NitFirebaseNotificationsStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NitFirebaseNotificationsStateModelCopyWith<
          NitFirebaseNotificationsStateModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NitFirebaseNotificationsStateModelCopyWith<$Res> {
  factory $NitFirebaseNotificationsStateModelCopyWith(
          NitFirebaseNotificationsStateModel value,
          $Res Function(NitFirebaseNotificationsStateModel) then) =
      _$NitFirebaseNotificationsStateModelCopyWithImpl<$Res,
          NitFirebaseNotificationsStateModel>;
  @useResult
  $Res call({bool notificationsAllowed, bool mayRequest});
}

/// @nodoc
class _$NitFirebaseNotificationsStateModelCopyWithImpl<$Res,
        $Val extends NitFirebaseNotificationsStateModel>
    implements $NitFirebaseNotificationsStateModelCopyWith<$Res> {
  _$NitFirebaseNotificationsStateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NitFirebaseNotificationsStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationsAllowed = null,
    Object? mayRequest = null,
  }) {
    return _then(_value.copyWith(
      notificationsAllowed: null == notificationsAllowed
          ? _value.notificationsAllowed
          : notificationsAllowed // ignore: cast_nullable_to_non_nullable
              as bool,
      mayRequest: null == mayRequest
          ? _value.mayRequest
          : mayRequest // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NitFirebaseNotificationsStateModelImplCopyWith<$Res>
    implements $NitFirebaseNotificationsStateModelCopyWith<$Res> {
  factory _$$NitFirebaseNotificationsStateModelImplCopyWith(
          _$NitFirebaseNotificationsStateModelImpl value,
          $Res Function(_$NitFirebaseNotificationsStateModelImpl) then) =
      __$$NitFirebaseNotificationsStateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool notificationsAllowed, bool mayRequest});
}

/// @nodoc
class __$$NitFirebaseNotificationsStateModelImplCopyWithImpl<$Res>
    extends _$NitFirebaseNotificationsStateModelCopyWithImpl<$Res,
        _$NitFirebaseNotificationsStateModelImpl>
    implements _$$NitFirebaseNotificationsStateModelImplCopyWith<$Res> {
  __$$NitFirebaseNotificationsStateModelImplCopyWithImpl(
      _$NitFirebaseNotificationsStateModelImpl _value,
      $Res Function(_$NitFirebaseNotificationsStateModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of NitFirebaseNotificationsStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationsAllowed = null,
    Object? mayRequest = null,
  }) {
    return _then(_$NitFirebaseNotificationsStateModelImpl(
      notificationsAllowed: null == notificationsAllowed
          ? _value.notificationsAllowed
          : notificationsAllowed // ignore: cast_nullable_to_non_nullable
              as bool,
      mayRequest: null == mayRequest
          ? _value.mayRequest
          : mayRequest // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$NitFirebaseNotificationsStateModelImpl
    with DiagnosticableTreeMixin
    implements _NitFirebaseNotificationsStateModel {
  const _$NitFirebaseNotificationsStateModelImpl(
      {required this.notificationsAllowed, required this.mayRequest});

  @override
  final bool notificationsAllowed;
  @override
  final bool mayRequest;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NitFirebaseNotificationsStateModel(notificationsAllowed: $notificationsAllowed, mayRequest: $mayRequest)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NitFirebaseNotificationsStateModel'))
      ..add(DiagnosticsProperty('notificationsAllowed', notificationsAllowed))
      ..add(DiagnosticsProperty('mayRequest', mayRequest));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NitFirebaseNotificationsStateModelImpl &&
            (identical(other.notificationsAllowed, notificationsAllowed) ||
                other.notificationsAllowed == notificationsAllowed) &&
            (identical(other.mayRequest, mayRequest) ||
                other.mayRequest == mayRequest));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, notificationsAllowed, mayRequest);

  /// Create a copy of NitFirebaseNotificationsStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NitFirebaseNotificationsStateModelImplCopyWith<
          _$NitFirebaseNotificationsStateModelImpl>
      get copyWith => __$$NitFirebaseNotificationsStateModelImplCopyWithImpl<
          _$NitFirebaseNotificationsStateModelImpl>(this, _$identity);
}

abstract class _NitFirebaseNotificationsStateModel
    implements NitFirebaseNotificationsStateModel {
  const factory _NitFirebaseNotificationsStateModel(
          {required final bool notificationsAllowed,
          required final bool mayRequest}) =
      _$NitFirebaseNotificationsStateModelImpl;

  @override
  bool get notificationsAllowed;
  @override
  bool get mayRequest;

  /// Create a copy of NitFirebaseNotificationsStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NitFirebaseNotificationsStateModelImplCopyWith<
          _$NitFirebaseNotificationsStateModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
