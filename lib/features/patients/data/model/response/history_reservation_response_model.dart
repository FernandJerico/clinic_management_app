import 'dart:convert';

class HistoryReservationResponseModel {
  final String? status;
  final String? message;
  final List<HistoryReservation>? data;

  HistoryReservationResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory HistoryReservationResponseModel.fromJson(String str) =>
      HistoryReservationResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HistoryReservationResponseModel.fromMap(Map<String, dynamic> json) =>
      HistoryReservationResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<HistoryReservation>.from(
                json["data"]!.map((x) => HistoryReservation.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class HistoryReservation {
  final int? id;
  final int? userId;
  final int? patientId;
  final String? phone;
  final int? doctorId;
  final DateTime? dayAppointment;
  final String? timeAppointment;
  final String? guarantor;
  final dynamic bpjsNumber;
  final String? status;
  final dynamic note;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;
  final Doctor? doctor;
  final Patient? patient;

  HistoryReservation({
    this.id,
    this.userId,
    this.patientId,
    this.phone,
    this.doctorId,
    this.dayAppointment,
    this.timeAppointment,
    this.guarantor,
    this.bpjsNumber,
    this.status,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.doctor,
    this.patient,
  });

  factory HistoryReservation.fromJson(String str) =>
      HistoryReservation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HistoryReservation.fromMap(Map<String, dynamic> json) =>
      HistoryReservation(
        id: json["id"],
        userId: json["user_id"],
        patientId: json["patient_id"],
        phone: json["phone"],
        doctorId: json["doctor_id"],
        dayAppointment: json["day_appointment"] == null
            ? null
            : DateTime.parse(json["day_appointment"]),
        timeAppointment: json["time_appointment"],
        guarantor: json["guarantor"],
        bpjsNumber: json["bpjs_number"],
        status: json["status"],
        note: json["note"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        doctor: json["doctor"] == null ? null : Doctor.fromMap(json["doctor"]),
        patient:
            json["patient"] == null ? null : Patient.fromMap(json["patient"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "patient_id": patientId,
        "phone": phone,
        "doctor_id": doctorId,
        "day_appointment":
            "${dayAppointment!.year.toString().padLeft(4, '0')}-${dayAppointment!.month.toString().padLeft(2, '0')}-${dayAppointment!.day.toString().padLeft(2, '0')}",
        "time_appointment": timeAppointment,
        "guarantor": guarantor,
        "bpjs_number": bpjsNumber,
        "status": status,
        "note": note,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toMap(),
        "doctor": doctor?.toMap(),
        "patient": patient?.toMap(),
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

class Patient {
  final int? id;
  final String? nik;
  final String? kk;
  final String? name;
  final String? phone;
  final String? email;
  final String? gender;
  final String? birthPlace;
  final DateTime? birthDate;
  final int? isDeceased;
  final String? addressLine;
  final String? city;
  final String? cityCode;
  final String? province;
  final String? provinceCode;
  final String? district;
  final String? districtCode;
  final String? village;
  final String? villageCode;
  final String? rt;
  final String? rw;
  final String? postalCode;
  final String? maritalStatus;
  final String? relationshipName;
  final String? relationshipPhone;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? userId;

  Patient({
    this.id,
    this.nik,
    this.kk,
    this.name,
    this.phone,
    this.email,
    this.gender,
    this.birthPlace,
    this.birthDate,
    this.isDeceased,
    this.addressLine,
    this.city,
    this.cityCode,
    this.province,
    this.provinceCode,
    this.district,
    this.districtCode,
    this.village,
    this.villageCode,
    this.rt,
    this.rw,
    this.postalCode,
    this.maritalStatus,
    this.relationshipName,
    this.relationshipPhone,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  factory Patient.fromJson(String str) => Patient.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Patient.fromMap(Map<String, dynamic> json) => Patient(
        id: json["id"],
        nik: json["nik"],
        kk: json["kk"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        gender: json["gender"],
        birthPlace: json["birth_place"],
        birthDate: json["birth_date"] == null
            ? null
            : DateTime.parse(json["birth_date"]),
        isDeceased: json["is_deceased"],
        addressLine: json["address_line"],
        city: json["city"],
        cityCode: json["city_code"],
        province: json["province"],
        provinceCode: json["province_code"],
        district: json["district"],
        districtCode: json["district_code"],
        village: json["village"],
        villageCode: json["village_code"],
        rt: json["rt"],
        rw: json["rw"],
        postalCode: json["postal_code"],
        maritalStatus: json["marital_status"],
        relationshipName: json["relationship_name"],
        relationshipPhone: json["relationship_phone"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nik": nik,
        "kk": kk,
        "name": name,
        "phone": phone,
        "email": email,
        "gender": gender,
        "birth_place": birthPlace,
        "birth_date":
            "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
        "is_deceased": isDeceased,
        "address_line": addressLine,
        "city": city,
        "city_code": cityCode,
        "province": province,
        "province_code": provinceCode,
        "district": district,
        "district_code": districtCode,
        "village": village,
        "village_code": villageCode,
        "rt": rt,
        "rw": rw,
        "postal_code": postalCode,
        "marital_status": maritalStatus,
        "relationship_name": relationshipName,
        "relationship_phone": relationshipPhone,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user_id": userId,
      };
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final DateTime? emailVerifiedAt;
  final dynamic twoFactorSecret;
  final dynamic twoFactorRecoveryCodes;
  final dynamic twoFactorConfirmedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? phone;
  final String? role;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.twoFactorSecret,
    this.twoFactorRecoveryCodes,
    this.twoFactorConfirmedAt,
    this.createdAt,
    this.updatedAt,
    this.phone,
    this.role,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        twoFactorSecret: json["two_factor_secret"],
        twoFactorRecoveryCodes: json["two_factor_recovery_codes"],
        twoFactorConfirmedAt: json["two_factor_confirmed_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        phone: json["phone"],
        role: json["role"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "two_factor_secret": twoFactorSecret,
        "two_factor_recovery_codes": twoFactorRecoveryCodes,
        "two_factor_confirmed_at": twoFactorConfirmedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "phone": phone,
        "role": role,
      };
}
