import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/constants/variables.dart';
import '../../../auth/data/datasources/auth_local_datasources.dart';
import 'package:http/http.dart' as http;

import '../models/request/create_payment_detail_request_model.dart';
import '../models/response/create_payment_detail_response_model.dart';

class PaymentDetailRemoteDatasource {
  Future<Either<String, CreatePaymentDetailResponseModel>> createPaymentDetail(
      CreatePaymentDetailRequestModel requestModel) async {
    final authData = await AuthLocalDatasources().getAuthData();

    final url = Uri.parse('${Variables.baseUrl}/api/api-payment-details');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${authData?.token}',
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: requestModel.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(CreatePaymentDetailResponseModel.fromJson(response.body));
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
