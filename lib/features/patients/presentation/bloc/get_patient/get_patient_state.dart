part of 'get_patient_bloc.dart';

@freezed
class GetPatientState with _$GetPatientState {
  const factory GetPatientState.initial() = _Initial;
  const factory GetPatientState.loading() = _Loading;
  const factory GetPatientState.loaded(List<MasterPatient> patient) = _Loaded;
  const factory GetPatientState.error(String message) = _Error;
}
