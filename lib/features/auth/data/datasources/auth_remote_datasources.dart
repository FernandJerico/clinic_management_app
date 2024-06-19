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
      try {
        await AuthLocalDatasources()
            .saveAuthData(AuthResponseModel.fromJson(response.body));
        return Right(AuthResponseModel.fromJson(response.body));
      } catch (e) {
        return const Left('Failed to parse authentication data.');
      }
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

  //register with http
  Future<Either<String, String>> register(
      String email, String password, String name, String phone) async {
    final url = Uri.parse('${Variables.baseUrl}/api/register');
    final response = await http.post(url, body: {
      'email': email,
      'name': name,
      'password': password,
      'phone': phone
    }, headers: {
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      try {
        final responseBody = json.decode(response.body);
        var message = responseBody['message'];

        return Right(message);
      } catch (e) {
        return const Right('Failed to parse message.');
      }
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
