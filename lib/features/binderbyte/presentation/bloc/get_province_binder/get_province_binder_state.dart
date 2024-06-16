part of 'get_province_binder_bloc.dart';

@freezed
class GetProvinceBinderState with _$GetProvinceBinderState {
  const factory GetProvinceBinderState.initial() = _Initial;
  const factory GetProvinceBinderState.loading() = _Loading;
  const factory GetProvinceBinderState.loaded(List<ProvinceBB> province) =
      _Loaded;
  const factory GetProvinceBinderState.error(String message) = _Error;
}
