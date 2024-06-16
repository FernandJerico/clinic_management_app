// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SubDistrictBbResponseModel {
  final String? code;
  final String? messages;
  final List<SubDistrictBB>? value;

  SubDistrictBbResponseModel({
    this.code,
    this.messages,
    this.value,
  });

  factory SubDistrictBbResponseModel.fromJson(String str) =>
      SubDistrictBbResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubDistrictBbResponseModel.fromMap(Map<String, dynamic> json) =>
      SubDistrictBbResponseModel(
        code: json["code"],
        messages: json["messages"],
        value: json["value"] == null
            ? []
            : List<SubDistrictBB>.from(
                json["value"]!.map((x) => SubDistrictBB.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "messages": messages,
        "value": value == null
            ? []
            : List<dynamic>.from(value!.map((x) => x.toMap())),
      };
}

class SubDistrictBB {
  final String? id;
  final String? idKecamatan;
  final String? name;

  SubDistrictBB({
    this.id,
    this.idKecamatan,
    this.name,
  });

  factory SubDistrictBB.fromJson(String str) =>
      SubDistrictBB.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubDistrictBB.fromMap(Map<String, dynamic> json) => SubDistrictBB(
        id: json["id"],
        idKecamatan: json["id_kecamatan"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "id_kecamatan": idKecamatan,
        "name": name,
      };

  @override
  String toString() => '$name';
}
