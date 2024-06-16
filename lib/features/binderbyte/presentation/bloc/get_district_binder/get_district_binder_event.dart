part of 'get_district_binder_bloc.dart';

@freezed
class GetDistrictBinderEvent with _$GetDistrictBinderEvent {
  const factory GetDistrictBinderEvent.started() = _Started;
  const factory GetDistrictBinderEvent.getDistrict(String cityCode) =
      _GetDistrict;
}
