import 'package:clinic_management_app/core/constants/variables.dart';
import 'package:clinic_management_app/features/auth/data/datasources/auth_local_datasources.dart';
import 'package:clinic_management_app/features/master/data/models/response/doctor_schedule_response_model.dart';
import 'package:clinic_management_app/features/master/data/models/response/master_doctor_response_model.dart';
import 'package:clinic_management_app/features/master/data/models/response/service_medicine_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

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
        Uri.parse('${Variables.baseUrl}/api/api-service-medicines?=$name');
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
}
