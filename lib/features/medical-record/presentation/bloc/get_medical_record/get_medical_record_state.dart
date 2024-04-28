part of 'get_medical_record_bloc.dart';

@freezed
class GetMedicalRecordState with _$GetMedicalRecordState {
  const factory GetMedicalRecordState.initial() = _Initial;
  const factory GetMedicalRecordState.loading() = _Loading;
  const factory GetMedicalRecordState.loaded(
      List<MedicalRecord> medicalRecords) = _Loaded;
  const factory GetMedicalRecordState.error(String message) = _Error;
}
