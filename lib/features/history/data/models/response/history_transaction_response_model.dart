import 'dart:convert';

class HistoryTransactionlResponseModel {
  final String? status;
  final String? message;
  final List<HistoryTransaction>? data;

  HistoryTransactionlResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory HistoryTransactionlResponseModel.fromJson(String str) =>
      HistoryTransactionlResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HistoryTransactionlResponseModel.fromMap(Map<String, dynamic> json) =>
      HistoryTransactionlResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<HistoryTransaction>.from(
                json["data"]!.map((x) => HistoryTransaction.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class HistoryTransaction {
  final int? id;
  final int? patientScheduleId;
  final int? patientId;
  final String? paymentMethod;
  final int? totalPrice;
  final DateTime? transactionTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final PatientSchedule? patientSchedule;
  final Patient? patient;

  HistoryTransaction({
    this.id,
    this.patientScheduleId,
    this.patientId,
    this.paymentMethod,
    this.totalPrice,
    this.transactionTime,
    this.createdAt,
    this.updatedAt,
    this.patientSchedule,
    this.patient,
  });

  factory HistoryTransaction.fromJson(String str) =>
      HistoryTransaction.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HistoryTransaction.fromMap(Map<String, dynamic> json) =>
      HistoryTransaction(
        id: json["id"],
        patientScheduleId: json["patient_schedule_id"],
        patientId: json["patient_id"],
        paymentMethod: json["payment_method"],
        totalPrice: json["total_price"],
        transactionTime: json["transaction_time"] == null
            ? null
            : DateTime.parse(json["transaction_time"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        patientSchedule: json["patient_schedule"] == null
            ? null
            : PatientSchedule.fromMap(json["patient_schedule"]),
        patient:
            json["patient"] == null ? null : Patient.fromMap(json["patient"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "patient_schedule_id": patientScheduleId,
        "patient_id": patientId,
        "payment_method": paymentMethod,
        "total_price": totalPrice,
        "transaction_time": transactionTime?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "patient_schedule": patientSchedule?.toMap(),
        "patient": patient?.toMap(),
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
  final String? rt;
  final String? rw;
  final String? postalCode;
  final String? maritalStatus;
  final String? relationshipName;
  final String? relationshipPhone;
  final DateTime? createdAt;
  final DateTime? updatedAt;

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
    this.rt,
    this.rw,
    this.postalCode,
    this.maritalStatus,
    this.relationshipName,
    this.relationshipPhone,
    this.createdAt,
    this.updatedAt,
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
        rt: json["rt"],
        rw: json["rw"],
        postalCode: json["postal_code"],
        maritalStatus: json["marital_status"],
        relationshipName: json["relationship_name"],
        relationshipPhone: json["relationship_phone"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
        "rt": rt,
        "rw": rw,
        "postal_code": postalCode,
        "marital_status": maritalStatus,
        "relationship_name": relationshipName,
        "relationship_phone": relationshipPhone,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class PatientSchedule {
  final int? id;
  final int? patientId;
  final int? doctorId;
  final DateTime? scheduleTime;
  final String? complaint;
  final String? status;
  final int? queueNumber;
  final String? paymentMethod;
  final int? totalPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PatientSchedule({
    this.id,
    this.patientId,
    this.doctorId,
    this.scheduleTime,
    this.complaint,
    this.status,
    this.queueNumber,
    this.paymentMethod,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
  });

  factory PatientSchedule.fromJson(String str) =>
      PatientSchedule.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PatientSchedule.fromMap(Map<String, dynamic> json) => PatientSchedule(
        id: json["id"],
        patientId: json["patient_id"],
        doctorId: json["doctor_id"],
        scheduleTime: json["schedule_time"] == null
            ? null
            : DateTime.parse(json["schedule_time"]),
        complaint: json["complaint"],
        status: json["status"],
        queueNumber: json["queue_number"],
        paymentMethod: json["payment_method"],
        totalPrice: json["total_price"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "patient_id": patientId,
        "doctor_id": doctorId,
        "schedule_time": scheduleTime?.toIso8601String(),
        "complaint": complaint,
        "status": status,
        "queue_number": queueNumber,
        "payment_method": paymentMethod,
        "total_price": totalPrice,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
