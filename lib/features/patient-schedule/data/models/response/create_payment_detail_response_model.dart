import 'dart:convert';

class CreatePaymentDetailResponseModel {
  final String? status;
  final String? message;
  final Data? data;

  CreatePaymentDetailResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory CreatePaymentDetailResponseModel.fromJson(String str) =>
      CreatePaymentDetailResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreatePaymentDetailResponseModel.fromMap(Map<String, dynamic> json) =>
      CreatePaymentDetailResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data?.toMap(),
      };
}

class Data {
  final int? patientId;
  final String? patientScheduleId;
  final String? paymentMethod;
  final int? totalPrice;
  final DateTime? transactionTime;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;
  final PatientSchedule? patientSchedule;

  Data({
    this.patientId,
    this.patientScheduleId,
    this.paymentMethod,
    this.totalPrice,
    this.transactionTime,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.patientSchedule,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        patientId: json["patient_id"],
        patientScheduleId: json["patient_schedule_id"],
        paymentMethod: json["payment_method"],
        totalPrice: json["total_price"],
        transactionTime: json["transaction_time"] == null
            ? null
            : DateTime.parse(json["transaction_time"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
        patientSchedule: json["patient_schedule"] == null
            ? null
            : PatientSchedule.fromMap(json["patient_schedule"]),
      );

  Map<String, dynamic> toMap() => {
        "patient_id": patientId,
        "patient_schedule_id": patientScheduleId,
        "payment_method": paymentMethod,
        "total_price": totalPrice,
        "transaction_time": transactionTime?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "patient_schedule": patientSchedule?.toMap(),
      };
}

class PatientSchedule {
  final int? id;
  final int? patientId;
  final int? doctorId;
  final DateTime? scheduleTime;
  final String? complaint;
  final String? status;
  final int? queueNumber;
  final String? paymentMethod;
  final int? totalPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PatientSchedule({
    this.id,
    this.patientId,
    this.doctorId,
    this.scheduleTime,
    this.complaint,
    this.status,
    this.queueNumber,
    this.paymentMethod,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
  });

  factory PatientSchedule.fromJson(String str) =>
      PatientSchedule.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PatientSchedule.fromMap(Map<String, dynamic> json) => PatientSchedule(
        id: json["id"],
        patientId: json["patient_id"],
        doctorId: json["doctor_id"],
        scheduleTime: json["schedule_time"] == null
            ? null
            : DateTime.parse(json["schedule_time"]),
        complaint: json["complaint"],
        status: json["status"],
        queueNumber: json["queue_number"],
        paymentMethod: json["payment_method"],
        totalPrice: json["total_price"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "patient_id": patientId,
        "doctor_id": doctorId,
        "schedule_time": scheduleTime?.toIso8601String(),
        "complaint": complaint,
        "status": status,
        "queue_number": queueNumber,
        "payment_method": paymentMethod,
        "total_price": totalPrice,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
