part of 'get_district_binder_bloc.dart';

@freezed
class GetDistrictBinderState with _$GetDistrictBinderState {
  const factory GetDistrictBinderState.initial() = _Initial;
  const factory GetDistrictBinderState.loading() = _Loading;
  const factory GetDistrictBinderState.loaded(List<DistrictBB> district) =
      _Loaded;
  const factory GetDistrictBinderState.error(String message) = _Error;
}
