part of 'get_doctor_schedules_bloc.dart';

@freezed
class GetDoctorSchedulesEvent with _$GetDoctorSchedulesEvent {
  const factory GetDoctorSchedulesEvent.started() = _Started;
  const factory GetDoctorSchedulesEvent.getDoctorSchedules({
    required String doctorId,
    required String day,
  }) = _GetDoctorSchedules;
  const factory GetDoctorSchedulesEvent.getDoctorScheduleByDoctorId({
    required String doctorId,
  }) = _GetDoctorScheduleByDoctorId;
}
