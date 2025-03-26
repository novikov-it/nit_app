// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nit_socket_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NitSocketStateModel {
  StreamingConnectionStatus get websocketStatus =>
      throw _privateConstructorUsedError;

  /// Create a copy of NitSocketStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NitSocketStateModelCopyWith<NitSocketStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NitSocketStateModelCopyWith<$Res> {
  factory $NitSocketStateModelCopyWith(
          NitSocketStateModel value, $Res Function(NitSocketStateModel) then) =
      _$NitSocketStateModelCopyWithImpl<$Res, NitSocketStateModel>;
  @useResult
  $Res call({StreamingConnectionStatus websocketStatus});
}

/// @nodoc
class _$NitSocketStateModelCopyWithImpl<$Res, $Val extends NitSocketStateModel>
    implements $NitSocketStateModelCopyWith<$Res> {
  _$NitSocketStateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NitSocketStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? websocketStatus = null,
  }) {
    return _then(_value.copyWith(
      websocketStatus: null == websocketStatus
          ? _value.websocketStatus
          : websocketStatus // ignore: cast_nullable_to_non_nullable
              as StreamingConnectionStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NitSocketStateModelImplCopyWith<$Res>
    implements $NitSocketStateModelCopyWith<$Res> {
  factory _$$NitSocketStateModelImplCopyWith(_$NitSocketStateModelImpl value,
          $Res Function(_$NitSocketStateModelImpl) then) =
      __$$NitSocketStateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StreamingConnectionStatus websocketStatus});
}

/// @nodoc
class __$$NitSocketStateModelImplCopyWithImpl<$Res>
    extends _$NitSocketStateModelCopyWithImpl<$Res, _$NitSocketStateModelImpl>
    implements _$$NitSocketStateModelImplCopyWith<$Res> {
  __$$NitSocketStateModelImplCopyWithImpl(_$NitSocketStateModelImpl _value,
      $Res Function(_$NitSocketStateModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of NitSocketStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? websocketStatus = null,
  }) {
    return _then(_$NitSocketStateModelImpl(
      websocketStatus: null == websocketStatus
          ? _value.websocketStatus
          : websocketStatus // ignore: cast_nullable_to_non_nullable
              as StreamingConnectionStatus,
    ));
  }
}

/// @nodoc

class _$NitSocketStateModelImpl implements _NitSocketStateModel {
  const _$NitSocketStateModelImpl({required this.websocketStatus});

  @override
  final StreamingConnectionStatus websocketStatus;

  @override
  String toString() {
    return 'NitSocketStateModel(websocketStatus: $websocketStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NitSocketStateModelImpl &&
            (identical(other.websocketStatus, websocketStatus) ||
                other.websocketStatus == websocketStatus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, websocketStatus);

  /// Create a copy of NitSocketStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NitSocketStateModelImplCopyWith<_$NitSocketStateModelImpl> get copyWith =>
      __$$NitSocketStateModelImplCopyWithImpl<_$NitSocketStateModelImpl>(
          this, _$identity);
}

abstract class _NitSocketStateModel implements NitSocketStateModel {
  const factory _NitSocketStateModel(
          {required final StreamingConnectionStatus websocketStatus}) =
      _$NitSocketStateModelImpl;

  @override
  StreamingConnectionStatus get websocketStatus;

  /// Create a copy of NitSocketStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NitSocketStateModelImplCopyWith<_$NitSocketStateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
