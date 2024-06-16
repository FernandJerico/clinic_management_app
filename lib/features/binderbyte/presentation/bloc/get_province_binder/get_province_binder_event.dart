part of 'get_province_binder_bloc.dart';

@freezed
class GetProvinceBinderEvent with _$GetProvinceBinderEvent {
  const factory GetProvinceBinderEvent.started() = _Started;
  const factory GetProvinceBinderEvent.getProvince() = _GetProvince;
}
