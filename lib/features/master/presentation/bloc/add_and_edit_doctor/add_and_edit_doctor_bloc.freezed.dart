// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_and_edit_doctor_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddAndEditDoctorEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(AddDoctorRequestModel doctor) addDoctor,
    required TResult Function(AddDoctorRequestModel doctor, String doctorId)
        editDoctor,
    required TResult Function(String doctorId) deleteDoctor,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(AddDoctorRequestModel doctor)? addDoctor,
    TResult? Function(AddDoctorRequestModel doctor, String doctorId)?
        editDoctor,
    TResult? Function(String doctorId)? deleteDoctor,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(AddDoctorRequestModel doctor)? addDoctor,
    TResult Function(AddDoctorRequestModel doctor, String doctorId)? editDoctor,
    TResult Function(String doctorId)? deleteDoctor,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_AddDoctor value) addDoctor,
    required TResult Function(_EditDoctor value) editDoctor,
    required TResult Function(_DeleteDoctor value) deleteDoctor,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_AddDoctor value)? addDoctor,
    TResult? Function(_EditDoctor value)? editDoctor,
    TResult? Function(_DeleteDoctor value)? deleteDoctor,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_AddDoctor value)? addDoctor,
    TResult Function(_EditDoctor value)? editDoctor,
    TResult Function(_DeleteDoctor value)? deleteDoctor,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddAndEditDoctorEventCopyWith<$Res> {
  factory $AddAndEditDoctorEventCopyWith(AddAndEditDoctorEvent value,
          $Res Function(AddAndEditDoctorEvent) then) =
      _$AddAndEditDoctorEventCopyWithImpl<$Res, AddAndEditDoctorEvent>;
}

/// @nodoc
class _$AddAndEditDoctorEventCopyWithImpl<$Res,
        $Val extends AddAndEditDoctorEvent>
    implements $AddAndEditDoctorEventCopyWith<$Res> {
  _$AddAndEditDoctorEventCopyWithImpl(this._value, this._then);

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
    extends _$AddAndEditDoctorEventCopyWithImpl<$Res, _$StartedImpl>
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
    return 'AddAndEditDoctorEvent.started()';
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
    required TResult Function(AddDoctorRequestModel doctor) addDoctor,
    required TResult Function(AddDoctorRequestModel doctor, String doctorId)
        editDoctor,
    required TResult Function(String doctorId) deleteDoctor,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(AddDoctorRequestModel doctor)? addDoctor,
    TResult? Function(AddDoctorRequestModel doctor, String doctorId)?
        editDoctor,
    TResult? Function(String doctorId)? deleteDoctor,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(AddDoctorRequestModel doctor)? addDoctor,
    TResult Function(AddDoctorRequestModel doctor, String doctorId)? editDoctor,
    TResult Function(String doctorId)? deleteDoctor,
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
    required TResult Function(_AddDoctor value) addDoctor,
    required TResult Function(_EditDoctor value) editDoctor,
    required TResult Function(_DeleteDoctor value) deleteDoctor,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_AddDoctor value)? addDoctor,
    TResult? Function(_EditDoctor value)? editDoctor,
    TResult? Function(_DeleteDoctor value)? deleteDoctor,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_AddDoctor value)? addDoctor,
    TResult Function(_EditDoctor value)? editDoctor,
    TResult Function(_DeleteDoctor value)? deleteDoctor,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements AddAndEditDoctorEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$AddDoctorImplCopyWith<$Res> {
  factory _$$AddDoctorImplCopyWith(
          _$AddDoctorImpl value, $Res Function(_$AddDoctorImpl) then) =
      __$$AddDoctorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AddDoctorRequestModel doctor});
}

/// @nodoc
class __$$AddDoctorImplCopyWithImpl<$Res>
    extends _$AddAndEditDoctorEventCopyWithImpl<$Res, _$AddDoctorImpl>
    implements _$$AddDoctorImplCopyWith<$Res> {
  __$$AddDoctorImplCopyWithImpl(
      _$AddDoctorImpl _value, $Res Function(_$AddDoctorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doctor = null,
  }) {
    return _then(_$AddDoctorImpl(
      doctor: null == doctor
          ? _value.doctor
          : doctor // ignore: cast_nullable_to_non_nullable
              as AddDoctorRequestModel,
    ));
  }
}

/// @nodoc

class _$AddDoctorImpl implements _AddDoctor {
  const _$AddDoctorImpl({required this.doctor});

  @override
  final AddDoctorRequestModel doctor;

  @override
  String toString() {
    return 'AddAndEditDoctorEvent.addDoctor(doctor: $doctor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddDoctorImpl &&
            (identical(other.doctor, doctor) || other.doctor == doctor));
  }

  @override
  int get hashCode => Object.hash(runtimeType, doctor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddDoctorImplCopyWith<_$AddDoctorImpl> get copyWith =>
      __$$AddDoctorImplCopyWithImpl<_$AddDoctorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(AddDoctorRequestModel doctor) addDoctor,
    required TResult Function(AddDoctorRequestModel doctor, String doctorId)
        editDoctor,
    required TResult Function(String doctorId) deleteDoctor,
  }) {
    return addDoctor(doctor);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(AddDoctorRequestModel doctor)? addDoctor,
    TResult? Function(AddDoctorRequestModel doctor, String doctorId)?
        editDoctor,
    TResult? Function(String doctorId)? deleteDoctor,
  }) {
    return addDoctor?.call(doctor);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(AddDoctorRequestModel doctor)? addDoctor,
    TResult Function(AddDoctorRequestModel doctor, String doctorId)? editDoctor,
    TResult Function(String doctorId)? deleteDoctor,
    required TResult orElse(),
  }) {
    if (addDoctor != null) {
      return addDoctor(doctor);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_AddDoctor value) addDoctor,
    required TResult Function(_EditDoctor value) editDoctor,
    required TResult Function(_DeleteDoctor value) deleteDoctor,
  }) {
    return addDoctor(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_AddDoctor value)? addDoctor,
    TResult? Function(_EditDoctor value)? editDoctor,
    TResult? Function(_DeleteDoctor value)? deleteDoctor,
  }) {
    return addDoctor?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_AddDoctor value)? addDoctor,
    TResult Function(_EditDoctor value)? editDoctor,
    TResult Function(_DeleteDoctor value)? deleteDoctor,
    required TResult orElse(),
  }) {
    if (addDoctor != null) {
      return addDoctor(this);
    }
    return orElse();
  }
}

abstract class _AddDoctor implements AddAndEditDoctorEvent {
  const factory _AddDoctor({required final AddDoctorRequestModel doctor}) =
      _$AddDoctorImpl;

  AddDoctorRequestModel get doctor;
  @JsonKey(ignore: true)
  _$$AddDoctorImplCopyWith<_$AddDoctorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EditDoctorImplCopyWith<$Res> {
  factory _$$EditDoctorImplCopyWith(
          _$EditDoctorImpl value, $Res Function(_$EditDoctorImpl) then) =
      __$$EditDoctorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AddDoctorRequestModel doctor, String doctorId});
}

/// @nodoc
class __$$EditDoctorImplCopyWithImpl<$Res>
    extends _$AddAndEditDoctorEventCopyWithImpl<$Res, _$EditDoctorImpl>
    implements _$$EditDoctorImplCopyWith<$Res> {
  __$$EditDoctorImplCopyWithImpl(
      _$EditDoctorImpl _value, $Res Function(_$EditDoctorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doctor = null,
    Object? doctorId = null,
  }) {
    return _then(_$EditDoctorImpl(
      doctor: null == doctor
          ? _value.doctor
          : doctor // ignore: cast_nullable_to_non_nullable
              as AddDoctorRequestModel,
      doctorId: null == doctorId
          ? _value.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EditDoctorImpl implements _EditDoctor {
  const _$EditDoctorImpl({required this.doctor, required this.doctorId});

  @override
  final AddDoctorRequestModel doctor;
  @override
  final String doctorId;

  @override
  String toString() {
    return 'AddAndEditDoctorEvent.editDoctor(doctor: $doctor, doctorId: $doctorId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditDoctorImpl &&
            (identical(other.doctor, doctor) || other.doctor == doctor) &&
            (identical(other.doctorId, doctorId) ||
                other.doctorId == doctorId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, doctor, doctorId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditDoctorImplCopyWith<_$EditDoctorImpl> get copyWith =>
      __$$EditDoctorImplCopyWithImpl<_$EditDoctorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(AddDoctorRequestModel doctor) addDoctor,
    required TResult Function(AddDoctorRequestModel doctor, String doctorId)
        editDoctor,
    required TResult Function(String doctorId) deleteDoctor,
  }) {
    return editDoctor(doctor, doctorId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(AddDoctorRequestModel doctor)? addDoctor,
    TResult? Function(AddDoctorRequestModel doctor, String doctorId)?
        editDoctor,
    TResult? Function(String doctorId)? deleteDoctor,
  }) {
    return editDoctor?.call(doctor, doctorId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(AddDoctorRequestModel doctor)? addDoctor,
    TResult Function(AddDoctorRequestModel doctor, String doctorId)? editDoctor,
    TResult Function(String doctorId)? deleteDoctor,
    required TResult orElse(),
  }) {
    if (editDoctor != null) {
      return editDoctor(doctor, doctorId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_AddDoctor value) addDoctor,
    required TResult Function(_EditDoctor value) editDoctor,
    required TResult Function(_DeleteDoctor value) deleteDoctor,
  }) {
    return editDoctor(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_AddDoctor value)? addDoctor,
    TResult? Function(_EditDoctor value)? editDoctor,
    TResult? Function(_DeleteDoctor value)? deleteDoctor,
  }) {
    return editDoctor?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_AddDoctor value)? addDoctor,
    TResult Function(_EditDoctor value)? editDoctor,
    TResult Function(_DeleteDoctor value)? deleteDoctor,
    required TResult orElse(),
  }) {
    if (editDoctor != null) {
      return editDoctor(this);
    }
    return orElse();
  }
}

abstract class _EditDoctor implements AddAndEditDoctorEvent {
  const factory _EditDoctor(
      {required final AddDoctorRequestModel doctor,
      required final String doctorId}) = _$EditDoctorImpl;

  AddDoctorRequestModel get doctor;
  String get doctorId;
  @JsonKey(ignore: true)
  _$$EditDoctorImplCopyWith<_$EditDoctorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteDoctorImplCopyWith<$Res> {
  factory _$$DeleteDoctorImplCopyWith(
          _$DeleteDoctorImpl value, $Res Function(_$DeleteDoctorImpl) then) =
      __$$DeleteDoctorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String doctorId});
}

/// @nodoc
class __$$DeleteDoctorImplCopyWithImpl<$Res>
    extends _$AddAndEditDoctorEventCopyWithImpl<$Res, _$DeleteDoctorImpl>
    implements _$$DeleteDoctorImplCopyWith<$Res> {
  __$$DeleteDoctorImplCopyWithImpl(
      _$DeleteDoctorImpl _value, $Res Function(_$DeleteDoctorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doctorId = null,
  }) {
    return _then(_$DeleteDoctorImpl(
      doctorId: null == doctorId
          ? _value.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeleteDoctorImpl implements _DeleteDoctor {
  const _$DeleteDoctorImpl({required this.doctorId});

  @override
  final String doctorId;

  @override
  String toString() {
    return 'AddAndEditDoctorEvent.deleteDoctor(doctorId: $doctorId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteDoctorImpl &&
            (identical(other.doctorId, doctorId) ||
                other.doctorId == doctorId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, doctorId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteDoctorImplCopyWith<_$DeleteDoctorImpl> get copyWith =>
      __$$DeleteDoctorImplCopyWithImpl<_$DeleteDoctorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(AddDoctorRequestModel doctor) addDoctor,
    required TResult Function(AddDoctorRequestModel doctor, String doctorId)
        editDoctor,
    required TResult Function(String doctorId) deleteDoctor,
  }) {
    return deleteDoctor(doctorId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(AddDoctorRequestModel doctor)? addDoctor,
    TResult? Function(AddDoctorRequestModel doctor, String doctorId)?
        editDoctor,
    TResult? Function(String doctorId)? deleteDoctor,
  }) {
    return deleteDoctor?.call(doctorId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(AddDoctorRequestModel doctor)? addDoctor,
    TResult Function(AddDoctorRequestModel doctor, String doctorId)? editDoctor,
    TResult Function(String doctorId)? deleteDoctor,
    required TResult orElse(),
  }) {
    if (deleteDoctor != null) {
      return deleteDoctor(doctorId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_AddDoctor value) addDoctor,
    required TResult Function(_EditDoctor value) editDoctor,
    required TResult Function(_DeleteDoctor value) deleteDoctor,
  }) {
    return deleteDoctor(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_AddDoctor value)? addDoctor,
    TResult? Function(_EditDoctor value)? editDoctor,
    TResult? Function(_DeleteDoctor value)? deleteDoctor,
  }) {
    return deleteDoctor?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_AddDoctor value)? addDoctor,
    TResult Function(_EditDoctor value)? editDoctor,
    TResult Function(_DeleteDoctor value)? deleteDoctor,
    required TResult orElse(),
  }) {
    if (deleteDoctor != null) {
      return deleteDoctor(this);
    }
    return orElse();
  }
}

abstract class _DeleteDoctor implements AddAndEditDoctorEvent {
  const factory _DeleteDoctor({required final String doctorId}) =
      _$DeleteDoctorImpl;

  String get doctorId;
  @JsonKey(ignore: true)
  _$$DeleteDoctorImplCopyWith<_$DeleteDoctorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AddAndEditDoctorState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddAndEditDoctorStateCopyWith<$Res> {
  factory $AddAndEditDoctorStateCopyWith(AddAndEditDoctorState value,
          $Res Function(AddAndEditDoctorState) then) =
      _$AddAndEditDoctorStateCopyWithImpl<$Res, AddAndEditDoctorState>;
}

/// @nodoc
class _$AddAndEditDoctorStateCopyWithImpl<$Res,
        $Val extends AddAndEditDoctorState>
    implements $AddAndEditDoctorStateCopyWith<$Res> {
  _$AddAndEditDoctorStateCopyWithImpl(this._value, this._then);

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
    extends _$AddAndEditDoctorStateCopyWithImpl<$Res, _$InitialImpl>
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
    return 'AddAndEditDoctorState.initial()';
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
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(String message)? error,
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
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AddAndEditDoctorState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$AddAndEditDoctorStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'AddAndEditDoctorState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements AddAndEditDoctorState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$AddAndEditDoctorStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl();

  @override
  String toString() {
    return 'AddAndEditDoctorState.success()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String message) error,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String message)? error,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements AddAndEditDoctorState {
  const factory _Success() = _$SuccessImpl;
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
    extends _$AddAndEditDoctorStateCopyWithImpl<$Res, _$ErrorImpl>
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
    return 'AddAndEditDoctorState.error(message: $message)';
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
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(String message)? error,
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
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements AddAndEditDoctorState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
