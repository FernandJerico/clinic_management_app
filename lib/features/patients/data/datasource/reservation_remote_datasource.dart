import 'dart:convert';

import 'package:clinic_management_app/features/master/data/models/response/doctor_schedule_response_model.dart';
import 'package:clinic_management_app/features/master/data/models/response/master_patient_response_model.dart';
import 'package:clinic_management_app/features/patients/data/model/request/add_reservation_request_model.dart';
import 'package:clinic_management_app/features/patients/data/model/response/history_reservation_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/variables.dart';
import '../../../auth/data/datasources/auth_local_datasources.dart';

class ReservationRemoteDatasource {
  Future<Either<String, String>> createReservation(
      CreateReservationRequestModel data) async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/api-reservations');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${authData?.token}',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: data.toJson(),
    );

    if (response.statusCode == 201) {
      return const Right('Success add reservation');
    } else {
      try {
        final responseBody = json.decode(response.body);
        final message = responseBody['message'];
        if (message is List) {
          return Left(message.join(', '));
        } else if (message is String) {
          return Left(message);
        } else {
          return const Left('An unknown error occurred.');
        }
      } catch (e) {
        return const Left('Failed to parse error message.');
      }
    }
  }

  Future<Either<String, HistoryReservationResponseModel>>
      getHistoryReservation() async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/api-reservations');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${authData?.token}',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Right(HistoryReservationResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get history reservation');
    }
  }

  Future<Either<String, HistoryReservationResponseModel>>
      getHistoryReservationByName(String name) async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url =
        Uri.parse('${Variables.baseUrl}/api/api-reservations?fullname=$name');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${authData?.token}',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Right(HistoryReservationResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get history reservation');
    }
  }

  Future<Either<String, MasterPatientResponseModel>> getPatient() async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/api-patients-patient');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${authData?.token}',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Right(MasterPatientResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get patient data');
    }
  }

  Future<Either<String, DoctorScheduleResponseModel>> getDoctorSchedules(
      String doctorId) async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url = Uri.parse(
        '${Variables.baseUrl}/api/api-doctor-schedules?doctor_id=$doctorId');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${authData?.token}',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Right(DoctorScheduleResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get doctor schedules');
    }
  }
}
