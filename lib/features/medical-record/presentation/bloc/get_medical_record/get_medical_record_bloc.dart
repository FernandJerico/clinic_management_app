// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:clinic_management_app/features/patient-schedule/data/models/response/get_medical_records_response_mode.dart';

import '../../../../patient-schedule/data/datasources/medical_records_remote_datasource.dart';

part 'get_medical_record_bloc.freezed.dart';
part 'get_medical_record_event.dart';
part 'get_medical_record_state.dart';

class GetMedicalRecordBloc
    extends Bloc<GetMedicalRecordEvent, GetMedicalRecordState> {
  final MedicalRecordsRemoteDatasource remoteDatasource;
  GetMedicalRecordBloc(
    this.remoteDatasource,
  ) : super(const _Initial()) {
    on<_GetMedicalRecord>((event, emit) async {
      emit(const _Loading());
      final result = await remoteDatasource.getMedicalRecords();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });

    on<_GetMedicalRecordByName>((event, emit) async {
      emit(const _Loading());
      final result = await remoteDatasource.getMedicalRecordByName(event.name);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });

    on<_GetMedicalRecordByScheduleId>((event, emit) async {
      emit(const _Loading());
      final result =
          await remoteDatasource.getMedicalRecordByScheduleId(event.scheduleId);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });
  }
}
