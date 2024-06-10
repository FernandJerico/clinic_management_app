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

    if (response.statusCode == 200) {
      return const Right('Success add reservation');
    } else {
      return const Left('Failed to add reservation');
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
}
