import 'package:clinic_management_app/core/constants/variables.dart';
import 'package:clinic_management_app/features/satusehat/data/datasources/satusehat_remote_datasources.dart';
import 'package:clinic_management_app/features/satusehat/data/models/response/province_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class SatusehatMasterWilayahRemoteDatasources {
  final dio = Dio();
  Future<Either<String, ProvinceResponseModel>> getProvince() async {
    final tokenResult = await SatusehatRemoteDatasources().satuSehatToken();
    final token = tokenResult.fold((l) => '', (r) => r);
    final response = await dio.request(
      '${Variables.satuSehatUrl}/masterdata/v1/provinces?codes',
      options: Options(method: 'GET', headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }),
    );

    if (response.statusCode == 200) {
      return Right(ProvinceResponseModel.fromMap(response.data));
    } else {
      return const Left('Failed to get province data');
    }
  }
}
