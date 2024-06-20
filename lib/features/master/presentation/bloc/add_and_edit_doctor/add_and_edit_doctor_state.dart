part of 'add_and_edit_doctor_bloc.dart';

@freezed
class AddAndEditDoctorState with _$AddAndEditDoctorState {
  const factory AddAndEditDoctorState.initial() = _Initial;
  const factory AddAndEditDoctorState.loading() = _Loading;
  const factory AddAndEditDoctorState.success() = _Success;
  const factory AddAndEditDoctorState.error(String message) = _Error;
}
