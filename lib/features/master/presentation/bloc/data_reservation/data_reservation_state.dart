part of 'data_reservation_bloc.dart';

@freezed
class DataReservationState with _$DataReservationState {
  const factory DataReservationState.initial() = _Initial;
  const factory DataReservationState.loading() = _Loading;
  const factory DataReservationState.loaded(
      List<MasterReservation> reservations) = _Loaded;
  const factory DataReservationState.error(String message) = _Error;
}
