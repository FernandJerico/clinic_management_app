import 'dart:convert';

class CreatePaymentDetailRequestModel {
  final int? patientId;
  final String? patientScheduleId;
  final int? medicalRecordId;
  final int? medicalRecordServiceId;
  final String? paymentMethod;
  final int? totalPrice;
  final DateTime? transactionTime;

  CreatePaymentDetailRequestModel({
    this.patientId,
    this.patientScheduleId,
    this.medicalRecordId,
    this.medicalRecordServiceId,
    this.paymentMethod,
    this.totalPrice,
    this.transactionTime,
  });

  factory CreatePaymentDetailRequestModel.fromJson(String str) =>
      CreatePaymentDetailRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreatePaymentDetailRequestModel.fromMap(Map<String, dynamic> json) =>
      CreatePaymentDetailRequestModel(
        patientId: json["patient_id"],
        patientScheduleId: json["patient_schedule_id"],
        medicalRecordId: json["medical_record_id"],
        medicalRecordServiceId: json["medical_record_service_id"],
        paymentMethod: json["payment_method"],
        totalPrice: json["total_price"],
        transactionTime: json["transaction_time"] == null
            ? null
            : DateTime.parse(json["transaction_time"]),
      );

  Map<String, dynamic> toMap() => {
        "patient_id": patientId,
        "patient_schedule_id": patientScheduleId,
        "medical_record_id": medicalRecordId,
        "medical_record_service_id": medicalRecordServiceId,
        "payment_method": paymentMethod,
        "total_price": totalPrice,
        "transaction_time": transactionTime?.toIso8601String(),
      };
}
