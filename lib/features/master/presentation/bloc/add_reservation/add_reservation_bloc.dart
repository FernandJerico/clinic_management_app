// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:clinic_management_app/features/master/data/datasources/patient_remote_datasources.dart';

import '../../../data/models/request/add_reservation_request_model.dart';

part 'add_reservation_bloc.freezed.dart';
part 'add_reservation_event.dart';
part 'add_reservation_state.dart';

class AddReservationBloc
    extends Bloc<AddReservationEvent, AddReservationState> {
  final PatientRemoteDatasources remoteDatasources;
  AddReservationBloc(
    this.remoteDatasources,
  ) : super(const _Initial()) {
    on<_AddReservation>((event, emit) async {
      emit(const _Loading());
      final result = await remoteDatasources.addReservation(event.data!);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });
  }
}
