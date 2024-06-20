import 'dart:convert';

class AddDoctorRequestModel {
  final String? doctorName;
  final String? doctorEmail;
  final String? doctorPhone;
  final String? doctorSpecialist;
  final String? address;
  final String? photo;
  final String? sip;
  final String? idIhs;
  final String? nik;
  final String? polyclinic;

  AddDoctorRequestModel({
    this.doctorName,
    this.doctorEmail,
    this.doctorPhone,
    this.doctorSpecialist,
    this.address,
    this.photo,
    this.sip,
    this.idIhs,
    this.nik,
    this.polyclinic,
  });

  factory AddDoctorRequestModel.fromJson(String str) =>
      AddDoctorRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddDoctorRequestModel.fromMap(Map<String, dynamic> json) =>
      AddDoctorRequestModel(
        doctorName: json["doctor_name"],
        doctorEmail: json["doctor_email"],
        doctorPhone: json["doctor_phone"],
        doctorSpecialist: json["doctor_specialist"],
        address: json["address"],
        photo: json["photo"],
        sip: json["sip"],
        idIhs: json["id_ihs"],
        nik: json["nik"],
        polyclinic: json["polyclinic"],
      );

  Map<String, dynamic> toMap() => {
        "doctor_name": doctorName,
        "doctor_email": doctorEmail,
        "doctor_phone": doctorPhone,
        "doctor_specialist": doctorSpecialist,
        "address": address,
        "photo": photo,
        "sip": sip,
        "id_ihs": idIhs,
        "nik": nik,
        "polyclinic": polyclinic,
      };
}
