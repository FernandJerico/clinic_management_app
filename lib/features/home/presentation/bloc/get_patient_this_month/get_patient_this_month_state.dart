part of 'get_patient_this_month_bloc.dart';

@freezed
class GetPatientThisMonthState with _$GetPatientThisMonthState {
  const factory GetPatientThisMonthState.initial() = _Initial;
  const factory GetPatientThisMonthState.loading() = _Loading;
  const factory GetPatientThisMonthState.loaded(int countPatientThisMonth) =
      _Loaded;
  const factory GetPatientThisMonthState.error(String message) = _Error;
}
