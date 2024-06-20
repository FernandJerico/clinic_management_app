import 'dart:convert';

class DoctorScheduleResponseModel {
  final bool? success;
  final String? message;
  final List<DoctorSchedule>? data;

  DoctorScheduleResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory DoctorScheduleResponseModel.fromJson(String str) =>
      DoctorScheduleResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DoctorScheduleResponseModel.fromMap(Map<String, dynamic> json) =>
      DoctorScheduleResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DoctorSchedule>.from(
                json["data"]!.map((x) => DoctorSchedule.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class DoctorSchedule {
  final int? id;
  final int? doctorId;
  final String? day;
  final String? time;
  final String? status;
  final String? note;
  final dynamic createdAt;
  final dynamic updatedAt;
  final Doctor? doctor;

  DoctorSchedule({
    this.id,
    this.doctorId,
    this.day,
    this.time,
    this.status,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.doctor,
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
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        doctor: json["doctor"] == null ? null : Doctor.fromMap(json["doctor"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "doctor_id": doctorId,
        "day": day,
        "time": time,
        "status": status,
        "note": note,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "doctor": doctor?.toMap(),
      };
}

class Doctor {
  final int? id;
  final String? idIhs;
  final String? nik;
  final String? doctorName;
  final String? doctorSpecialist;
  final String? doctorPhone;
  final String? doctorEmail;
  final String? photo;
  final String? address;
  final String? sip;
  final String? polyclinic;
  final dynamic createdAt;
  final dynamic updatedAt;

  Doctor({
    this.id,
    this.idIhs,
    this.nik,
    this.doctorName,
    this.doctorSpecialist,
    this.doctorPhone,
    this.doctorEmail,
    this.photo,
    this.address,
    this.sip,
    this.polyclinic,
    this.createdAt,
    this.updatedAt,
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
        polyclinic: json["polyclinic"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
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
        "polyclinic": polyclinic,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
