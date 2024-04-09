import 'dart:convert';

import 'package:clinic_management_app/core/constants/variables.dart';
import 'package:clinic_management_app/features/auth/data/datasources/auth_local_datasources.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class SatusehatRemoteDatasources {
  Future<Either<String, String>> satuSehatToken() async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/satusehat-token');

    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    });

    if (response.statusCode == 200) {
      return Right(jsonDecode(response.body)['token']);
    } else {
      return const Left('Gagal mendapatkan token satu sehat');
    }
  }
}
