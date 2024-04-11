// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/datasources/patient_schedule_remote_datasources.dart';
import '../../../data/models/response/patient_schedule_response_model.dart';

part 'patient_schedule_bloc.freezed.dart';
part 'patient_schedule_event.dart';
part 'patient_schedule_state.dart';

class PatientScheduleBloc
    extends Bloc<PatientScheduleEvent, PatientScheduleState> {
  final PatientScheduleRemoteDatasources remoteDatasources;
  PatientScheduleBloc(
    this.remoteDatasources,
  ) : super(const _Initial()) {
    on<_GetPatientSchedules>((event, emit) async {
      emit(const _Loading());
      final result = await remoteDatasources.getPatientSchedules();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });
  }
}
