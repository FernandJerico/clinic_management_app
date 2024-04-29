part of 'get_medical_record_bloc.dart';

@freezed
class GetMedicalRecordEvent with _$GetMedicalRecordEvent {
  const factory GetMedicalRecordEvent.started() = _Started;
  const factory GetMedicalRecordEvent.getMedicalRecord() = _GetMedicalRecord;
  const factory GetMedicalRecordEvent.getMedicalRecordByName(String name) =
      _GetMedicalRecordByName;
}
