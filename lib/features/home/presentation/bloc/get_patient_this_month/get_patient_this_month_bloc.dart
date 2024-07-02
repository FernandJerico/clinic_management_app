import 'package:bloc/bloc.dart';
import 'package:clinic_management_app/features/home/data/datasource/dashboard_master_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_patient_this_month_event.dart';
part 'get_patient_this_month_state.dart';
part 'get_patient_this_month_bloc.freezed.dart';

class GetPatientThisMonthBloc
    extends Bloc<GetPatientThisMonthEvent, GetPatientThisMonthState> {
  final DashboardMasterDatasource dashboardMasterDatasource;
  GetPatientThisMonthBloc(this.dashboardMasterDatasource)
      : super(const _Initial()) {
    on<_GetPatientThisMonth>((event, emit) async {
      emit(const _Loading());
      final response =
          await dashboardMasterDatasource.getCountPatientThisMonth();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.countPatient ?? 0)),
      );
    });
  }
}
