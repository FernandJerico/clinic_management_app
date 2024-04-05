part of 'data_patient_bloc.dart';

@freezed
class DataPatientEvent with _$DataPatientEvent {
  const factory DataPatientEvent.started() = _Started;
  const factory DataPatientEvent.getPatients() = _GetPatients;
  const factory DataPatientEvent.getPatientByNIK(String nik) = _GetPatientByNIK;
}
