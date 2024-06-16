import 'package:clinic_management_app/features/binderbyte/data/model/response/district_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/variables.dart';
import '../model/response/city_response_model.dart';
import '../model/response/province_response_model.dart';
import '../model/response/sub_district_response_model.dart';

class BinderbyteWilayahRemoteDatasource {
  final dio = Dio();

  Future<Either<String, ProvinceBBResponseModel>> getProvince() async {
    final response = await dio.get(
      '${Variables.binderByteUrl}/wilayah/provinsi?api_key=${Variables.apiKeyBinderByte}',
      options: Options(method: 'GET', headers: {
        'Accept': 'application/json',
      }),
    );

    if (response.statusCode == 200) {
      return Right(ProvinceBBResponseModel.fromMap(response.data));
    } else {
      return const Left('Failed to get province data');
    }
  }

  Future<Either<String, CityBbResponseModel>> getCities(
      String provinceId) async {
    final response = await dio.get(
      '${Variables.binderByteUrl}/wilayah/kabupaten?api_key=${Variables.apiKeyBinderByte}&id_provinsi=$provinceId',
      options: Options(method: 'GET', headers: {
        'Accept': 'application/json',
      }),
    );

    if (response.statusCode == 200) {
      return Right(CityBbResponseModel.fromMap(response.data));
    } else {
      return const Left('Failed to get cities data');
    }
  }

  Future<Either<String, DistrictBbResponseModel>> getDistricts(
      String cityCode) async {
    final response = await dio.get(
      '${Variables.binderByteUrl}/wilayah/kecamatan?api_key=${Variables.apiKeyBinderByte}&id_kabupaten=$cityCode',
      options: Options(method: 'GET', headers: {
        'Accept': 'application/json',
      }),
    );

    if (response.statusCode == 200) {
      return Right(DistrictBbResponseModel.fromMap(response.data));
    } else {
      return const Left('Failed to get district data');
    }
  }

  Future<Either<String, SubDistrictBbResponseModel>> getSubDistrict(
      String districtCode) async {
    final response = await dio.get(
      '${Variables.binderByteUrl}/wilayah/kelurahan?api_key=${Variables.apiKeyBinderByte}&id_kecamatan=$districtCode',
      options: Options(method: 'GET', headers: {
        'Accept': 'application/json',
      }),
    );

    if (response.statusCode == 200) {
      return Right(SubDistrictBbResponseModel.fromMap(response.data));
    } else {
      return const Left('Failed to get sub-district data');
    }
  }
}
