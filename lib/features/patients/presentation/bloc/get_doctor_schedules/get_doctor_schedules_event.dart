part of 'get_doctor_schedules_bloc.dart';

@freezed
class GetDoctorSchedulesEvent with _$GetDoctorSchedulesEvent {
  const factory GetDoctorSchedulesEvent.started() = _Started;
  const factory GetDoctorSchedulesEvent.getDoctorSchedules({
    required String doctorId,
  }) = _GetDoctorSchedules;
}
