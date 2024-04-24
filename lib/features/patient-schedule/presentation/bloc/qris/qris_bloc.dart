// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:clinic_management_app/features/patient-schedule/data/datasources/midtrans_remote_datasource.dart';
import 'package:clinic_management_app/features/patient-schedule/data/models/response/qris_response_model.dart';

import '../../../data/models/response/qris_status_response_model.dart';

part 'qris_bloc.freezed.dart';
part 'qris_event.dart';
part 'qris_state.dart';

class QrisBloc extends Bloc<QrisEvent, QrisState> {
  final MidtransRemoteDatasource remoteDatasource;
  QrisResponseModel? qrisResponseModel;
  QrisBloc(
    this.remoteDatasource,
  ) : super(const _Initial()) {
    on<_GenerateQrCode>((event, emit) async {
      emit(const _Loading());
      try {
        qrisResponseModel = await remoteDatasource.generateQrCode(
          event.orderId,
          event.grossAmount,
        );
        emit(_QrisResponse(qrisResponseModel!));
      } catch (e) {
        emit(_Error(e.toString()));
      }
    });

    on<_CheckPaymentStatus>((event, emit) async {
      emit(const _Loading());
      try {
        final qrisStatusResponseModel =
            await remoteDatasource.checkPaymentStatus(
          event.orderId,
        );
        if (qrisStatusResponseModel.transactionStatus == 'pending') {
          emit(_QrisResponse(qrisResponseModel!));
        }
        emit(_QrisStatusCheck(qrisStatusResponseModel));
      } catch (e) {
        emit(_Error(e.toString()));
      }
    });
  }
}
