// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nit_chat_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NitChatViewStateModel {
  ChatController get controller => throw _privateConstructorUsedError;
  ChatViewState get viewState => throw _privateConstructorUsedError;

  /// Create a copy of NitChatViewStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NitChatViewStateModelCopyWith<NitChatViewStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NitChatViewStateModelCopyWith<$Res> {
  factory $NitChatViewStateModelCopyWith(NitChatViewStateModel value,
          $Res Function(NitChatViewStateModel) then) =
      _$NitChatViewStateModelCopyWithImpl<$Res, NitChatViewStateModel>;
  @useResult
  $Res call({ChatController controller, ChatViewState viewState});
}

/// @nodoc
class _$NitChatViewStateModelCopyWithImpl<$Res,
        $Val extends NitChatViewStateModel>
    implements $NitChatViewStateModelCopyWith<$Res> {
  _$NitChatViewStateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NitChatViewStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? controller = null,
    Object? viewState = null,
  }) {
    return _then(_value.copyWith(
      controller: null == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as ChatController,
      viewState: null == viewState
          ? _value.viewState
          : viewState // ignore: cast_nullable_to_non_nullable
              as ChatViewState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NitChatViewStateModelImplCopyWith<$Res>
    implements $NitChatViewStateModelCopyWith<$Res> {
  factory _$$NitChatViewStateModelImplCopyWith(
          _$NitChatViewStateModelImpl value,
          $Res Function(_$NitChatViewStateModelImpl) then) =
      __$$NitChatViewStateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ChatController controller, ChatViewState viewState});
}

/// @nodoc
class __$$NitChatViewStateModelImplCopyWithImpl<$Res>
    extends _$NitChatViewStateModelCopyWithImpl<$Res,
        _$NitChatViewStateModelImpl>
    implements _$$NitChatViewStateModelImplCopyWith<$Res> {
  __$$NitChatViewStateModelImplCopyWithImpl(_$NitChatViewStateModelImpl _value,
      $Res Function(_$NitChatViewStateModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of NitChatViewStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? controller = null,
    Object? viewState = null,
  }) {
    return _then(_$NitChatViewStateModelImpl(
      controller: null == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as ChatController,
      viewState: null == viewState
          ? _value.viewState
          : viewState // ignore: cast_nullable_to_non_nullable
              as ChatViewState,
    ));
  }
}

/// @nodoc

class _$NitChatViewStateModelImpl implements _NitChatViewStateModel {
  const _$NitChatViewStateModelImpl(
      {required this.controller, required this.viewState});

  @override
  final ChatController controller;
  @override
  final ChatViewState viewState;

  @override
  String toString() {
    return 'NitChatViewStateModel(controller: $controller, viewState: $viewState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NitChatViewStateModelImpl &&
            (identical(other.controller, controller) ||
                other.controller == controller) &&
            (identical(other.viewState, viewState) ||
                other.viewState == viewState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, controller, viewState);

  /// Create a copy of NitChatViewStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NitChatViewStateModelImplCopyWith<_$NitChatViewStateModelImpl>
      get copyWith => __$$NitChatViewStateModelImplCopyWithImpl<
          _$NitChatViewStateModelImpl>(this, _$identity);
}

abstract class _NitChatViewStateModel implements NitChatViewStateModel {
  const factory _NitChatViewStateModel(
      {required final ChatController controller,
      required final ChatViewState viewState}) = _$NitChatViewStateModelImpl;

  @override
  ChatController get controller;
  @override
  ChatViewState get viewState;

  /// Create a copy of NitChatViewStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NitChatViewStateModelImplCopyWith<_$NitChatViewStateModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
