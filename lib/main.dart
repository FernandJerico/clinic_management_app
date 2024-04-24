import 'package:clinic_management_app/features/auth/data/datasources/auth_local_datasources.dart';
import 'package:clinic_management_app/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:clinic_management_app/features/auth/presentation/pages/login_screen.dart';
import 'package:clinic_management_app/features/master/data/datasources/master_remote_datasources.dart';
import 'package:clinic_management_app/features/master/data/datasources/patient_remote_datasources.dart';
import 'package:clinic_management_app/features/master/presentation/bloc/data_doctor/data_doctor_bloc.dart';
import 'package:clinic_management_app/features/navbar/presentation/pages/navbar_screen.dart';
import 'package:clinic_management_app/features/patient-schedule/data/datasources/medical_records_remote_datasource.dart';
import 'package:clinic_management_app/features/satusehat/data/datasources/satusehat_master_wilayah_remote_datasources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/themes/colors.dart';
import 'features/auth/presentation/bloc/login/login_bloc.dart';
import 'features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'features/master/presentation/bloc/add_patient/add_patient_bloc.dart';
import 'features/master/presentation/bloc/add_reservation/add_reservation_bloc.dart';
import 'features/master/presentation/bloc/data_doctor_schedule/data_doctor_schedule_bloc.dart';
import 'features/master/presentation/bloc/data_patient/data_patient_bloc.dart';
import 'features/master/presentation/bloc/data_service_medicine/data_service_medicine_bloc.dart';
import 'features/patient-schedule/data/datasources/patient_schedule_remote_datasources.dart';
import 'features/patient-schedule/presentation/bloc/create_medical_record/create_medical_record_bloc.dart';
import 'features/patient-schedule/presentation/bloc/patient_schedule/patient_schedule_bloc.dart';
import 'features/satusehat/presentation/bloc/city/city_bloc.dart';
import 'features/satusehat/presentation/bloc/district/district_bloc.dart';
import 'features/satusehat/presentation/bloc/province/province_bloc.dart';
import 'features/satusehat/presentation/bloc/sub-district/sub_district_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasources()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDatasources()),
        ),
        BlocProvider(
          create: (context) => DataDoctorBloc(MasterRemoteDatasources()),
        ),
        BlocProvider(
          create: (context) => DataPatientBloc(MasterRemoteDatasources()),
        ),
        BlocProvider(
          create: (context) =>
              DataDoctorScheduleBloc(MasterRemoteDatasources()),
        ),
        BlocProvider(
          create: (context) =>
              DataServiceMedicineBloc(MasterRemoteDatasources()),
        ),
        BlocProvider(
          create: (context) =>
              ProvinceBloc(SatusehatMasterWilayahRemoteDatasources()),
        ),
        BlocProvider(
          create: (context) =>
              CityBloc(SatusehatMasterWilayahRemoteDatasources()),
        ),
        BlocProvider(
          create: (context) =>
              DistrictBloc(SatusehatMasterWilayahRemoteDatasources()),
        ),
        BlocProvider(
          create: (context) =>
              SubDistrictBloc(SatusehatMasterWilayahRemoteDatasources()),
        ),
        BlocProvider(
          create: (context) => AddPatientBloc(MasterRemoteDatasources()),
        ),
        BlocProvider(
          create: (context) => AddReservationBloc(PatientRemoteDatasources()),
        ),
        BlocProvider(
          create: (context) =>
              PatientScheduleBloc(PatientScheduleRemoteDatasources()),
        ),
        BlocProvider(
          create: (context) =>
              CreateMedicalRecordBloc(MedicalRecordsRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
        title: 'Clinic Management App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            color: AppColors.white,
            elevation: 0,
            titleTextStyle: GoogleFonts.quicksand(
              color: AppColors.primary,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
            iconTheme: const IconThemeData(
              color: AppColors.primary,
            ),
          ),
        ),
        home: FutureBuilder(
          future: AuthLocalDatasources().isUserLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              if (snapshot.hasData && snapshot.data == true) {
                return const NavbarScreen();
              } else {
                return const LoginScreen();
              }
            }
          },
        ),
      ),
    );
  }
}
