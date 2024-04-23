import 'dart:convert';

import 'package:clinic_management_app/core/constants/variables.dart';
import 'package:clinic_management_app/features/auth/data/datasources/auth_local_datasources.dart';
import 'package:clinic_management_app/features/auth/data/models/responses/auth_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasources {
  Future<Either<String, AuthResponseModel>> login(
      String email, String password) async {
    final url = Uri.parse('${Variables.baseUrl}/api/login');
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      await AuthLocalDatasources()
          .saveAuthData(AuthResponseModel.fromJson(response.body));
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left(json.decode(response.body)['message']);
    }
  }

  //register with http
  Future<Either<String, String>> register(String name, String email,
      String password, String phone, String role) async {
    final url = Uri.parse('${Variables.baseUrl}/api/register');
    final response = await http.post(
      url,
      body: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'role': role,
      },
    );

    if (response.statusCode == 200) {
      return const Right('Register Success');
    } else {
      return Left(json.decode(response.body)['message']);
    }
  }

  //logout with http
  Future<Either<String, String>> logout() async {
    final authDataModel = await AuthLocalDatasources().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/logout');
    final response = await http.post(url, headers: {
      'Authorization': 'Bearer ${authDataModel?.token}',
    });

    if (response.statusCode == 200) {
      await AuthLocalDatasources().removeAuthData();
      return const Right('Logout Success');
    } else {
      return Left(json.decode(response.body)['message']);
    }
  }
}
