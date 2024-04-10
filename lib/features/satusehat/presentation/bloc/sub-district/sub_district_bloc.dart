// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/datasources/satusehat_master_wilayah_remote_datasources.dart';
import '../../../data/models/response/wilayah_response_model.dart';

part 'sub_district_bloc.freezed.dart';
part 'sub_district_event.dart';
part 'sub_district_state.dart';

class SubDistrictBloc extends Bloc<SubDistrictEvent, SubDistrictState> {
  final SatusehatMasterWilayahRemoteDatasources remoteDatasources;
  SubDistrictBloc(
    this.remoteDatasources,
  ) : super(const _Initial()) {
    on<_GetSubDistrict>((event, emit) async {
      emit(const _Loading());
      final result =
          await remoteDatasources.getSubDistricts(event.districtCode);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });
  }
}
