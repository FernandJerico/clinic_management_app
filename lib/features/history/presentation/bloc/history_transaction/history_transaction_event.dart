part of 'history_transaction_bloc.dart';

@freezed
class HistoryTransactionEvent with _$HistoryTransactionEvent {
  const factory HistoryTransactionEvent.started() = _Started;
  const factory HistoryTransactionEvent.getHistoryTransaction() =
      _GetHistoryTransaction;
  const factory HistoryTransactionEvent.getHistoryTransactionByName(
      String name) = _GetHistoryTransactionByName;
}
