import 'package:bloc/bloc.dart';
import 'package:clinic_management_app/features/master/data/datasources/master_remote_datasources.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'accept_reservation_event.dart';
part 'accept_reservation_state.dart';
part 'accept_reservation_bloc.freezed.dart';

class AcceptReservationBloc
    extends Bloc<AcceptReservationEvent, AcceptReservationState> {
  final MasterRemoteDatasources masterRemoteDatasources;
  AcceptReservationBloc(this.masterRemoteDatasources)
      : super(const _Initial()) {
    on<_AcceptReservation>((event, emit) async {
      emit(const _Loading());
      final result = await masterRemoteDatasources.acceptReservation(
        event.reservationId,
        event.status,
        event.message,
      );
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });

    on<_RejectReservation>((event, emit) async {
      emit(const _Loading());
      final result = await masterRemoteDatasources.rejectReservation(
        event.reservationId,
        event.status,
        event.message,
      );
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });
  }
}
