// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CityBbResponseModel {
  final String? code;
  final String? messages;
  final List<CityBB>? value;

  CityBbResponseModel({
    this.code,
    this.messages,
    this.value,
  });

  factory CityBbResponseModel.fromJson(String str) =>
      CityBbResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CityBbResponseModel.fromMap(Map<String, dynamic> json) =>
      CityBbResponseModel(
        code: json["code"],
        messages: json["messages"],
        value: json["value"] == null
            ? []
            : List<CityBB>.from(json["value"]!.map((x) => CityBB.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "messages": messages,
        "value": value == null
            ? []
            : List<dynamic>.from(value!.map((x) => x.toMap())),
      };
}

class CityBB {
  final String? id;
  final String? idProvinsi;
  final String? name;

  CityBB({
    this.id,
    this.idProvinsi,
    this.name,
  });

  factory CityBB.fromJson(String str) => CityBB.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CityBB.fromMap(Map<String, dynamic> json) => CityBB(
        id: json["id"],
        idProvinsi: json["id_provinsi"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "id_provinsi": idProvinsi,
        "name": name,
      };

  @override
  String toString() => '$name';
}
