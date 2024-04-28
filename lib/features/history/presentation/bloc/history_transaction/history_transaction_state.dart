part of 'history_transaction_bloc.dart';

@freezed
class HistoryTransactionState with _$HistoryTransactionState {
  const factory HistoryTransactionState.initial() = _Initial;
  const factory HistoryTransactionState.loading() = _Loading;
  const factory HistoryTransactionState.loaded(
      List<HistoryTransaction> historyTransaction) = _Loaded;
  const factory HistoryTransactionState.error(String message) = _Error;
}
