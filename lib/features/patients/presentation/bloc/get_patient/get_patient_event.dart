part of 'get_patient_bloc.dart';

@freezed
class GetPatientEvent with _$GetPatientEvent {
  const factory GetPatientEvent.started() = _Started;
  const factory GetPatientEvent.getPatient() = _GetPatient;
}
