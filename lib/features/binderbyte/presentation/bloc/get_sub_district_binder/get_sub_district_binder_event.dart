part of 'get_sub_district_binder_bloc.dart';

@freezed
class GetSubDistrictBinderEvent with _$GetSubDistrictBinderEvent {
  const factory GetSubDistrictBinderEvent.started() = _Started;
  const factory GetSubDistrictBinderEvent.getSubDistrict(String districtCode) =
      _GetSubDistrict;
}
