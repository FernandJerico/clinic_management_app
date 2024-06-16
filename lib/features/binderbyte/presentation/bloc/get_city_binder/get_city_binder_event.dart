part of 'get_city_binder_bloc.dart';

@freezed
class GetCityBinderEvent with _$GetCityBinderEvent {
  const factory GetCityBinderEvent.started() = _Started;
  const factory GetCityBinderEvent.getCity(String provinceId) = _GetCity;
}
