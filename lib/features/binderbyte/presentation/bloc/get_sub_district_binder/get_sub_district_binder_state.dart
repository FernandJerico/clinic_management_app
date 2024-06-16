part of 'get_sub_district_binder_bloc.dart';

@freezed
class GetSubDistrictBinderState with _$GetSubDistrictBinderState {
  const factory GetSubDistrictBinderState.initial() = _Initial;
  const factory GetSubDistrictBinderState.loading() = _Loading;
  const factory GetSubDistrictBinderState.loaded(
      List<SubDistrictBB> subDistricts) = _Loaded;
  const factory GetSubDistrictBinderState.error(String message) = _Error;
}
