import 'package:bloc/bloc.dart';
import 'package:clinic_management_app/features/master/data/models/response/service_medicine_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_service_medicine_event.dart';
part 'data_service_medicine_state.dart';
part 'data_service_medicine_bloc.freezed.dart';

class DataServiceMedicineBloc
    extends Bloc<DataServiceMedicineEvent, DataServiceMedicineState> {
  DataServiceMedicineBloc() : super(_Initial()) {
    on<DataServiceMedicineEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
