part of 'get_total_patient_bloc.dart';

@freezed
class GetTotalPatientEvent with _$GetTotalPatientEvent {
  const factory GetTotalPatientEvent.started() = _Started;
  const factory GetTotalPatientEvent.getTotalPatient() = _GetTotalPatient;
}
