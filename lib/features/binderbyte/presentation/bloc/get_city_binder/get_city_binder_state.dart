part of 'get_city_binder_bloc.dart';

@freezed
class GetCityBinderState with _$GetCityBinderState {
  const factory GetCityBinderState.initial() = _Initial;
  const factory GetCityBinderState.loading() = _Loading;
  const factory GetCityBinderState.loaded(List<CityBB> city) = _Loaded;
  const factory GetCityBinderState.error(String message) = _Error;
}
