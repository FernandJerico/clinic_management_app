import 'package:bloc/bloc.dart';
import 'package:clinic_management_app/features/binderbyte/data/datasource/binderbyte_wilayah_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/model/response/province_response_model.dart';

part 'get_province_binder_event.dart';
part 'get_province_binder_state.dart';
part 'get_province_binder_bloc.freezed.dart';

class GetProvinceBinderBloc
    extends Bloc<GetProvinceBinderEvent, GetProvinceBinderState> {
  final BinderbyteWilayahRemoteDatasource binderbyteWilayahRemoteDatasource;
  GetProvinceBinderBloc(this.binderbyteWilayahRemoteDatasource)
      : super(const _Initial()) {
    on<_GetProvince>((event, emit) async {
      emit(const _Loading());
      final result = await binderbyteWilayahRemoteDatasource.getProvince();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.value ?? [])),
      );
    });
  }
}
