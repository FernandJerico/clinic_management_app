part of 'add_and_edit_doctor_bloc.dart';

@freezed
class AddAndEditDoctorEvent with _$AddAndEditDoctorEvent {
  const factory AddAndEditDoctorEvent.started() = _Started;
  const factory AddAndEditDoctorEvent.addDoctor({
    required AddDoctorRequestModel doctor,
  }) = _AddDoctor;
  const factory AddAndEditDoctorEvent.editDoctor({
    required AddDoctorRequestModel doctor,
    required String doctorId,
  }) = _EditDoctor;
  const factory AddAndEditDoctorEvent.deleteDoctor({
    required String doctorId,
  }) = _DeleteDoctor;
}
