part of 'patient_schedule_bloc.dart';

@freezed
class PatientScheduleEvent with _$PatientScheduleEvent {
  const factory PatientScheduleEvent.started() = _Started;
  const factory PatientScheduleEvent.getPatientSchedules() =
      _GetPatientSchedules;
  const factory PatientScheduleEvent.getPatientSchedulesByNIK(String nik) =
      _GetPatientSchedulesByNIK;
  const factory PatientScheduleEvent.getPatientQueue() = _GetPatientQueue;
}
