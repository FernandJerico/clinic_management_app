part of 'data_service_medicine_bloc.dart';

@freezed
class DataServiceMedicineEvent with _$DataServiceMedicineEvent {
  const factory DataServiceMedicineEvent.started() = _Started;
  const factory DataServiceMedicineEvent.getServiceMedicines() =
      _GetServiceMedicines;
  const factory DataServiceMedicineEvent.getServiceMedicineByName(String name) =
      _GetServiceMedicineByName;
}
