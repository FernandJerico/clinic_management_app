import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/datasource/binderbyte_wilayah_remote_datasource.dart';
import '../../../data/model/response/district_response_model.dart';

part 'get_district_binder_event.dart';
part 'get_district_binder_state.dart';
part 'get_district_binder_bloc.freezed.dart';

class GetDistrictBinderBloc
    extends Bloc<GetDistrictBinderEvent, GetDistrictBinderState> {
  final BinderbyteWilayahRemoteDatasource binderbyteWilayahRemoteDatasource;
  GetDistrictBinderBloc(this.binderbyteWilayahRemoteDatasource)
      : super(const _Initial()) {
    on<_GetDistrict>((event, emit) async {
      emit(const _Loading());
      final result =
          await binderbyteWilayahRemoteDatasource.getDistricts(event.cityCode);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.value ?? [])),
      );
    });
  }
}
