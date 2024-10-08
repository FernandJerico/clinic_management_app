part of 'get_service_order_bloc.dart';

@freezed
class GetServiceOrderState with _$GetServiceOrderState {
  const factory GetServiceOrderState.initial() = _Initial;
  const factory GetServiceOrderState.loading() = _Loading;
  const factory GetServiceOrderState.loaded(
      Map<int, List<ServiceOrder>> serviceOrders) = _Loaded;
  const factory GetServiceOrderState.error(String message) = _Error;
}
