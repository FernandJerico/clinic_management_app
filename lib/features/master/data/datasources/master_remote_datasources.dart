import 'package:clinic_management_app/core/constants/variables.dart';
import 'package:clinic_management_app/features/auth/data/datasources/auth_local_datasources.dart';
import 'package:clinic_management_app/features/master/data/response/master_doctor_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class MasterRemoteDatasources {
  Future<Either<String, MasterDoctorResponseModel>> getDoctors() async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/api-doctors');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${authData?.token}',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      return Right(MasterDoctorResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get doctors');
    }
  }

  Future<Either<String, MasterDoctorResponseModel>> getDoctorByName(
      String name) async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/api-doctors?name=$name');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${authData?.token}',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      return Right(MasterDoctorResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get doctors');
    }
  }
}
