// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/datasources/satusehat_master_wilayah_remote_datasources.dart';
import '../../../data/models/response/wilayah_response_model.dart';

part 'district_bloc.freezed.dart';
part 'district_event.dart';
part 'district_state.dart';

class DistrictBloc extends Bloc<DistrictEvent, DistrictState> {
  final SatusehatMasterWilayahRemoteDatasources remoteDatasources;
  DistrictBloc(
    this.remoteDatasources,
  ) : super(const _Initial()) {
    on<_GetDistrict>((event, emit) async {
      emit(const _Loading());
      final result = await remoteDatasources.getDistricts(event.cityCode);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });
  }
}
