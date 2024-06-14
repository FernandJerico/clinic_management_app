part of 'data_reservation_bloc.dart';

@freezed
class DataReservationEvent with _$DataReservationEvent {
  const factory DataReservationEvent.started() = _Started;
  const factory DataReservationEvent.getReservationData() = _GetReservationData;
  const factory DataReservationEvent.getReservationDataByName(String name) =
      _GetReservationDataByName;
}
