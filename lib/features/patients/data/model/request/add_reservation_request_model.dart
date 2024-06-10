import 'dart:convert';

class CreateReservationRequestModel {
  final String? userId;
  final String? fullname;
  final String? phone;
  final String? gender;
  final DateTime? birthDate;
  final String? polyclinic;
  final String? dayAppointment;
  final String? timeAppointment;

  CreateReservationRequestModel({
    this.userId,
    this.fullname,
    this.phone,
    this.gender,
    this.birthDate,
    this.polyclinic,
    this.dayAppointment,
    this.timeAppointment,
  });

  factory CreateReservationRequestModel.fromJson(String str) =>
      CreateReservationRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateReservationRequestModel.fromMap(Map<String, dynamic> json) =>
      CreateReservationRequestModel(
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
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "fullname": fullname,
        "phone": phone,
        "gender": gender,
        "birth_date":
            "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
        "polyclinic": polyclinic,
        "day_appointment": dayAppointment,
        "time_appointment": timeAppointment,
      };
}
