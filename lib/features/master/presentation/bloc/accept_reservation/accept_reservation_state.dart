part of 'accept_reservation_bloc.dart';

@freezed
class AcceptReservationState with _$AcceptReservationState {
  const factory AcceptReservationState.initial() = _Initial;
  const factory AcceptReservationState.loading() = _Loading;
  const factory AcceptReservationState.success() = _Success;
  const factory AcceptReservationState.error(String message) = _Error;
}
