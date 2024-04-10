import 'package:clinic_management_app/core/constants/variables.dart';
import 'package:clinic_management_app/features/satusehat/data/datasources/satusehat_remote_datasources.dart';
import 'package:clinic_management_app/features/satusehat/data/models/response/province_response_model.dart';
import 'package:clinic_management_app/features/satusehat/data/models/response/wilayah_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../models/response/city_response_model.dart';

class SatusehatMasterWilayahRemoteDatasources {
  final dio = Dio();
  Future<Either<String, ProvinceResponseModel>> getProvince() async {
    final tokenResult = await SatusehatRemoteDatasources().satuSehatToken();
    final token = tokenResult.fold((l) => l, (r) => r);
    final response = await dio.get(
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

  Future<Either<String, CityResponseModel>> getCities(int provinceCode) async {
    final tokenResult = await SatusehatRemoteDatasources().satuSehatToken();
    final token = tokenResult.fold((l) => l, (r) => r);
    final response = await dio.get(
      '${Variables.satuSehatUrl}/masterdata/v1/cities?province_codes=$provinceCode',
      options: Options(method: 'GET', headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }),
    );

    if (response.statusCode == 200) {
      return Right(CityResponseModel.fromMap(response.data));
    } else {
      return const Left('Failed to get city data');
    }
  }

  Future<Either<String, WilayahResponseModel>> getDistricts(
      int cityCode) async {
    final tokenResult = await SatusehatRemoteDatasources().satuSehatToken();
    final token = tokenResult.fold((l) => l, (r) => r);
    final response = await dio.get(
      '${Variables.satuSehatUrl}/masterdata/v1/districts?city_codes=$cityCode',
      options: Options(method: 'GET', headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }),
    );

    if (response.statusCode == 200) {
      return Right(WilayahResponseModel.fromMap(response.data));
    } else {
      return const Left('Failed to get district data');
    }
  }

  Future<Either<String, WilayahResponseModel>> getSubDistricts(
      int districtCode) async {
    final tokenResult = await SatusehatRemoteDatasources().satuSehatToken();
    final token = tokenResult.fold((l) => l, (r) => r);
    final response = await dio.get(
      '${Variables.satuSehatUrl}/masterdata/v1/sub-districts?district_codes=$districtCode',
      options: Options(method: 'GET', headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }),
    );

    if (response.statusCode == 200) {
      return Right(WilayahResponseModel.fromMap(response.data));
    } else {
      return const Left('Failed to get sub-district data');
    }
  }
}
