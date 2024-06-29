import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/datasources/master_remote_datasources.dart';

part 'complete_reservation_event.dart';
part 'complete_reservation_state.dart';
part 'complete_reservation_bloc.freezed.dart';

class CompleteReservationBloc
    extends Bloc<CompleteReservationEvent, CompleteReservationState> {
  final MasterRemoteDatasources masterRemoteDatasources;
  CompleteReservationBloc(this.masterRemoteDatasources)
      : super(const _Initial()) {
    on<_CompleteReservation>((event, emit) async {
      emit(const _Loading());
      final result = await masterRemoteDatasources.completeReservation(
        event.reservationId,
        event.status,
        event.historyImage,
      );
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });
  }
}
