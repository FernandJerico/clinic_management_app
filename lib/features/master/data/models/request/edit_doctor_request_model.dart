import 'dart:convert';
import 'dart:io';

class EditDoctorRequestModel {
  final String? doctorName;
  final String? doctorEmail;
  final String? doctorPhone;
  final String? doctorSpecialist;
  final String? address;
  final File? photo;
  final String? sip;
  final String? idIhs;
  final String? nik;
  final String? polyclinic;

  EditDoctorRequestModel({
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

  factory EditDoctorRequestModel.fromJson(String str) =>
      EditDoctorRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EditDoctorRequestModel.fromMap(Map<String, dynamic> json) =>
      EditDoctorRequestModel(
        doctorName: json["doctor_name"],
        doctorEmail: json["doctor_email"],
        doctorPhone: json["doctor_phone"],
        doctorSpecialist: json["doctor_specialist"],
        address: json["address"],
        photo: json["photo"] != null ? File(json["photo"]) : null,
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
        "photo": photo?.path,
        "sip": sip,
        "id_ihs": idIhs,
        "nik": nik,
        "polyclinic": polyclinic,
      };
}
