part of 'get_total_patient_bloc.dart';

@freezed
class GetTotalPatientState with _$GetTotalPatientState {
  const factory GetTotalPatientState.initial() = _Initial;
  const factory GetTotalPatientState.loading() = _Loading;
  const factory GetTotalPatientState.loaded(int countPatient) = _Loaded;
  const factory GetTotalPatientState.error(String message) = _Error;
}
