// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProvinceBBResponseModel {
  final String? code;
  final String? messages;
  final List<ProvinceBB>? value;

  ProvinceBBResponseModel({
    this.code,
    this.messages,
    this.value,
  });

  factory ProvinceBBResponseModel.fromJson(String str) =>
      ProvinceBBResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProvinceBBResponseModel.fromMap(Map<String, dynamic> json) =>
      ProvinceBBResponseModel(
        code: json["code"],
        messages: json["messages"],
        value: json["value"] == null
            ? []
            : List<ProvinceBB>.from(
                json["value"]!.map((x) => ProvinceBB.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "messages": messages,
        "value": value == null
            ? []
            : List<dynamic>.from(value!.map((x) => x.toMap())),
      };
}

class ProvinceBB {
  final String? id;
  final String? name;

  ProvinceBB({
    this.id,
    this.name,
  });

  factory ProvinceBB.fromJson(String str) =>
      ProvinceBB.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProvinceBB.fromMap(Map<String, dynamic> json) => ProvinceBB(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };

  @override
  String toString() => '$name';
}
