part of 'sub_district_bloc.dart';

@freezed
class SubDistrictState with _$SubDistrictState {
  const factory SubDistrictState.initial() = _Initial;
  const factory SubDistrictState.loading() = _Loading;
  const factory SubDistrictState.loaded(List<Wilayah> subDistricts) = _Loaded;
  const factory SubDistrictState.error(String message) = _Error;
}
