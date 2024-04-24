part of 'create_payment_detail_bloc.dart';

@freezed
class CreatePaymentDetailEvent with _$CreatePaymentDetailEvent {
  const factory CreatePaymentDetailEvent.started() = _Started;
  const factory CreatePaymentDetailEvent.createPaymentDetail(
    CreatePaymentDetailRequestModel requestModel,
  ) = _CreatePaymentDetail;
}
