import 'dart:convert';

class MasterReservationResponseModel {
  final String? status;
  final String? message;
  final List<MasterReservation>? data;

  MasterReservationResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory MasterReservationResponseModel.fromJson(String str) =>
      MasterReservationResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MasterReservationResponseModel.fromMap(Map<String, dynamic> json) =>
      MasterReservationResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<MasterReservation>.from(
                json["data"]!.map((x) => MasterReservation.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class MasterReservation {
  final int? id;
  final int? userId;
  final String? fullname;
  final String? phone;
  final String? gender;
  final DateTime? birthDate;
  final String? polyclinic;
  final String? dayAppointment;
  final String? timeAppointment;
  final String? status;
  final dynamic note;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MasterReservation({
    this.id,
    this.userId,
    this.fullname,
    this.phone,
    this.gender,
    this.birthDate,
    this.polyclinic,
    this.dayAppointment,
    this.timeAppointment,
    this.status,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  factory MasterReservation.fromJson(String str) =>
      MasterReservation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MasterReservation.fromMap(Map<String, dynamic> json) =>
      MasterReservation(
        id: json["id"],
        userId: json["user_id"],
        fullname: json["fullname"],
        phone: json["phone"],
        gender: json["gender"],
        birthDate: json["birth_date"] == null
            ? null
            : DateTime.parse(json["birth_date"]),
        polyclinic: json["polyclinic"],
        dayAppointment: json["day_appointment"],
        timeAppointment: json["time_appointment"],
        status: json["status"],
        note: json["note"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "fullname": fullname,
        "phone": phone,
        "gender": gender,
        "birth_date":
            "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
        "polyclinic": polyclinic,
        "day_appointment": dayAppointment,
        "time_appointment": timeAppointment,
        "status": status,
        "note": note,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
