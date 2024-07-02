part of 'get_patient_this_month_bloc.dart';

@freezed
class GetPatientThisMonthEvent with _$GetPatientThisMonthEvent {
  const factory GetPatientThisMonthEvent.started() = _Started;
  const factory GetPatientThisMonthEvent.getPatientThisMonth() =
      _GetPatientThisMonth;
}
