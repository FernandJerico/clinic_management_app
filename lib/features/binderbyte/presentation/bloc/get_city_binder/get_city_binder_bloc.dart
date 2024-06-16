import 'package:bloc/bloc.dart';
import 'package:clinic_management_app/features/binderbyte/data/model/response/city_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/datasource/binderbyte_wilayah_remote_datasource.dart';

part 'get_city_binder_event.dart';
part 'get_city_binder_state.dart';
part 'get_city_binder_bloc.freezed.dart';

class GetCityBinderBloc extends Bloc<GetCityBinderEvent, GetCityBinderState> {
  final BinderbyteWilayahRemoteDatasource binderbyteWilayahRemoteDatasource;
  GetCityBinderBloc(this.binderbyteWilayahRemoteDatasource)
      : super(const _Initial()) {
    on<_GetCity>((event, emit) async {
      emit(const _Loading());
      final result =
          await binderbyteWilayahRemoteDatasource.getCities(event.provinceId);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.value ?? [])),
      );
    });
  }
}
