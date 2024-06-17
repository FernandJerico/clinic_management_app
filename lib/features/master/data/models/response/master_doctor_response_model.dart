import 'dart:convert';

class MasterDoctorResponseModel {
  final bool? success;
  final String? message;
  final List<MasterDoctor>? data;

  MasterDoctorResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory MasterDoctorResponseModel.fromJson(String str) =>
      MasterDoctorResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MasterDoctorResponseModel.fromMap(Map<String, dynamic> json) =>
      MasterDoctorResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<MasterDoctor>.from(
                json["data"]!.map((x) => MasterDoctor.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class MasterDoctor {
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

  MasterDoctor({
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

  factory MasterDoctor.fromJson(String str) =>
      MasterDoctor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MasterDoctor.fromMap(Map<String, dynamic> json) => MasterDoctor(
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
