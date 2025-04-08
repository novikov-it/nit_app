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
  List<NitBackendFilter>? get backendFilters =>
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
      {List<NitBackendFilter>? backendFilters,
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
    Object? backendFilters = freezed,
    Object? customUpdatesListener = freezed,
  }) {
    return _then(_value.copyWith(
      backendFilters: freezed == backendFilters
          ? _value.backendFilters
          : backendFilters // ignore: cast_nullable_to_non_nullable
              as List<NitBackendFilter>?,
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
      {List<NitBackendFilter>? backendFilters,
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
    Object? backendFilters = freezed,
    Object? customUpdatesListener = freezed,
  }) {
    return _then(_$EntityListConfigImpl(
      backendFilters: freezed == backendFilters
          ? _value._backendFilters
          : backendFilters // ignore: cast_nullable_to_non_nullable
              as List<NitBackendFilter>?,
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
      {final List<NitBackendFilter>? backendFilters,
      this.customUpdatesListener})
      : _backendFilters = backendFilters;

  final List<NitBackendFilter>? _backendFilters;
  @override
  List<NitBackendFilter>? get backendFilters {
    final value = _backendFilters;
    if (value == null) return null;
    if (_backendFilters is EqualUnmodifiableListView) return _backendFilters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final dynamic Function(ObjectWrapper)? customUpdatesListener;

  @override
  String toString() {
    return 'EntityListConfig(backendFilters: $backendFilters, customUpdatesListener: $customUpdatesListener)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntityListConfigImpl &&
            const DeepCollectionEquality()
                .equals(other._backendFilters, _backendFilters) &&
            (identical(other.customUpdatesListener, customUpdatesListener) ||
                other.customUpdatesListener == customUpdatesListener));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_backendFilters),
      customUpdatesListener);

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
          {final List<NitBackendFilter>? backendFilters,
          final dynamic Function(ObjectWrapper)? customUpdatesListener}) =
      _$EntityListConfigImpl;

  @override
  List<NitBackendFilter>? get backendFilters;
  @override
  dynamic Function(ObjectWrapper)? get customUpdatesListener;

  /// Create a copy of EntityListConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EntityListConfigImplCopyWith<_$EntityListConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
