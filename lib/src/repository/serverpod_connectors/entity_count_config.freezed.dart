// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entity_count_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EntityCountConfig {
  NitBackendFilter<dynamic>? get backendFilter =>
      throw _privateConstructorUsedError; // int? pageSize,
  dynamic Function(List<ObjectWrapper>)? get customUpdatesListener =>
      throw _privateConstructorUsedError;

  /// Create a copy of EntityCountConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EntityCountConfigCopyWith<EntityCountConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntityCountConfigCopyWith<$Res> {
  factory $EntityCountConfigCopyWith(
          EntityCountConfig value, $Res Function(EntityCountConfig) then) =
      _$EntityCountConfigCopyWithImpl<$Res, EntityCountConfig>;
  @useResult
  $Res call(
      {NitBackendFilter<dynamic>? backendFilter,
      dynamic Function(List<ObjectWrapper>)? customUpdatesListener});
}

/// @nodoc
class _$EntityCountConfigCopyWithImpl<$Res, $Val extends EntityCountConfig>
    implements $EntityCountConfigCopyWith<$Res> {
  _$EntityCountConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EntityCountConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backendFilter = freezed,
    Object? customUpdatesListener = freezed,
  }) {
    return _then(_value.copyWith(
      backendFilter: freezed == backendFilter
          ? _value.backendFilter
          : backendFilter // ignore: cast_nullable_to_non_nullable
              as NitBackendFilter<dynamic>?,
      customUpdatesListener: freezed == customUpdatesListener
          ? _value.customUpdatesListener
          : customUpdatesListener // ignore: cast_nullable_to_non_nullable
              as dynamic Function(List<ObjectWrapper>)?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EntityCountConfigImplCopyWith<$Res>
    implements $EntityCountConfigCopyWith<$Res> {
  factory _$$EntityCountConfigImplCopyWith(_$EntityCountConfigImpl value,
          $Res Function(_$EntityCountConfigImpl) then) =
      __$$EntityCountConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {NitBackendFilter<dynamic>? backendFilter,
      dynamic Function(List<ObjectWrapper>)? customUpdatesListener});
}

/// @nodoc
class __$$EntityCountConfigImplCopyWithImpl<$Res>
    extends _$EntityCountConfigCopyWithImpl<$Res, _$EntityCountConfigImpl>
    implements _$$EntityCountConfigImplCopyWith<$Res> {
  __$$EntityCountConfigImplCopyWithImpl(_$EntityCountConfigImpl _value,
      $Res Function(_$EntityCountConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of EntityCountConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backendFilter = freezed,
    Object? customUpdatesListener = freezed,
  }) {
    return _then(_$EntityCountConfigImpl(
      backendFilter: freezed == backendFilter
          ? _value.backendFilter
          : backendFilter // ignore: cast_nullable_to_non_nullable
              as NitBackendFilter<dynamic>?,
      customUpdatesListener: freezed == customUpdatesListener
          ? _value.customUpdatesListener
          : customUpdatesListener // ignore: cast_nullable_to_non_nullable
              as dynamic Function(List<ObjectWrapper>)?,
    ));
  }
}

/// @nodoc

class _$EntityCountConfigImpl implements _EntityCountConfig {
  const _$EntityCountConfigImpl(
      {this.backendFilter, this.customUpdatesListener});

  @override
  final NitBackendFilter<dynamic>? backendFilter;
// int? pageSize,
  @override
  final dynamic Function(List<ObjectWrapper>)? customUpdatesListener;

  @override
  String toString() {
    return 'EntityCountConfig(backendFilter: $backendFilter, customUpdatesListener: $customUpdatesListener)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntityCountConfigImpl &&
            (identical(other.backendFilter, backendFilter) ||
                other.backendFilter == backendFilter) &&
            (identical(other.customUpdatesListener, customUpdatesListener) ||
                other.customUpdatesListener == customUpdatesListener));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, backendFilter, customUpdatesListener);

  /// Create a copy of EntityCountConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EntityCountConfigImplCopyWith<_$EntityCountConfigImpl> get copyWith =>
      __$$EntityCountConfigImplCopyWithImpl<_$EntityCountConfigImpl>(
          this, _$identity);
}

abstract class _EntityCountConfig implements EntityCountConfig {
  const factory _EntityCountConfig(
          {final NitBackendFilter<dynamic>? backendFilter,
          final dynamic Function(List<ObjectWrapper>)? customUpdatesListener}) =
      _$EntityCountConfigImpl;

  @override
  NitBackendFilter<dynamic>? get backendFilter; // int? pageSize,
  @override
  dynamic Function(List<ObjectWrapper>)? get customUpdatesListener;

  /// Create a copy of EntityCountConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EntityCountConfigImplCopyWith<_$EntityCountConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
