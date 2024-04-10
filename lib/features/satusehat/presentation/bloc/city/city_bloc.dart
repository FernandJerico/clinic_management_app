// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:clinic_management_app/features/satusehat/data/datasources/satusehat_master_wilayah_remote_datasources.dart';
import 'package:clinic_management_app/features/satusehat/data/models/response/city_response_model.dart';

part 'city_bloc.freezed.dart';
part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final SatusehatMasterWilayahRemoteDatasources remoteDatasources;
  CityBloc(
    this.remoteDatasources,
  ) : super(const _Initial()) {
    on<_GetCity>((event, emit) async {
      emit(const _Loading());
      final result = await remoteDatasources.getCities(event.provinceCode);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });
  }
}
