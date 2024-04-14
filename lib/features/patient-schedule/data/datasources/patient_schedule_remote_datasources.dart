import 'package:clinic_management_app/features/patient-schedule/data/models/response/patient_schedule_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/variables.dart';
import '../../../auth/data/datasources/auth_local_datasources.dart';

class PatientScheduleRemoteDatasources {
  Future<Either<String, PatientScheduleResponseModel>>
      getPatientSchedules() async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/api-patient-schedules');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${authData?.token}',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Right(PatientScheduleResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get patient schedules');
    }
  }

  Future<Either<String, PatientScheduleResponseModel>> getPatientSchedulesByNIK(
      String nik) async {
    final authData = await AuthLocalDatasources().getAuthData();
    final url =
        Uri.parse('${Variables.baseUrl}/api/api-patient-schedules?nik=$nik');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${authData?.token}',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Right(PatientScheduleResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get patient schedules by nik');
    }
  }
}
