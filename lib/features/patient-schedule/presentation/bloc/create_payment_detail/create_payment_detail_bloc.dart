// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:clinic_management_app/features/patient-schedule/data/datasources/payment_detail_remote_datasource.dart';
import 'package:clinic_management_app/features/patient-schedule/data/models/response/create_payment_detail_response_model.dart';

import '../../../data/models/request/create_payment_detail_request_model.dart';

part 'create_payment_detail_bloc.freezed.dart';
part 'create_payment_detail_event.dart';
part 'create_payment_detail_state.dart';

class CreatePaymentDetailBloc
    extends Bloc<CreatePaymentDetailEvent, CreatePaymentDetailState> {
  final PaymentDetailRemoteDatasource remoteDatasource;
  CreatePaymentDetailBloc(
    this.remoteDatasource,
  ) : super(const _Initial()) {
    on<_CreatePaymentDetail>((event, emit) async {
      emit(const _Loading());
      try {
        final response =
            await remoteDatasource.createPaymentDetail(event.requestModel);
        response.fold(
          (l) => emit(_Error(l)),
          (r) => emit(_Loaded(r)),
        );
      } catch (e) {
        emit(_Error(e.toString()));
      }
    });
  }
}
