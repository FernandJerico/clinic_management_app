import 'package:bloc/bloc.dart';
import 'package:clinic_management_app/features/master/data/datasources/master_remote_datasources.dart';
import 'package:clinic_management_app/features/master/data/response/doctor_schedule_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_doctor_schedule_event.dart';
part 'data_doctor_schedule_state.dart';
part 'data_doctor_schedule_bloc.freezed.dart';

class DataDoctorScheduleBloc
    extends Bloc<DataDoctorScheduleEvent, DataDoctorScheduleState> {
  final MasterRemoteDatasources remoteDatasources;
  DataDoctorScheduleBloc(this.remoteDatasources) : super(const _Initial()) {
    on<_GetDoctorSchedule>((event, emit) async {
      emit(const _Loading());
      final result = await remoteDatasources.getDoctorSchedule();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });

    on<_GetDoctorScheduleByDoctorName>((event, emit) async {
      emit(const _Loading());
      final result =
          await remoteDatasources.getDoctorScheduleByDoctorName(event.name);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });
  }
}
