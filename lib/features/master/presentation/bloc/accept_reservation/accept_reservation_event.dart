part of 'accept_reservation_bloc.dart';

@freezed
class AcceptReservationEvent with _$AcceptReservationEvent {
  const factory AcceptReservationEvent.started() = _Started;
  const factory AcceptReservationEvent.acceptReservation({
    required String reservationId,
    required String status,
    required String message,
  }) = _AcceptReservation;
  const factory AcceptReservationEvent.rejectReservation({
    required String reservationId,
    required String status,
    required String message,
  }) = _RejectReservation;
}