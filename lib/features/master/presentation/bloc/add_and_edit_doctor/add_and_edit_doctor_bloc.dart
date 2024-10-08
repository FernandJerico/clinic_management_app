import 'package:bloc/bloc.dart';
import 'package:clinic_management_app/features/master/data/datasources/master_remote_datasources.dart';
import 'package:clinic_management_app/features/master/data/models/request/add_doctor_request_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/request/edit_doctor_request_model.dart';

part 'add_and_edit_doctor_event.dart';
part 'add_and_edit_doctor_state.dart';
part 'add_and_edit_doctor_bloc.freezed.dart';

class AddAndEditDoctorBloc
    extends Bloc<AddAndEditDoctorEvent, AddAndEditDoctorState> {
  final MasterRemoteDatasources masterRemoteDatasources;
  AddAndEditDoctorBloc(this.masterRemoteDatasources) : super(const _Initial()) {
    on<_AddDoctor>((event, emit) async {
      emit(const _Loading());
      final result = await masterRemoteDatasources.addDoctor(event.doctor);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });

    on<_EditDoctor>((event, emit) async {
      emit(const _Loading());
      final result = await masterRemoteDatasources.editDoctor(
          event.doctorId, event.doctor);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });

    on<_DeleteDoctor>((event, emit) async {
      emit(const _Loading());
      final result = await masterRemoteDatasources.deleteDoctor(event.doctorId);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });
  }
}
