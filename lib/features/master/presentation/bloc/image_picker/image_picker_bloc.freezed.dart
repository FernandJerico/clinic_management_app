// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_picker_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ImagePickerEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() pickImage,
    required TResult Function() clearImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? pickImage,
    TResult? Function()? clearImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? pickImage,
    TResult Function()? clearImage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_PickImage value) pickImage,
    required TResult Function(_ClearImage value) clearImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_PickImage value)? pickImage,
    TResult? Function(_ClearImage value)? clearImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_PickImage value)? pickImage,
    TResult Function(_ClearImage value)? clearImage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImagePickerEventCopyWith<$Res> {
  factory $ImagePickerEventCopyWith(
          ImagePickerEvent value, $Res Function(ImagePickerEvent) then) =
      _$ImagePickerEventCopyWithImpl<$Res, ImagePickerEvent>;
}

/// @nodoc
class _$ImagePickerEventCopyWithImpl<$Res, $Val extends ImagePickerEvent>
    implements $ImagePickerEventCopyWith<$Res> {
  _$ImagePickerEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
          _$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$ImagePickerEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'ImagePickerEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() pickImage,
    required TResult Function() clearImage,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? pickImage,
    TResult? Function()? clearImage,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? pickImage,
    TResult Function()? clearImage,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_PickImage value) pickImage,
    required TResult Function(_ClearImage value) clearImage,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_PickImage value)? pickImage,
    TResult? Function(_ClearImage value)? clearImage,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_PickImage value)? pickImage,
    TResult Function(_ClearImage value)? clearImage,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements ImagePickerEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$PickImageImplCopyWith<$Res> {
  factory _$$PickImageImplCopyWith(
          _$PickImageImpl value, $Res Function(_$PickImageImpl) then) =
      __$$PickImageImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PickImageImplCopyWithImpl<$Res>
    extends _$ImagePickerEventCopyWithImpl<$Res, _$PickImageImpl>
    implements _$$PickImageImplCopyWith<$Res> {
  __$$PickImageImplCopyWithImpl(
      _$PickImageImpl _value, $Res Function(_$PickImageImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PickImageImpl implements _PickImage {
  const _$PickImageImpl();

  @override
  String toString() {
    return 'ImagePickerEvent.pickImage()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PickImageImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() pickImage,
    required TResult Function() clearImage,
  }) {
    return pickImage();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? pickImage,
    TResult? Function()? clearImage,
  }) {
    return pickImage?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? pickImage,
    TResult Function()? clearImage,
    required TResult orElse(),
  }) {
    if (pickImage != null) {
      return pickImage();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_PickImage value) pickImage,
    required TResult Function(_ClearImage value) clearImage,
  }) {
    return pickImage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_PickImage value)? pickImage,
    TResult? Function(_ClearImage value)? clearImage,
  }) {
    return pickImage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_PickImage value)? pickImage,
    TResult Function(_ClearImage value)? clearImage,
    required TResult orElse(),
  }) {
    if (pickImage != null) {
      return pickImage(this);
    }
    return orElse();
  }
}

abstract class _PickImage implements ImagePickerEvent {
  const factory _PickImage() = _$PickImageImpl;
}

/// @nodoc
abstract class _$$ClearImageImplCopyWith<$Res> {
  factory _$$ClearImageImplCopyWith(
          _$ClearImageImpl value, $Res Function(_$ClearImageImpl) then) =
      __$$ClearImageImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearImageImplCopyWithImpl<$Res>
    extends _$ImagePickerEventCopyWithImpl<$Res, _$ClearImageImpl>
    implements _$$ClearImageImplCopyWith<$Res> {
  __$$ClearImageImplCopyWithImpl(
      _$ClearImageImpl _value, $Res Function(_$ClearImageImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ClearImageImpl implements _ClearImage {
  const _$ClearImageImpl();

  @override
  String toString() {
    return 'ImagePickerEvent.clearImage()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearImageImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() pickImage,
    required TResult Function() clearImage,
  }) {
    return clearImage();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? pickImage,
    TResult? Function()? clearImage,
  }) {
    return clearImage?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? pickImage,
    TResult Function()? clearImage,
    required TResult orElse(),
  }) {
    if (clearImage != null) {
      return clearImage();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_PickImage value) pickImage,
    required TResult Function(_ClearImage value) clearImage,
  }) {
    return clearImage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_PickImage value)? pickImage,
    TResult? Function(_ClearImage value)? clearImage,
  }) {
    return clearImage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_PickImage value)? pickImage,
    TResult Function(_ClearImage value)? clearImage,
    required TResult orElse(),
  }) {
    if (clearImage != null) {
      return clearImage(this);
    }
    return orElse();
  }
}

abstract class _ClearImage implements ImagePickerEvent {
  const factory _ClearImage() = _$ClearImageImpl;
}

/// @nodoc
mixin _$ImagePickerState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() picking,
    required TResult Function(File image) picked,
    required TResult Function(String message) error,
    required TResult Function() cleared,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? picking,
    TResult? Function(File image)? picked,
    TResult? Function(String message)? error,
    TResult? Function()? cleared,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? picking,
    TResult Function(File image)? picked,
    TResult Function(String message)? error,
    TResult Function()? cleared,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Picking value) picking,
    required TResult Function(_Picked value) picked,
    required TResult Function(_Error value) error,
    required TResult Function(_Cleared value) cleared,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Picking value)? picking,
    TResult? Function(_Picked value)? picked,
    TResult? Function(_Error value)? error,
    TResult? Function(_Cleared value)? cleared,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Picking value)? picking,
    TResult Function(_Picked value)? picked,
    TResult Function(_Error value)? error,
    TResult Function(_Cleared value)? cleared,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImagePickerStateCopyWith<$Res> {
  factory $ImagePickerStateCopyWith(
          ImagePickerState value, $Res Function(ImagePickerState) then) =
      _$ImagePickerStateCopyWithImpl<$Res, ImagePickerState>;
}

/// @nodoc
class _$ImagePickerStateCopyWithImpl<$Res, $Val extends ImagePickerState>
    implements $ImagePickerStateCopyWith<$Res> {
  _$ImagePickerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$ImagePickerStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'ImagePickerState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() picking,
    required TResult Function(File image) picked,
    required TResult Function(String message) error,
    required TResult Function() cleared,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? picking,
    TResult? Function(File image)? picked,
    TResult? Function(String message)? error,
    TResult? Function()? cleared,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? picking,
    TResult Function(File image)? picked,
    TResult Function(String message)? error,
    TResult Function()? cleared,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Picking value) picking,
    required TResult Function(_Picked value) picked,
    required TResult Function(_Error value) error,
    required TResult Function(_Cleared value) cleared,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Picking value)? picking,
    TResult? Function(_Picked value)? picked,
    TResult? Function(_Error value)? error,
    TResult? Function(_Cleared value)? cleared,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Picking value)? picking,
    TResult Function(_Picked value)? picked,
    TResult Function(_Error value)? error,
    TResult Function(_Cleared value)? cleared,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ImagePickerState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$PickingImplCopyWith<$Res> {
  factory _$$PickingImplCopyWith(
          _$PickingImpl value, $Res Function(_$PickingImpl) then) =
      __$$PickingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PickingImplCopyWithImpl<$Res>
    extends _$ImagePickerStateCopyWithImpl<$Res, _$PickingImpl>
    implements _$$PickingImplCopyWith<$Res> {
  __$$PickingImplCopyWithImpl(
      _$PickingImpl _value, $Res Function(_$PickingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PickingImpl implements _Picking {
  const _$PickingImpl();

  @override
  String toString() {
    return 'ImagePickerState.picking()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PickingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() picking,
    required TResult Function(File image) picked,
    required TResult Function(String message) error,
    required TResult Function() cleared,
  }) {
    return picking();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? picking,
    TResult? Function(File image)? picked,
    TResult? Function(String message)? error,
    TResult? Function()? cleared,
  }) {
    return picking?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? picking,
    TResult Function(File image)? picked,
    TResult Function(String message)? error,
    TResult Function()? cleared,
    required TResult orElse(),
  }) {
    if (picking != null) {
      return picking();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Picking value) picking,
    required TResult Function(_Picked value) picked,
    required TResult Function(_Error value) error,
    required TResult Function(_Cleared value) cleared,
  }) {
    return picking(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Picking value)? picking,
    TResult? Function(_Picked value)? picked,
    TResult? Function(_Error value)? error,
    TResult? Function(_Cleared value)? cleared,
  }) {
    return picking?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Picking value)? picking,
    TResult Function(_Picked value)? picked,
    TResult Function(_Error value)? error,
    TResult Function(_Cleared value)? cleared,
    required TResult orElse(),
  }) {
    if (picking != null) {
      return picking(this);
    }
    return orElse();
  }
}

abstract class _Picking implements ImagePickerState {
  const factory _Picking() = _$PickingImpl;
}

/// @nodoc
abstract class _$$PickedImplCopyWith<$Res> {
  factory _$$PickedImplCopyWith(
          _$PickedImpl value, $Res Function(_$PickedImpl) then) =
      __$$PickedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({File image});
}

/// @nodoc
class __$$PickedImplCopyWithImpl<$Res>
    extends _$ImagePickerStateCopyWithImpl<$Res, _$PickedImpl>
    implements _$$PickedImplCopyWith<$Res> {
  __$$PickedImplCopyWithImpl(
      _$PickedImpl _value, $Res Function(_$PickedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
  }) {
    return _then(_$PickedImpl(
      null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File,
    ));
  }
}

/// @nodoc

class _$PickedImpl implements _Picked {
  const _$PickedImpl(this.image);

  @override
  final File image;

  @override
  String toString() {
    return 'ImagePickerState.picked(image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PickedImpl &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PickedImplCopyWith<_$PickedImpl> get copyWith =>
      __$$PickedImplCopyWithImpl<_$PickedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() picking,
    required TResult Function(File image) picked,
    required TResult Function(String message) error,
    required TResult Function() cleared,
  }) {
    return picked(image);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? picking,
    TResult? Function(File image)? picked,
    TResult? Function(String message)? error,
    TResult? Function()? cleared,
  }) {
    return picked?.call(image);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? picking,
    TResult Function(File image)? picked,
    TResult Function(String message)? error,
    TResult Function()? cleared,
    required TResult orElse(),
  }) {
    if (picked != null) {
      return picked(image);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Picking value) picking,
    required TResult Function(_Picked value) picked,
    required TResult Function(_Error value) error,
    required TResult Function(_Cleared value) cleared,
  }) {
    return picked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Picking value)? picking,
    TResult? Function(_Picked value)? picked,
    TResult? Function(_Error value)? error,
    TResult? Function(_Cleared value)? cleared,
  }) {
    return picked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Picking value)? picking,
    TResult Function(_Picked value)? picked,
    TResult Function(_Error value)? error,
    TResult Function(_Cleared value)? cleared,
    required TResult orElse(),
  }) {
    if (picked != null) {
      return picked(this);
    }
    return orElse();
  }
}

abstract class _Picked implements ImagePickerState {
  const factory _Picked(final File image) = _$PickedImpl;

  File get image;
  @JsonKey(ignore: true)
  _$$PickedImplCopyWith<_$PickedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$ImagePickerStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ImagePickerState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() picking,
    required TResult Function(File image) picked,
    required TResult Function(String message) error,
    required TResult Function() cleared,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? picking,
    TResult? Function(File image)? picked,
    TResult? Function(String message)? error,
    TResult? Function()? cleared,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? picking,
    TResult Function(File image)? picked,
    TResult Function(String message)? error,
    TResult Function()? cleared,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Picking value) picking,
    required TResult Function(_Picked value) picked,
    required TResult Function(_Error value) error,
    required TResult Function(_Cleared value) cleared,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Picking value)? picking,
    TResult? Function(_Picked value)? picked,
    TResult? Function(_Error value)? error,
    TResult? Function(_Cleared value)? cleared,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Picking value)? picking,
    TResult Function(_Picked value)? picked,
    TResult Function(_Error value)? error,
    TResult Function(_Cleared value)? cleared,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements ImagePickerState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearedImplCopyWith<$Res> {
  factory _$$ClearedImplCopyWith(
          _$ClearedImpl value, $Res Function(_$ClearedImpl) then) =
      __$$ClearedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearedImplCopyWithImpl<$Res>
    extends _$ImagePickerStateCopyWithImpl<$Res, _$ClearedImpl>
    implements _$$ClearedImplCopyWith<$Res> {
  __$$ClearedImplCopyWithImpl(
      _$ClearedImpl _value, $Res Function(_$ClearedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ClearedImpl implements _Cleared {
  const _$ClearedImpl();

  @override
  String toString() {
    return 'ImagePickerState.cleared()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() picking,
    required TResult Function(File image) picked,
    required TResult Function(String message) error,
    required TResult Function() cleared,
  }) {
    return cleared();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? picking,
    TResult? Function(File image)? picked,
    TResult? Function(String message)? error,
    TResult? Function()? cleared,
  }) {
    return cleared?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? picking,
    TResult Function(File image)? picked,
    TResult Function(String message)? error,
    TResult Function()? cleared,
    required TResult orElse(),
  }) {
    if (cleared != null) {
      return cleared();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Picking value) picking,
    required TResult Function(_Picked value) picked,
    required TResult Function(_Error value) error,
    required TResult Function(_Cleared value) cleared,
  }) {
    return cleared(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Picking value)? picking,
    TResult? Function(_Picked value)? picked,
    TResult? Function(_Error value)? error,
    TResult? Function(_Cleared value)? cleared,
  }) {
    return cleared?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Picking value)? picking,
    TResult Function(_Picked value)? picked,
    TResult Function(_Error value)? error,
    TResult Function(_Cleared value)? cleared,
    required TResult orElse(),
  }) {
    if (cleared != null) {
      return cleared(this);
    }
    return orElse();
  }
}

abstract class _Cleared implements ImagePickerState {
  const factory _Cleared() = _$ClearedImpl;
}
