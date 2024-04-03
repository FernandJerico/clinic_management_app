part of 'data_patient_bloc.dart';

@freezed
class DataPatientState with _$DataPatientState {
  const factory DataPatientState.initial() = _Initial;
  const factory DataPatientState.loading() = _Loading;
  const factory DataPatientState.loaded(List<MasterPatient> patients) = _Loaded;
  const factory DataPatientState.error(String message) = _Error;
}
