import 'dart:convert';

import 'package:clinic_management_app/core/constants/variables.dart';
import 'package:clinic_management_app/features/auth/data/datasources/auth_local_datasources.dart';
import 'package:clinic_management_app/features/home/data/models/response/get_count_patient_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class DashboardMasterDatasource {
  final dio = Dio();
  Future<Either<String, GetCountPatientResponseModel>>
      getCountPatientThisMonth() async {
    final authData = await AuthLocalDatasources().getAuthData();
    final response = await dio.get(
      '${Variables.baseUrl}/api/api-patient-this-month',
      options: Options(method: 'GET', headers: {
        'Authorization': 'Bearer ${authData?.token}',
        'Accept': 'application/json',
      }),
    );

    if (response.statusCode == 200) {
      return Right(GetCountPatientResponseModel.fromMap(response.data));
    } else {
      try {
        final responseBody = json.decode(response.data);
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

  Future<Either<String, GetCountPatientResponseModel>>
      getCountPatientLastMonth() async {
    final authData = await AuthLocalDatasources().getAuthData();
    final response = await dio.get(
      '${Variables.baseUrl}/api/api-patient-last-month',
      options: Options(method: 'GET', headers: {
        'Authorization': 'Bearer ${authData?.token}',
        'Accept': 'application/json',
      }),
    );

    if (response.statusCode == 200) {
      return Right(GetCountPatientResponseModel.fromMap(response.data));
    } else {
      try {
        final responseBody = json.decode(response.data);
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

  Future<Either<String, GetCountPatientResponseModel>>
      getCountPatientTotal() async {
    final authData = await AuthLocalDatasources().getAuthData();
    final response = await dio.get(
      '${Variables.baseUrl}/api/api-total-patient',
      options: Options(method: 'GET', headers: {
        'Authorization': 'Bearer ${authData?.token}',
        'Accept': 'application/json',
      }),
    );

    if (response.statusCode == 200) {
      return Right(GetCountPatientResponseModel.fromMap(response.data));
    } else {
      try {
        final responseBody = json.decode(response.data);
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
}
