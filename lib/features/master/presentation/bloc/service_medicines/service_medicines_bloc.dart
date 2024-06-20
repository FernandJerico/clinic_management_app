import 'package:bloc/bloc.dart';
import 'package:clinic_management_app/features/master/data/datasources/master_remote_datasources.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/request/service_medicines_request_model.dart';

part 'service_medicines_event.dart';
part 'service_medicines_state.dart';
part 'service_medicines_bloc.freezed.dart';

class ServiceMedicinesBloc
    extends Bloc<ServiceMedicinesEvent, ServiceMedicinesState> {
  final MasterRemoteDatasources remoteDatasources;
  ServiceMedicinesBloc(this.remoteDatasources) : super(const _Initial()) {
    on<_AddServiceMedicines>((event, emit) async {
      emit(const _Loading());
      final result = await remoteDatasources.addServiceMedicines(event.data);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });

    on<_EditServiceMedicines>((event, emit) async {
      emit(const _Loading());
      final result = await remoteDatasources.editServiceMedicines(
          event.data, event.serviceId);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });

    on<_DeleteServiceMedicines>((event, emit) async {
      emit(const _Loading());
      final result =
          await remoteDatasources.deleteServiceMedicines(event.serviceId);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });
  }
}
