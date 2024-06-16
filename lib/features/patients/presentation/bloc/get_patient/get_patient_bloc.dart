import 'package:bloc/bloc.dart';
import 'package:clinic_management_app/features/patients/data/datasource/reservation_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../master/data/models/response/master_patient_response_model.dart';

part 'get_patient_event.dart';
part 'get_patient_state.dart';
part 'get_patient_bloc.freezed.dart';

class GetPatientBloc extends Bloc<GetPatientEvent, GetPatientState> {
  final ReservationRemoteDatasource remoteDatasource;
  GetPatientBloc(this.remoteDatasource) : super(const _Initial()) {
    on<_GetPatient>((event, emit) async {
      emit(const _Loading());
      final result = await remoteDatasource.getPatient();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });
  }
}
