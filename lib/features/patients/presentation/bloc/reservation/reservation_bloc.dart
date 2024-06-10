// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:clinic_management_app/features/patients/data/model/request/add_reservation_request_model.dart';

import '../../../data/datasource/reservation_remote_datasource.dart';

part 'reservation_bloc.freezed.dart';
part 'reservation_event.dart';
part 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final ReservationRemoteDatasource remoteDatasources;
  ReservationBloc(
    this.remoteDatasources,
  ) : super(const _Initial()) {
    on<_CreateReservation>((event, emit) async {
      emit(const _Loading());
      final result = await remoteDatasources.createReservation(event.data);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });
  }
}
