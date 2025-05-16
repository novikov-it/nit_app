// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entity_list_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EntityListConfig {
  NitBackendFilter<dynamic>? get backendFilter =>
      throw _privateConstructorUsedError;
  dynamic Function(ObjectWrapper)? get customUpdatesListener =>
      throw _privateConstructorUsedError;

  /// Create a copy of EntityListConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EntityListConfigCopyWith<EntityListConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntityListConfigCopyWith<$Res> {
  factory $EntityListConfigCopyWith(
          EntityListConfig value, $Res Function(EntityListConfig) then) =
      _$EntityListConfigCopyWithImpl<$Res, EntityListConfig>;
  @useResult
  $Res call(
      {NitBackendFilter<dynamic>? backendFilter,
      dynamic Function(ObjectWrapper)? customUpdatesListener});
}

/// @nodoc
class _$EntityListConfigCopyWithImpl<$Res, $Val extends EntityListConfig>
    implements $EntityListConfigCopyWith<$Res> {
  _$EntityListConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EntityListConfig
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
              as dynamic Function(ObjectWrapper)?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EntityListConfigImplCopyWith<$Res>
    implements $EntityListConfigCopyWith<$Res> {
  factory _$$EntityListConfigImplCopyWith(_$EntityListConfigImpl value,
          $Res Function(_$EntityListConfigImpl) then) =
      __$$EntityListConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {NitBackendFilter<dynamic>? backendFilter,
      dynamic Function(ObjectWrapper)? customUpdatesListener});
}

/// @nodoc
class __$$EntityListConfigImplCopyWithImpl<$Res>
    extends _$EntityListConfigCopyWithImpl<$Res, _$EntityListConfigImpl>
    implements _$$EntityListConfigImplCopyWith<$Res> {
  __$$EntityListConfigImplCopyWithImpl(_$EntityListConfigImpl _value,
      $Res Function(_$EntityListConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of EntityListConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backendFilter = freezed,
    Object? customUpdatesListener = freezed,
  }) {
    return _then(_$EntityListConfigImpl(
      backendFilter: freezed == backendFilter
          ? _value.backendFilter
          : backendFilter // ignore: cast_nullable_to_non_nullable
              as NitBackendFilter<dynamic>?,
      customUpdatesListener: freezed == customUpdatesListener
          ? _value.customUpdatesListener
          : customUpdatesListener // ignore: cast_nullable_to_non_nullable
              as dynamic Function(ObjectWrapper)?,
    ));
  }
}

/// @nodoc

class _$EntityListConfigImpl implements _EntityListConfig {
  const _$EntityListConfigImpl(
      {this.backendFilter, this.customUpdatesListener});

  @override
  final NitBackendFilter<dynamic>? backendFilter;
  @override
  final dynamic Function(ObjectWrapper)? customUpdatesListener;

  @override
  String toString() {
    return 'EntityListConfig(backendFilter: $backendFilter, customUpdatesListener: $customUpdatesListener)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntityListConfigImpl &&
            (identical(other.backendFilter, backendFilter) ||
                other.backendFilter == backendFilter) &&
            (identical(other.customUpdatesListener, customUpdatesListener) ||
                other.customUpdatesListener == customUpdatesListener));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, backendFilter, customUpdatesListener);

  /// Create a copy of EntityListConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EntityListConfigImplCopyWith<_$EntityListConfigImpl> get copyWith =>
      __$$EntityListConfigImplCopyWithImpl<_$EntityListConfigImpl>(
          this, _$identity);
}

abstract class _EntityListConfig implements EntityListConfig {
  const factory _EntityListConfig(
          {final NitBackendFilter<dynamic>? backendFilter,
          final dynamic Function(ObjectWrapper)? customUpdatesListener}) =
      _$EntityListConfigImpl;

  @override
  NitBackendFilter<dynamic>? get backendFilter;
  @override
  dynamic Function(ObjectWrapper)? get customUpdatesListener;

  /// Create a copy of EntityListConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EntityListConfigImplCopyWith<_$EntityListConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
