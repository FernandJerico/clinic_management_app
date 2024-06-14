import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/datasources/master_remote_datasources.dart';
import '../../../data/models/response/master_reservation_response_model.dart';

part 'data_reservation_event.dart';
part 'data_reservation_state.dart';
part 'data_reservation_bloc.freezed.dart';

class DataReservationBloc
    extends Bloc<DataReservationEvent, DataReservationState> {
  final MasterRemoteDatasources remoteDatasources;
  DataReservationBloc(this.remoteDatasources) : super(const _Initial()) {
    on<_GetReservationData>((event, emit) async {
      emit(const _Loading());
      final result = await remoteDatasources.getReservationData();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });

    on<_GetReservationDataByName>((event, emit) async {
      emit(const _Loading());
      final result =
          await remoteDatasources.getReservationDataByName(event.name);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });
  }
}
