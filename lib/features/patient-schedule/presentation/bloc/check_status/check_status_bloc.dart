// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/datasources/midtrans_remote_datasource.dart';
import '../../../data/models/response/qris_status_response_model.dart';

part 'check_status_bloc.freezed.dart';
part 'check_status_event.dart';
part 'check_status_state.dart';

class CheckStatusBloc extends Bloc<CheckStatusEvent, CheckStatusState> {
  final MidtransRemoteDatasource remoteDatasource;
  CheckStatusBloc(
    this.remoteDatasource,
  ) : super(const _Initial()) {
    on<_CheckPaymentStatus>((event, emit) async {
      emit(const _Loading());
      try {
        final qrisStatusResponseModel =
            await remoteDatasource.checkPaymentStatus(
          event.orderId,
        );

        emit(_Loaded(qrisStatusResponseModel));
      } catch (e) {
        emit(_Error(e.toString()));
      }
    });
  }
}
