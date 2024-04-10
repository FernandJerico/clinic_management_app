part of 'sub_district_bloc.dart';

@freezed
class SubDistrictEvent with _$SubDistrictEvent {
  const factory SubDistrictEvent.started() = _Started;
  const factory SubDistrictEvent.getSubDistrict(int districtCode) =
      _GetSubDistrict;
}
