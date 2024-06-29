part of 'complete_reservation_bloc.dart';

@freezed
class CompleteReservationState with _$CompleteReservationState {
  const factory CompleteReservationState.initial() = _Initial;
  const factory CompleteReservationState.loading() = _Loading;
  const factory CompleteReservationState.success() = _Success;
  const factory CompleteReservationState.error(String message) = _Error;
}
