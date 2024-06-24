import 'dart:convert';

class GetMedicalRecordsResponseModel {
  final String? status;
  final String? message;
  final List<MedicalRecord>? data;

  GetMedicalRecordsResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetMedicalRecordsResponseModel.fromJson(String str) =>
      GetMedicalRecordsResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetMedicalRecordsResponseModel.fromMap(Map<String, dynamic> json) =>
      GetMedicalRecordsResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<MedicalRecord>.from(
                json["data"]!.map((x) => MedicalRecord.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class MedicalRecord {
  final int? id;
  final int? patientId;
  final int? doctorId;
  final int? patientScheduleId;
  final String? diagnosis;
  final String? medicalTreatments;
  final String? doctorNotes;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Doctor? doctor;
  final Patient? patient;
  final List<MedicalRecordService>? medicalRecordServices;
  final PatientSchedule? patientSchedule;

  MedicalRecord({
    this.id,
    this.patientId,
    this.doctorId,
    this.patientScheduleId,
    this.diagnosis,
    this.medicalTreatments,
    this.doctorNotes,
    this.createdAt,
    this.updatedAt,
    this.doctor,
    this.patient,
    this.medicalRecordServices,
    this.patientSchedule,
  });

  factory MedicalRecord.fromJson(String str) =>
      MedicalRecord.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MedicalRecord.fromMap(Map<String, dynamic> json) => MedicalRecord(
        id: json["id"],
        patientId: json["patient_id"],
        doctorId: json["doctor_id"],
        patientScheduleId: json["patient_schedule_id"],
        diagnosis: json["diagnosis"],
        medicalTreatments: json["medical_treatments"],
        doctorNotes: json["doctor_notes"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        doctor: json["doctor"] == null ? null : Doctor.fromMap(json["doctor"]),
        patient:
            json["patient"] == null ? null : Patient.fromMap(json["patient"]),
        medicalRecordServices: json["medical_record_services"] == null
            ? []
            : List<MedicalRecordService>.from(json["medical_record_services"]!
                .map((x) => MedicalRecordService.fromMap(x))),
        patientSchedule: json["patient_schedule"] == null
            ? null
            : PatientSchedule.fromMap(json["patient_schedule"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "patient_id": patientId,
        "doctor_id": doctorId,
        "patient_schedule_id": patientScheduleId,
        "diagnosis": diagnosis,
        "medical_treatments": medicalTreatments,
        "doctor_notes": doctorNotes,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "doctor": doctor?.toMap(),
        "patient": patient?.toMap(),
        "medical_record_services": medicalRecordServices == null
            ? []
            : List<dynamic>.from(medicalRecordServices!.map((x) => x.toMap())),
        "patient_schedule": patientSchedule?.toMap(),
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

class MedicalRecordService {
  final int? id;
  final int? medicalRecordId;
  final int? serviceMedicineId;
  final int? quantity;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MedicalRecordService({
    this.id,
    this.medicalRecordId,
    this.serviceMedicineId,
    this.quantity,
    this.createdAt,
    this.updatedAt,
  });

  factory MedicalRecordService.fromJson(String str) =>
      MedicalRecordService.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MedicalRecordService.fromMap(Map<String, dynamic> json) =>
      MedicalRecordService(
        id: json["id"],
        medicalRecordId: json["medical_record_id"],
        serviceMedicineId: json["service_medicine_id"],
        quantity: json["quantity"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "medical_record_id": medicalRecordId,
        "service_medicine_id": serviceMedicineId,
        "quantity": quantity,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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

class PatientSchedule {
  final int? id;
  final int? patientId;
  final int? doctorId;
  final DateTime? scheduleTime;
  final String? complaint;
  final String? status;
  final int? queueNumber;
  final dynamic paymentMethod;
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
