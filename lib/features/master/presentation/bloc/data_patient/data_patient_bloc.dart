// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:clinic_management_app/features/master/data/datasources/master_remote_datasources.dart';

import '../../../data/models/response/master_patient_response_model.dart';

part 'data_patient_bloc.freezed.dart';
part 'data_patient_event.dart';
part 'data_patient_state.dart';

class DataPatientBloc extends Bloc<DataPatientEvent, DataPatientState> {
  final MasterRemoteDatasources masterRemoteDatasources;
  DataPatientBloc(
    this.masterRemoteDatasources,
  ) : super(const _Initial()) {
    on<_GetPatients>((event, emit) async {
      emit(const _Loading());
      final result = await masterRemoteDatasources.getPatients();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });

    on<_GetPatientByNIK>((event, emit) async {
      emit(const _Loading());
      final result = await masterRemoteDatasources.getPatientByNIK(event.nik);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });
  }
}
