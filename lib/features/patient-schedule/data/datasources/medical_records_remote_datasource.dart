import 'package:clinic_management_app/features/auth/data/datasources/auth_local_datasources.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/constants/variables.dart';
import '../models/request/create_medical_records_request_model.dart';
import '../models/response/create_medical_records_response_model.dart';
import '../models/response/get_medical_records_response_mode.dart';
import 'package:http/http.dart' as http;

import '../models/response/service_order_response_model.dart';

class MedicalRecordsRemoteDatasource {
  Future<Either<String, GetMedicalRecordsResponseModel>>
      getMedicalRecords() async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/api-medical-records');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${authData?.token}',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Right(GetMedicalRecordsResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get medical records');
    }
  }

  Future<Either<String, CreateMedicalRecordsResponseModel>>
      createMedicalRecordPatient(
          CreateMedicalRecordsRequestModel requestModel) async {
    final authData = await AuthLocalDatasources().getAuthData();

    final url = Uri.parse('${Variables.baseUrl}/api/api-medical-records');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${authData?.token}',
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: requestModel.toJson(),
    );

    if (response.statusCode == 201) {
      return Right(CreateMedicalRecordsResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to create medical record');
    }
  }

  Future<Either<String, ServiceOrderResponseModel>> getServiceOrderByScheduleId(
      int scheduleId) async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url = Uri.parse(
        '${Variables.baseUrl}/api/api-medical-records/services/$scheduleId');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${authData?.token}',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Right(ServiceOrderResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get service order');
    }
  }
}
