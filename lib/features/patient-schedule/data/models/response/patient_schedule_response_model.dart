import 'dart:convert';

class PatientScheduleResponseModel {
  final String? status;
  final String? message;
  final List<PatientSchedule>? data;

  PatientScheduleResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory PatientScheduleResponseModel.fromJson(String str) =>
      PatientScheduleResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PatientScheduleResponseModel.fromMap(Map<String, dynamic> json) =>
      PatientScheduleResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<PatientSchedule>.from(
                json["data"]!.map((x) => PatientSchedule.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
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
