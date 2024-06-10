part of 'reservation_bloc.dart';

@freezed
class ReservationEvent with _$ReservationEvent {
  const factory ReservationEvent.started() = _Started;
  const factory ReservationEvent.createReservation(
      {required CreateReservationRequestModel data}) = _CreateReservation;
}
