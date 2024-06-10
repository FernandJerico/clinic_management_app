part of 'history_reservation_bloc.dart';

@freezed
class HistoryReservationState with _$HistoryReservationState {
  const factory HistoryReservationState.initial() = _Initial;
  const factory HistoryReservationState.loading() = _Loading;
  const factory HistoryReservationState.loaded(
      List<HistoryReservation> historyReservations) = _Loaded;
  const factory HistoryReservationState.error(String message) = _Error;
}
