import 'package:bloc/bloc.dart';
import 'package:clinic_management_app/features/master/data/datasources/master_remote_datasources.dart';
import 'package:clinic_management_app/features/master/data/models/response/service_medicine_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_service_medicine_event.dart';
part 'data_service_medicine_state.dart';
part 'data_service_medicine_bloc.freezed.dart';

class DataServiceMedicineBloc
    extends Bloc<DataServiceMedicineEvent, DataServiceMedicineState> {
  final MasterRemoteDatasources masterRemoteDatasources;
  DataServiceMedicineBloc(this.masterRemoteDatasources)
      : super(const _Initial()) {
    on<_GetServiceMedicines>((event, emit) async {
      emit(const _Loading());
      final result = await masterRemoteDatasources.getServiceMedicines();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });

    on<_GetServiceMedicineByName>((event, emit) async {
      emit(const _Loading());
      final result =
          await masterRemoteDatasources.getServiceMedicineByName(event.name);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });
  }
}
