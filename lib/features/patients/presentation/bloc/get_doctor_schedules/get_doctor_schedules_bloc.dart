// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:clinic_management_app/features/patients/data/datasource/reservation_remote_datasource.dart';

import '../../../../master/data/models/response/doctor_schedule_response_model.dart';

part 'get_doctor_schedules_bloc.freezed.dart';
part 'get_doctor_schedules_event.dart';
part 'get_doctor_schedules_state.dart';

class GetDoctorSchedulesBloc
    extends Bloc<GetDoctorSchedulesEvent, GetDoctorSchedulesState> {
  final ReservationRemoteDatasource reservationRemoteDatasource;
  GetDoctorSchedulesBloc(
    this.reservationRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetDoctorSchedules>((event, emit) async {
      emit(const _Loading());
      final result = await reservationRemoteDatasource.getDoctorSchedules(
          event.doctorId, event.day);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });

    on<_GetDoctorScheduleByDoctorId>((event, emit) async {
      emit(const _Loading());
      final result = await reservationRemoteDatasource
          .getDoctorScheduleByDoctorId(event.doctorId);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });
  }
}
