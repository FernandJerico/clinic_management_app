import 'package:clinic_management_app/core/constants/variables.dart';
import 'package:clinic_management_app/features/auth/data/datasources/auth_local_datasources.dart';
import 'package:clinic_management_app/features/history/data/models/response/history_transaction_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class HistoryTransactionRemoteDatasource {
  Future<Either<String, HistoryTransactionlResponseModel>>
      getHistoryTransaction() async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/api-payment-details');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${authData?.token}',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Right(HistoryTransactionlResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get history transaction');
    }
  }

  Future<Either<String, HistoryTransactionlResponseModel>>
      getHistoryTransactionByName(String name) async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url =
        Uri.parse('${Variables.baseUrl}/api/api-payment-details?name=$name');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${authData?.token}',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Right(HistoryTransactionlResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get history transaction');
    }
  }
}
