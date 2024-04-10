import 'dart:convert';

class AddPatientRequestModel {
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
  final String? rt;
  final String? rw;
  final String? postalCode;
  final String? maritalStatus;
  final String? relationshipName;
  final String? relationshipPhone;

  AddPatientRequestModel({
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
    this.rt,
    this.rw,
    this.postalCode,
    this.maritalStatus,
    this.relationshipName,
    this.relationshipPhone,
  });

  factory AddPatientRequestModel.fromJson(String str) =>
      AddPatientRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddPatientRequestModel.fromMap(Map<String, dynamic> json) =>
      AddPatientRequestModel(
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
        rt: json["rt"],
        rw: json["rw"],
        postalCode: json["postal_code"],
        maritalStatus: json["marital_status"],
        relationshipName: json["relationship_name"],
        relationshipPhone: json["relationship_phone"],
      );

  Map<String, dynamic> toMap() => {
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
        "rt": rt,
        "rw": rw,
        "postal_code": postalCode,
        "marital_status": maritalStatus,
        "relationship_name": relationshipName,
        "relationship_phone": relationshipPhone,
      };
}
