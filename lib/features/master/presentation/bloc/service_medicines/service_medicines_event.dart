part of 'service_medicines_bloc.dart';

@freezed
class ServiceMedicinesEvent with _$ServiceMedicinesEvent {
  const factory ServiceMedicinesEvent.started() = _Started;
  const factory ServiceMedicinesEvent.addServiceMedicines(
      ServiceMedicinesRequestModel data) = _AddServiceMedicines;
  const factory ServiceMedicinesEvent.editServiceMedicines({
    required ServiceMedicinesRequestModel data,
    required String serviceId,
  }) = _EditServiceMedicines;
  const factory ServiceMedicinesEvent.deleteServiceMedicines(String serviceId) =
      _DeleteServiceMedicines;
}
