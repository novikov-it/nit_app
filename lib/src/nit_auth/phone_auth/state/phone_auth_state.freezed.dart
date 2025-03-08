// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone_auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PhoneAuthStateModel {
  bool get otpRequested => throw _privateConstructorUsedError;
  TextEditingController get phoneController =>
      throw _privateConstructorUsedError;
  TextEditingController get otpController => throw _privateConstructorUsedError;
  TextEditingController get userNameController =>
      throw _privateConstructorUsedError;
  int? get otpRequestTimer => throw _privateConstructorUsedError;

  /// Create a copy of PhoneAuthStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PhoneAuthStateModelCopyWith<PhoneAuthStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhoneAuthStateModelCopyWith<$Res> {
  factory $PhoneAuthStateModelCopyWith(
          PhoneAuthStateModel value, $Res Function(PhoneAuthStateModel) then) =
      _$PhoneAuthStateModelCopyWithImpl<$Res, PhoneAuthStateModel>;
  @useResult
  $Res call(
      {bool otpRequested,
      TextEditingController phoneController,
      TextEditingController otpController,
      TextEditingController userNameController,
      int? otpRequestTimer});
}

/// @nodoc
class _$PhoneAuthStateModelCopyWithImpl<$Res, $Val extends PhoneAuthStateModel>
    implements $PhoneAuthStateModelCopyWith<$Res> {
  _$PhoneAuthStateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PhoneAuthStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? otpRequested = null,
    Object? phoneController = null,
    Object? otpController = null,
    Object? userNameController = null,
    Object? otpRequestTimer = freezed,
  }) {
    return _then(_value.copyWith(
      otpRequested: null == otpRequested
          ? _value.otpRequested
          : otpRequested // ignore: cast_nullable_to_non_nullable
              as bool,
      phoneController: null == phoneController
          ? _value.phoneController
          : phoneController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      otpController: null == otpController
          ? _value.otpController
          : otpController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      userNameController: null == userNameController
          ? _value.userNameController
          : userNameController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      otpRequestTimer: freezed == otpRequestTimer
          ? _value.otpRequestTimer
          : otpRequestTimer // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PhoneAuthStateModelImplCopyWith<$Res>
    implements $PhoneAuthStateModelCopyWith<$Res> {
  factory _$$PhoneAuthStateModelImplCopyWith(_$PhoneAuthStateModelImpl value,
          $Res Function(_$PhoneAuthStateModelImpl) then) =
      __$$PhoneAuthStateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool otpRequested,
      TextEditingController phoneController,
      TextEditingController otpController,
      TextEditingController userNameController,
      int? otpRequestTimer});
}

/// @nodoc
class __$$PhoneAuthStateModelImplCopyWithImpl<$Res>
    extends _$PhoneAuthStateModelCopyWithImpl<$Res, _$PhoneAuthStateModelImpl>
    implements _$$PhoneAuthStateModelImplCopyWith<$Res> {
  __$$PhoneAuthStateModelImplCopyWithImpl(_$PhoneAuthStateModelImpl _value,
      $Res Function(_$PhoneAuthStateModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PhoneAuthStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? otpRequested = null,
    Object? phoneController = null,
    Object? otpController = null,
    Object? userNameController = null,
    Object? otpRequestTimer = freezed,
  }) {
    return _then(_$PhoneAuthStateModelImpl(
      otpRequested: null == otpRequested
          ? _value.otpRequested
          : otpRequested // ignore: cast_nullable_to_non_nullable
              as bool,
      phoneController: null == phoneController
          ? _value.phoneController
          : phoneController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      otpController: null == otpController
          ? _value.otpController
          : otpController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      userNameController: null == userNameController
          ? _value.userNameController
          : userNameController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      otpRequestTimer: freezed == otpRequestTimer
          ? _value.otpRequestTimer
          : otpRequestTimer // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$PhoneAuthStateModelImpl implements _PhoneAuthStateModel {
  const _$PhoneAuthStateModelImpl(
      {required this.otpRequested,
      required this.phoneController,
      required this.otpController,
      required this.userNameController,
      this.otpRequestTimer});

  @override
  final bool otpRequested;
  @override
  final TextEditingController phoneController;
  @override
  final TextEditingController otpController;
  @override
  final TextEditingController userNameController;
  @override
  final int? otpRequestTimer;

  @override
  String toString() {
    return 'PhoneAuthStateModel(otpRequested: $otpRequested, phoneController: $phoneController, otpController: $otpController, userNameController: $userNameController, otpRequestTimer: $otpRequestTimer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneAuthStateModelImpl &&
            (identical(other.otpRequested, otpRequested) ||
                other.otpRequested == otpRequested) &&
            (identical(other.phoneController, phoneController) ||
                other.phoneController == phoneController) &&
            (identical(other.otpController, otpController) ||
                other.otpController == otpController) &&
            (identical(other.userNameController, userNameController) ||
                other.userNameController == userNameController) &&
            (identical(other.otpRequestTimer, otpRequestTimer) ||
                other.otpRequestTimer == otpRequestTimer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, otpRequested, phoneController,
      otpController, userNameController, otpRequestTimer);

  /// Create a copy of PhoneAuthStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhoneAuthStateModelImplCopyWith<_$PhoneAuthStateModelImpl> get copyWith =>
      __$$PhoneAuthStateModelImplCopyWithImpl<_$PhoneAuthStateModelImpl>(
          this, _$identity);
}

abstract class _PhoneAuthStateModel implements PhoneAuthStateModel {
  const factory _PhoneAuthStateModel(
      {required final bool otpRequested,
      required final TextEditingController phoneController,
      required final TextEditingController otpController,
      required final TextEditingController userNameController,
      final int? otpRequestTimer}) = _$PhoneAuthStateModelImpl;

  @override
  bool get otpRequested;
  @override
  TextEditingController get phoneController;
  @override
  TextEditingController get otpController;
  @override
  TextEditingController get userNameController;
  @override
  int? get otpRequestTimer;

  /// Create a copy of PhoneAuthStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhoneAuthStateModelImplCopyWith<_$PhoneAuthStateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
