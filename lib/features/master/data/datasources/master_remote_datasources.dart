import 'dart:convert';

import 'package:clinic_management_app/core/constants/variables.dart';
import 'package:clinic_management_app/features/auth/data/datasources/auth_local_datasources.dart';
import 'package:clinic_management_app/features/master/data/models/request/add_doctor_request_model.dart';
import 'package:clinic_management_app/features/master/data/models/request/service_medicines_request_model.dart';
import 'package:clinic_management_app/features/master/data/models/response/doctor_schedule_response_model.dart';
import 'package:clinic_management_app/features/master/data/models/response/master_doctor_response_model.dart';
import 'package:clinic_management_app/features/master/data/models/response/master_reservation_response_model.dart';
import 'package:clinic_management_app/features/master/data/models/response/service_medicine_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../models/request/add_patient_request_model.dart';
import '../models/response/master_patient_response_model.dart';

class MasterRemoteDatasources {
  Future<Either<String, MasterDoctorResponseModel>> getDoctors() async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/api-doctors');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${authData?.token}',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      return Right(MasterDoctorResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get doctors');
    }
  }

  Future<Either<String, MasterDoctorResponseModel>> getDoctorByName(
      String name) async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/api-doctors?name=$name');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${authData?.token}',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      return Right(MasterDoctorResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get doctor');
    }
  }

  Future<Either<String, MasterPatientResponseModel>> getPatients() async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/api-patients');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${authData?.token}',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      return Right(MasterPatientResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get patients');
    }
  }

  Future<Either<String, String>> addDoctor(AddDoctorRequestModel data) async {
    final authData = await AuthLocalDatasources().getAuthData();
    var headers = {
      'Authorization': 'Bearer ${authData?.token}',
      'Accept': 'application/json',
    };

    final url = Uri.parse('${Variables.baseUrl}/api/api-doctors');
    final request = http.MultipartRequest('POST', url);
    request.headers.addAll(headers);

    // Tambahkan field dengan addField
    request.fields['doctor_name'] = data.doctorName!;
    request.fields['doctor_specialist'] = data.doctorSpecialist!;
    request.fields['doctor_phone'] = data.doctorPhone!;
    request.fields['doctor_email'] = data.doctorEmail!;
    request.fields['sip'] = data.sip!;
    request.fields['id_ihs'] = data.idIhs!;
    request.fields['nik'] = data.nik!;
    request.fields['polyclinic'] = data.polyclinic!;
    request.fields['address'] = data.address!;

    // Tambahkan file dengan addFile
    request.files.add(
      await http.MultipartFile.fromPath('photo', data.photo!.path),
    );

    // Kirim request
    http.StreamedResponse response = await request.send();

    // Tangani respons
    if (response.statusCode == 201) {
      return const Right('Success add doctor');
    } else {
      return Left(response.reasonPhrase!);
    }
  }

  Future<Either<String, String>> editDoctor(
      AddDoctorRequestModel data, String doctorId) async {
    final authData = await AuthLocalDatasources().getAuthData();
    var headers = {
      'Authorization': 'Bearer ${authData?.token}',
      'Accept': 'application/json',
    };

    final url = Uri.parse('${Variables.baseUrl}/api/api-doctors/$doctorId');
    final request = http.MultipartRequest('PUT', url);
    request.headers.addAll(headers);

    request.fields['doctor_name'] = data.doctorName!;
    request.fields['doctor_specialist'] = data.doctorSpecialist!;
    request.fields['doctor_phone'] = data.doctorPhone!;
    request.fields['doctor_email'] = data.doctorEmail!;
    request.fields['sip'] = data.sip!;
    request.fields['id_ihs'] = data.idIhs!;
    request.fields['nik'] = data.nik!;
    request.fields['polyclinic'] = data.polyclinic!;
    request.fields['address'] = data.address!;

    if (data.photo != null) {
      request.files.add(
        await http.MultipartFile.fromPath('photo', data.photo!.path),
      );
    } else if (data.photo == null) {
      request.fields['photo'] = data.photo!.path;
    }

    // Kirim request
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return const Right('Success edit doctor');
    } else {
      return Left(response.reasonPhrase!);
    }
  }

  Future<Either<String, String>> deleteDoctor(String doctorId) async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/api-doctors/$doctorId');
    final response = await http.delete(url, headers: {
      'Authorization': 'Bearer ${authData?.token}',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      return const Right('Success delete doctor');
    } else {
      try {
        final responseBody = json.decode(response.body);
        var message = responseBody['message'];

        return Left(message);
      } catch (e) {
        return const Left('Failed to parse error message.');
      }
    }
  }

  Future<Either<String, MasterPatientResponseModel>> getPatientByNIK(
      String nik) async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/api-patients?nik=$nik');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${authData?.token}',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      return Right(MasterPatientResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get patient');
    }
  }

  Future<Either<String, DoctorScheduleResponseModel>>
      getDoctorSchedule() async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/api-doctor-schedules');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${authData?.token}',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      return Right(DoctorScheduleResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get doctor schedule');
    }
  }

  Future<Either<String, DoctorScheduleResponseModel>>
      getDoctorScheduleByDoctorName(String name) async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url =
        Uri.parse('${Variables.baseUrl}/api/api-doctor-schedules?name=$name');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${authData?.token}',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      return Right(DoctorScheduleResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get doctor schedule');
    }
  }

  Future<Either<String, ServiceMedicineResponseModel>>
      getServiceMedicines() async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/api-service-medicines');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${authData?.token}',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      return Right(ServiceMedicineResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get service medicines');
    }
  }

  Future<Either<String, ServiceMedicineResponseModel>> getServiceMedicineByName(
      String name) async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url =
        Uri.parse('${Variables.baseUrl}/api/api-service-medicines?name=$name');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${authData?.token}',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      return Right(ServiceMedicineResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get service medicines');
    }
  }

  Future<Either<String, String>> addServiceMedicines(
      ServiceMedicinesRequestModel data) async {
    final authData = await AuthLocalDatasources().getAuthData();
    var headers = {
      'Authorization': 'Bearer ${authData?.token}',
      'Accept': 'application/json',
    };

    final url = Uri.parse('${Variables.baseUrl}/api/api-service-medicines');
    final request = http.MultipartRequest('POST', url);
    request.headers.addAll(headers);

    // Tambahkan field dengan addField
    request.fields['name'] = data.name!;
    request.fields['category'] = data.category!;
    request.fields['price'] = data.price!;
    request.fields['quantity'] = data.quantity!;

    // Tambahkan file dengan addFile
    request.files.add(
      await http.MultipartFile.fromPath('photo', data.photo!.path),
    );

    // Kirim request
    http.StreamedResponse response = await request.send();

    // Tangani respons
    if (response.statusCode == 201) {
      return const Right('Success add service medicines');
    } else {
      return Left(response.reasonPhrase!);
    }
  }

  Future<Either<String, String>> editServiceMedicines(
      ServiceMedicinesRequestModel data, String serviceId) async {
    final authData = await AuthLocalDatasources().getAuthData();
    var headers = {
      'Authorization': 'Bearer ${authData?.token}',
      'Accept': 'application/json',
    };

    final url =
        Uri.parse('${Variables.baseUrl}/api/api-service-medicines/$serviceId');
    final request = http.MultipartRequest('PUT', url);
    request.headers.addAll(headers);

    // Tambahkan field dengan addField
    request.fields['name'] = data.name!;
    request.fields['category'] = data.category!;
    request.fields['price'] = data.price!;
    request.fields['quantity'] = data.quantity!;

    // Tambahkan file dengan addFile
    request.files.add(
      await http.MultipartFile.fromPath('photo', data.photo!.path),
    );

    // Kirim request
    http.StreamedResponse response = await request.send();

    // Tangani respons
    if (response.statusCode == 200) {
      return const Right('Success update service medicines');
    } else {
      return Left(response.reasonPhrase!);
    }
  }

  Future<Either<String, String>> deleteServiceMedicines(
      String serviceId) async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url =
        Uri.parse('${Variables.baseUrl}/api/api-service-medicines/$serviceId');
    final response = await http.delete(url, headers: {
      'Authorization': 'Bearer ${authData?.token}',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      return const Right('Success delete service medicines');
    } else {
      try {
        final responseBody = json.decode(response.body);
        var message = responseBody['message'];

        return Left(message);
      } catch (e) {
        return const Left('Failed to parse error message.');
      }
    }
  }

  Future<Either<String, String>> addPatient(AddPatientRequestModel data) async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/api-patients');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${authData?.token}',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: data.toJson(),
    );
    if (response.statusCode == 200) {
      return const Right('Success add patient');
    } else {
      return const Left('Failed to get patients');
    }
  }

  Future<Either<String, MasterReservationResponseModel>>
      getReservationData() async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/api-reservations-admin');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${authData?.token}',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      return Right(MasterReservationResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get reservation data');
    }
  }

  Future<Either<String, MasterReservationResponseModel>>
      getReservationDataByName(String name) async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url = Uri.parse(
        '${Variables.baseUrl}/api/api-reservations-admin?fullname=$name');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${authData?.token}',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      return Right(MasterReservationResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get reservation data');
    }
  }

  Future<Either<String, String>> acceptReservation(String reservationId,
      String patientId, String status, String message) async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url =
        Uri.parse('${Variables.baseUrl}/api/api-reservations/$reservationId');
    final response = await http.put(url, body: {
      'patient_id': patientId,
      'status': status,
      'note': message,
    }, headers: {
      'Authorization': 'Bearer ${authData?.token}',
      'Accept': 'application/json'
    });

    if (response.statusCode == 200) {
      return const Right('Success to accept reservation');
    } else {
      try {
        final responseBody = json.decode(response.body);
        var message = responseBody['message'];

        return Left(message);
      } catch (e) {
        return const Left('Failed to parse error message.');
      }
    }
  }

  Future<Either<String, String>> rejectReservation(
      String reservationId, String status, String message) async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url =
        Uri.parse('${Variables.baseUrl}/api/api-reservations/$reservationId');
    final response = await http.put(url, body: {
      'status': status,
      'note': message,
    }, headers: {
      'Authorization': 'Bearer ${authData?.token}',
      'Accept': 'application/json'
    });
    if (response.statusCode == 200) {
      return const Right('Success to reject reservation');
    } else {
      try {
        final responseBody = json.decode(response.body);
        var message = responseBody['message'];

        return Left(message);
      } catch (e) {
        return const Left('Failed to parse error message.');
      }
    }
  }
}
