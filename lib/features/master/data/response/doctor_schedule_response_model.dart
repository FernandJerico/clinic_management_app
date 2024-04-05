import 'dart:convert';

class DoctorScheduleResponseModel {
  final bool success;
  final String message;
  final List<DoctorSchedule> data;

  DoctorScheduleResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DoctorScheduleResponseModel.fromJson(String str) =>
      DoctorScheduleResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DoctorScheduleResponseModel.fromMap(Map<String, dynamic> json) =>
      DoctorScheduleResponseModel(
        success: json["success"],
        message: json["message"],
        data: List<DoctorSchedule>.from(
            json["data"].map((x) => DoctorSchedule.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class DoctorSchedule {
  final int id;
  final int doctorId;
  final String day;
  final String time;
  final String status;
  final String note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Doctor doctor;

  DoctorSchedule({
    required this.id,
    required this.doctorId,
    required this.day,
    required this.time,
    required this.status,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.doctor,
  });

  factory DoctorSchedule.fromJson(String str) =>
      DoctorSchedule.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DoctorSchedule.fromMap(Map<String, dynamic> json) => DoctorSchedule(
        id: json["id"],
        doctorId: json["doctor_id"],
        day: json["day"],
        time: json["time"],
        status: json["status"],
        note: json["note"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        doctor: Doctor.fromMap(json["doctor"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "doctor_id": doctorId,
        "day": day,
        "time": time,
        "status": status,
        "note": note,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "doctor": doctor.toMap(),
      };
}

class Doctor {
  final int id;
  final String idIhs;
  final String nik;
  final String doctorName;
  final String doctorSpecialist;
  final String doctorPhone;
  final String doctorEmail;
  final String photo;
  final String address;
  final String sip;
  final DateTime createdAt;
  final DateTime updatedAt;

  Doctor({
    required this.id,
    required this.idIhs,
    required this.nik,
    required this.doctorName,
    required this.doctorSpecialist,
    required this.doctorPhone,
    required this.doctorEmail,
    required this.photo,
    required this.address,
    required this.sip,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Doctor.fromJson(String str) => Doctor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Doctor.fromMap(Map<String, dynamic> json) => Doctor(
        id: json["id"],
        idIhs: json["id_ihs"],
        nik: json["nik"],
        doctorName: json["doctor_name"],
        doctorSpecialist: json["doctor_specialist"],
        doctorPhone: json["doctor_phone"],
        doctorEmail: json["doctor_email"],
        photo: json["photo"],
        address: json["address"],
        sip: json["sip"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "id_ihs": idIhs,
        "nik": nik,
        "doctor_name": doctorName,
        "doctor_specialist": doctorSpecialist,
        "doctor_phone": doctorPhone,
        "doctor_email": doctorEmail,
        "photo": photo,
        "address": address,
        "sip": sip,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
