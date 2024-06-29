part of 'complete_reservation_bloc.dart';

@freezed
class CompleteReservationEvent with _$CompleteReservationEvent {
  const factory CompleteReservationEvent.started() = _Started;
  const factory CompleteReservationEvent.completeReservation({
    required String reservationId,
    required String status,
    required File historyImage,
  }) = _CompleteReservation;
}
