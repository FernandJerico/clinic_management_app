part of 'data_service_medicine_bloc.dart';

@freezed
class DataServiceMedicineState with _$DataServiceMedicineState {
  const factory DataServiceMedicineState.initial() = _Initial;
  const factory DataServiceMedicineState.loading() = _Loading;
  const factory DataServiceMedicineState.loaded(
      List<ServiceMedicine> serviceMedicines) = _Loaded;
  const factory DataServiceMedicineState.error(String message) = _Error;
}
