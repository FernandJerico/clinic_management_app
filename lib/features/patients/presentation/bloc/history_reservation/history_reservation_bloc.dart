import 'package:bloc/bloc.dart';
import 'package:clinic_management_app/features/patients/data/datasource/reservation_remote_datasource.dart';
import 'package:clinic_management_app/features/patients/data/model/response/history_reservation_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_reservation_event.dart';
part 'history_reservation_state.dart';
part 'history_reservation_bloc.freezed.dart';

class HistoryReservationBloc
    extends Bloc<HistoryReservationEvent, HistoryReservationState> {
  final ReservationRemoteDatasource reservationRemoteDatasource;
  HistoryReservationBloc(this.reservationRemoteDatasource)
      : super(const _Initial()) {
    on<_GetHistoryReservation>((event, emit) async {
      emit(const _Loading());
      final result = await reservationRemoteDatasource.getHistoryReservation();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });

    on<_GetHistoryReservationByName>((event, emit) async {
      emit(const _Loading());
      final result = await reservationRemoteDatasource
          .getHistoryReservationByName(event.name);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });
  }
}
