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
  NitSessionManager? get serverpodSessionManager =>
      throw _privateConstructorUsedError;
  int? get signedInUserId => throw _privateConstructorUsedError;
  List<String> get scopeNames => throw _privateConstructorUsedError;

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
      {NitSessionManager? serverpodSessionManager,
      int? signedInUserId,
      List<String> scopeNames});
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
    Object? signedInUserId = freezed,
    Object? scopeNames = null,
  }) {
    return _then(_value.copyWith(
      serverpodSessionManager: freezed == serverpodSessionManager
          ? _value.serverpodSessionManager
          : serverpodSessionManager // ignore: cast_nullable_to_non_nullable
              as NitSessionManager?,
      signedInUserId: freezed == signedInUserId
          ? _value.signedInUserId
          : signedInUserId // ignore: cast_nullable_to_non_nullable
              as int?,
      scopeNames: null == scopeNames
          ? _value.scopeNames
          : scopeNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
      {NitSessionManager? serverpodSessionManager,
      int? signedInUserId,
      List<String> scopeNames});
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
    Object? signedInUserId = freezed,
    Object? scopeNames = null,
  }) {
    return _then(_$NitSessionStateModelImpl(
      serverpodSessionManager: freezed == serverpodSessionManager
          ? _value.serverpodSessionManager
          : serverpodSessionManager // ignore: cast_nullable_to_non_nullable
              as NitSessionManager?,
      signedInUserId: freezed == signedInUserId
          ? _value.signedInUserId
          : signedInUserId // ignore: cast_nullable_to_non_nullable
              as int?,
      scopeNames: null == scopeNames
          ? _value._scopeNames
          : scopeNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$NitSessionStateModelImpl implements _NitSessionStateModel {
  const _$NitSessionStateModelImpl(
      {required this.serverpodSessionManager,
      required this.signedInUserId,
      required final List<String> scopeNames})
      : _scopeNames = scopeNames;

  @override
  final NitSessionManager? serverpodSessionManager;
  @override
  final int? signedInUserId;
  final List<String> _scopeNames;
  @override
  List<String> get scopeNames {
    if (_scopeNames is EqualUnmodifiableListView) return _scopeNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_scopeNames);
  }

  @override
  String toString() {
    return 'NitSessionStateModel(serverpodSessionManager: $serverpodSessionManager, signedInUserId: $signedInUserId, scopeNames: $scopeNames)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NitSessionStateModelImpl &&
            (identical(
                    other.serverpodSessionManager, serverpodSessionManager) ||
                other.serverpodSessionManager == serverpodSessionManager) &&
            (identical(other.signedInUserId, signedInUserId) ||
                other.signedInUserId == signedInUserId) &&
            const DeepCollectionEquality()
                .equals(other._scopeNames, _scopeNames));
  }

  @override
  int get hashCode => Object.hash(runtimeType, serverpodSessionManager,
      signedInUserId, const DeepCollectionEquality().hash(_scopeNames));

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
      {required final NitSessionManager? serverpodSessionManager,
      required final int? signedInUserId,
      required final List<String> scopeNames}) = _$NitSessionStateModelImpl;

  @override
  NitSessionManager? get serverpodSessionManager;
  @override
  int? get signedInUserId;
  @override
  List<String> get scopeNames;

  /// Create a copy of NitSessionStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NitSessionStateModelImplCopyWith<_$NitSessionStateModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
