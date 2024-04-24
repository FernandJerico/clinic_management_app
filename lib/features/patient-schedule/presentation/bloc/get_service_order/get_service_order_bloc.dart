// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:clinic_management_app/features/patient-schedule/data/datasources/medical_records_remote_datasource.dart';

import '../../../data/models/response/service_order_response_model.dart';

part 'get_service_order_bloc.freezed.dart';
part 'get_service_order_event.dart';
part 'get_service_order_state.dart';

class GetServiceOrderBloc
    extends Bloc<GetServiceOrderEvent, GetServiceOrderState> {
  final MedicalRecordsRemoteDatasource _medicalRecordsRemoteDatasource;
  GetServiceOrderBloc(
    this._medicalRecordsRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetServiceOrder>((event, emit) async {
      emit(const _Loading());
      final response = await _medicalRecordsRemoteDatasource
          .getServiceOrderByScheduleId(event.scheduleId);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
