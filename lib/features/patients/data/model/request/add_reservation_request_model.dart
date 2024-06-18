import 'dart:convert';

class CreateReservationRequestModel {
  final String? userId;
  final String? patientId;
  final String? phone;
  final String? doctorId;
  final String? dayAppointment;
  final String? timeAppointment;
  final String? guarantor;
  final String? bpjsNumber;
  final String? complaint;

  CreateReservationRequestModel({
    this.userId,
    this.patientId,
    this.phone,
    this.doctorId,
    this.dayAppointment,
    this.timeAppointment,
    this.guarantor,
    this.bpjsNumber,
    this.complaint,
  });

  factory CreateReservationRequestModel.fromJson(String str) =>
      CreateReservationRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateReservationRequestModel.fromMap(Map<String, dynamic> json) =>
      CreateReservationRequestModel(
        userId: json["user_id"],
        patientId: json["patient_id"],
        phone: json["phone"],
        doctorId: json["doctor_id"],
        dayAppointment: json["day_appointment"],
        timeAppointment: json["time_appointment"],
        guarantor: json["guarantor"],
        bpjsNumber: json["bpjs_number"],
        complaint: json["complaint"],
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "patient_id": patientId,
        "phone": phone,
        "doctor_id": doctorId,
        "day_appointment": dayAppointment,
        "time_appointment": timeAppointment,
        "guarantor": guarantor,
        "bpjs_number": bpjsNumber,
        "complaint": complaint,
      };
}
