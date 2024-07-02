import 'dart:convert';

class GetCountPatientResponseModel {
  final String? status;
  final String? message;
  final int? countPatient;

  GetCountPatientResponseModel({
    this.status,
    this.message,
    this.countPatient,
  });

  factory GetCountPatientResponseModel.fromJson(String str) =>
      GetCountPatientResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetCountPatientResponseModel.fromMap(Map<String, dynamic> json) =>
      GetCountPatientResponseModel(
        status: json["status"],
        message: json["message"],
        countPatient: json["countPatient"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "countPatient": countPatient,
      };
}
