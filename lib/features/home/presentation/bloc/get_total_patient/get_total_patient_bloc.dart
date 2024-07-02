import 'package:bloc/bloc.dart';
import 'package:clinic_management_app/features/home/data/datasource/dashboard_master_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_total_patient_event.dart';
part 'get_total_patient_state.dart';
part 'get_total_patient_bloc.freezed.dart';

class GetTotalPatientBloc
    extends Bloc<GetTotalPatientEvent, GetTotalPatientState> {
  final DashboardMasterDatasource dashboardMasterDatasource;
  GetTotalPatientBloc(this.dashboardMasterDatasource)
      : super(const _Initial()) {
    on<_GetTotalPatient>((event, emit) async {
      emit(const _Loading());
      final response = await dashboardMasterDatasource.getCountPatientTotal();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.countPatient ?? 0)),
      );
    });
  }
}
