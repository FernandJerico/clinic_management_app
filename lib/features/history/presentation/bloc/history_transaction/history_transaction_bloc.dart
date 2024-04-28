// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/datasource/history_transaction_remote_datasource.dart';
import '../../../data/models/response/history_transaction_response_model.dart';

part 'history_transaction_bloc.freezed.dart';
part 'history_transaction_event.dart';
part 'history_transaction_state.dart';

class HistoryTransactionBloc
    extends Bloc<HistoryTransactionEvent, HistoryTransactionState> {
  final HistoryTransactionRemoteDatasource historyTransactionRemoteDatasource;
  HistoryTransactionBloc(
    this.historyTransactionRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetHistoryTransaction>((event, emit) async {
      emit(const _Loading());
      final result =
          await historyTransactionRemoteDatasource.getHistoryTransaction();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });
  }
}
