import 'dart:convert';

import 'package:clinic_management_app/core/constants/variables.dart';
import 'package:clinic_management_app/features/auth/data/datasources/auth_local_datasources.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class SatusehatRemoteDatasources {
  Future<Either<String, String>> satuSehatToken() async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/satusehat-token');

    final response = await http.post(url, headers: {
      'Authorization': 'Bearer ${authData?.token}',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      return Right(json.decode(response.body)['token']);
    } else {
      return const Left('Gagal mendapatkan token satu sehat');
    }
  }
}
