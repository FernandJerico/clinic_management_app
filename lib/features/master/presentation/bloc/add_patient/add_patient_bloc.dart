// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:clinic_management_app/features/master/data/datasources/master_remote_datasources.dart';

import '../../../data/models/request/add_patient_request_model.dart';

part 'add_patient_bloc.freezed.dart';
part 'add_patient_event.dart';
part 'add_patient_state.dart';

class AddPatientBloc extends Bloc<AddPatientEvent, AddPatientState> {
  final MasterRemoteDatasources remoteDatasources;
  AddPatientBloc(
    this.remoteDatasources,
  ) : super(const _Initial()) {
    on<_AddPatient>((event, emit) async {
      emit(const _Loading());
      final result = await remoteDatasources.addPatient(event.data);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });
  }
}
