import 'dart:convert';

import 'package:clinic_management_app/features/master/data/models/request/add_reservation_request_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/variables.dart';
import '../../../auth/data/datasources/auth_local_datasources.dart';

class PatientRemoteDatasources {
  Future<Either<String, String>> addReservation(
      AddReservationRequestModel data) async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/api-patient-schedules');
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
}
