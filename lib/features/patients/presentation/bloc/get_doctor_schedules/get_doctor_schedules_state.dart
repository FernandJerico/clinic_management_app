part of 'get_doctor_schedules_bloc.dart';

@freezed
class GetDoctorSchedulesState with _$GetDoctorSchedulesState {
  const factory GetDoctorSchedulesState.initial() = _Initial;
  const factory GetDoctorSchedulesState.loading() = _Loading;
  const factory GetDoctorSchedulesState.loaded(
      List<DoctorSchedule> doctorSchedules) = _Loaded;
  const factory GetDoctorSchedulesState.error(String message) = _Error;
}
