import 'dart:convert';

class AddReservationRequestModel {
  final int? patientId;
  final int? doctorId;
  final DateTime? scheduleTime;
  final String? complaint;
  final String? status;
  final int? totalPrice;
  final int? queueNumber;

  AddReservationRequestModel({
    this.patientId,
    this.doctorId,
    this.scheduleTime,
    this.complaint,
    this.status,
    this.totalPrice,
    this.queueNumber,
  });

  factory AddReservationRequestModel.fromJson(String str) =>
      AddReservationRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddReservationRequestModel.fromMap(Map<String, dynamic> json) =>
      AddReservationRequestModel(
        patientId: json["patient_id"],
        doctorId: json["doctor_id"],
        scheduleTime: json["schedule_time"] == null
            ? null
            : DateTime.parse(json["schedule_time"]),
        complaint: json["complaint"],
        status: json["status"],
        totalPrice: json["total_price"],
        queueNumber: json["queue_number"],
      );

  Map<String, dynamic> toMap() => {
        "patient_id": patientId,
        "doctor_id": doctorId,
        "schedule_time": scheduleTime?.toIso8601String(),
        "complaint": complaint,
        "status": status,
        "total_price": totalPrice,
        "queue_number": queueNumber,
      };
}
