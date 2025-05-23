// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'single_item_custom_provider_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SingleItemCustomProviderConfig {
  NitBackendFilter<dynamic> get backendFilter =>
      throw _privateConstructorUsedError;

  /// Create a copy of SingleItemCustomProviderConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SingleItemCustomProviderConfigCopyWith<SingleItemCustomProviderConfig>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SingleItemCustomProviderConfigCopyWith<$Res> {
  factory $SingleItemCustomProviderConfigCopyWith(
          SingleItemCustomProviderConfig value,
          $Res Function(SingleItemCustomProviderConfig) then) =
      _$SingleItemCustomProviderConfigCopyWithImpl<$Res,
          SingleItemCustomProviderConfig>;
  @useResult
  $Res call({NitBackendFilter<dynamic> backendFilter});
}

/// @nodoc
class _$SingleItemCustomProviderConfigCopyWithImpl<$Res,
        $Val extends SingleItemCustomProviderConfig>
    implements $SingleItemCustomProviderConfigCopyWith<$Res> {
  _$SingleItemCustomProviderConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SingleItemCustomProviderConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backendFilter = null,
  }) {
    return _then(_value.copyWith(
      backendFilter: null == backendFilter
          ? _value.backendFilter
          : backendFilter // ignore: cast_nullable_to_non_nullable
              as NitBackendFilter<dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SingleItemCustomProviderConfigImplCopyWith<$Res>
    implements $SingleItemCustomProviderConfigCopyWith<$Res> {
  factory _$$SingleItemCustomProviderConfigImplCopyWith(
          _$SingleItemCustomProviderConfigImpl value,
          $Res Function(_$SingleItemCustomProviderConfigImpl) then) =
      __$$SingleItemCustomProviderConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({NitBackendFilter<dynamic> backendFilter});
}

/// @nodoc
class __$$SingleItemCustomProviderConfigImplCopyWithImpl<$Res>
    extends _$SingleItemCustomProviderConfigCopyWithImpl<$Res,
        _$SingleItemCustomProviderConfigImpl>
    implements _$$SingleItemCustomProviderConfigImplCopyWith<$Res> {
  __$$SingleItemCustomProviderConfigImplCopyWithImpl(
      _$SingleItemCustomProviderConfigImpl _value,
      $Res Function(_$SingleItemCustomProviderConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of SingleItemCustomProviderConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backendFilter = null,
  }) {
    return _then(_$SingleItemCustomProviderConfigImpl(
      backendFilter: null == backendFilter
          ? _value.backendFilter
          : backendFilter // ignore: cast_nullable_to_non_nullable
              as NitBackendFilter<dynamic>,
    ));
  }
}

/// @nodoc

class _$SingleItemCustomProviderConfigImpl
    implements _SingleItemCustomProviderConfig {
  const _$SingleItemCustomProviderConfigImpl({required this.backendFilter});

  @override
  final NitBackendFilter<dynamic> backendFilter;

  @override
  String toString() {
    return 'SingleItemCustomProviderConfig(backendFilter: $backendFilter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SingleItemCustomProviderConfigImpl &&
            (identical(other.backendFilter, backendFilter) ||
                other.backendFilter == backendFilter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, backendFilter);

  /// Create a copy of SingleItemCustomProviderConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SingleItemCustomProviderConfigImplCopyWith<
          _$SingleItemCustomProviderConfigImpl>
      get copyWith => __$$SingleItemCustomProviderConfigImplCopyWithImpl<
          _$SingleItemCustomProviderConfigImpl>(this, _$identity);
}

abstract class _SingleItemCustomProviderConfig
    implements SingleItemCustomProviderConfig {
  const factory _SingleItemCustomProviderConfig(
          {required final NitBackendFilter<dynamic> backendFilter}) =
      _$SingleItemCustomProviderConfigImpl;

  @override
  NitBackendFilter<dynamic> get backendFilter;

  /// Create a copy of SingleItemCustomProviderConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SingleItemCustomProviderConfigImplCopyWith<
          _$SingleItemCustomProviderConfigImpl>
      get copyWith => throw _privateConstructorUsedError;
}
