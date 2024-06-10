part of 'history_reservation_bloc.dart';

@freezed
class HistoryReservationEvent with _$HistoryReservationEvent {
  const factory HistoryReservationEvent.started() = _Started;
  const factory HistoryReservationEvent.getHistoryReservation() =
      _GetHistoryReservation;
  const factory HistoryReservationEvent.getHistoryReservationByName(
      String name) = _GetHistoryReservationByName;
}
