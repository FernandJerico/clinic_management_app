// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/datasource/binderbyte_wilayah_remote_datasource.dart';
import '../../../data/model/response/sub_district_response_model.dart';

part 'get_sub_district_binder_bloc.freezed.dart';
part 'get_sub_district_binder_event.dart';
part 'get_sub_district_binder_state.dart';

class GetSubDistrictBinderBloc
    extends Bloc<GetSubDistrictBinderEvent, GetSubDistrictBinderState> {
  final BinderbyteWilayahRemoteDatasource binderbyteWilayahRemoteDatasource;
  GetSubDistrictBinderBloc(
    this.binderbyteWilayahRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetSubDistrict>((event, emit) async {
      emit(const _Loading());
      final result = await binderbyteWilayahRemoteDatasource
          .getSubDistrict(event.districtCode);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.value ?? [])),
      );
    });
  }
}
