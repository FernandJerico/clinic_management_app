// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DistrictBbResponseModel {
  final String? code;
  final String? messages;
  final List<DistrictBB>? value;

  DistrictBbResponseModel({
    this.code,
    this.messages,
    this.value,
  });

  factory DistrictBbResponseModel.fromJson(String str) =>
      DistrictBbResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DistrictBbResponseModel.fromMap(Map<String, dynamic> json) =>
      DistrictBbResponseModel(
        code: json["code"],
        messages: json["messages"],
        value: json["value"] == null
            ? []
            : List<DistrictBB>.from(
                json["value"]!.map((x) => DistrictBB.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "messages": messages,
        "value": value == null
            ? []
            : List<dynamic>.from(value!.map((x) => x.toMap())),
      };
}

class DistrictBB {
  final String? id;
  final String? idKabupaten;
  final String? name;

  DistrictBB({
    this.id,
    this.idKabupaten,
    this.name,
  });

  factory DistrictBB.fromJson(String str) =>
      DistrictBB.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DistrictBB.fromMap(Map<String, dynamic> json) => DistrictBB(
        id: json["id"],
        idKabupaten: json["id_kabupaten"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "id_kabupaten": idKabupaten,
        "name": name,
      };

  @override
  String toString() => '$name';
}
