import 'package:clinic_management_app/features/auth/data/datasources/auth_local_datasources.dart';
import 'package:clinic_management_app/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:clinic_management_app/features/auth/presentation/pages/login_screen.dart';
import 'package:clinic_management_app/features/history/data/datasource/history_transaction_remote_datasource.dart';
import 'package:clinic_management_app/features/master/data/datasources/master_remote_datasources.dart';
import 'package:clinic_management_app/features/master/data/datasources/patient_remote_datasources.dart';
import 'package:clinic_management_app/features/master/presentation/bloc/data_doctor/data_doctor_bloc.dart';
import 'package:clinic_management_app/features/navbar/presentation/pages/navbar_screen.dart';
import 'package:clinic_management_app/features/patient-schedule/data/datasources/medical_records_remote_datasource.dart';
import 'package:clinic_management_app/features/patient-schedule/data/datasources/midtrans_remote_datasource.dart';
import 'package:clinic_management_app/features/patient-schedule/data/datasources/payment_detail_remote_datasource.dart';
import 'package:clinic_management_app/features/patients/data/datasource/article_remote_datasource.dart';
import 'package:clinic_management_app/features/patients/data/datasource/reservation_remote_datasource.dart';
import 'package:clinic_management_app/features/satusehat/data/datasources/satusehat_master_wilayah_remote_datasources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/themes/colors.dart';
import 'features/auth/presentation/bloc/login/login_bloc.dart';
import 'features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'features/auth/presentation/bloc/register/register_bloc.dart';
import 'features/history/presentation/bloc/history_transaction/history_transaction_bloc.dart';
import 'features/master/presentation/bloc/accept_reservation/accept_reservation_bloc.dart';
import 'features/master/presentation/bloc/add_patient/add_patient_bloc.dart';
import 'features/master/presentation/bloc/add_reservation/add_reservation_bloc.dart';
import 'features/master/presentation/bloc/data_doctor_schedule/data_doctor_schedule_bloc.dart';
import 'features/master/presentation/bloc/data_patient/data_patient_bloc.dart';
import 'features/master/presentation/bloc/data_reservation/data_reservation_bloc.dart';
import 'features/master/presentation/bloc/data_service_medicine/data_service_medicine_bloc.dart';
import 'features/medical-record/presentation/bloc/get_medical_record/get_medical_record_bloc.dart';
import 'features/patient-schedule/data/datasources/patient_schedule_remote_datasources.dart';
import 'features/patient-schedule/presentation/bloc/check_status/check_status_bloc.dart';
import 'features/patient-schedule/presentation/bloc/create_medical_record/create_medical_record_bloc.dart';
import 'features/patient-schedule/presentation/bloc/create_payment_detail/create_payment_detail_bloc.dart';
import 'features/patient-schedule/presentation/bloc/get_service_order/get_service_order_bloc.dart';
import 'features/patient-schedule/presentation/bloc/patient_schedule/patient_schedule_bloc.dart';
import 'features/patient-schedule/presentation/bloc/qris/qris_bloc.dart';
import 'features/patients/presentation/bloc/article/article_bloc.dart';
import 'features/patients/presentation/bloc/article_category/article_category_bloc.dart';
import 'features/patients/presentation/bloc/history_reservation/history_reservation_bloc.dart';
import 'features/patients/presentation/bloc/reservation/reservation_bloc.dart';
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
          create: (context) => RegisterBloc(AuthRemoteDatasources()),
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
          create: (context) => DataReservationBloc(MasterRemoteDatasources()),
        ),
        BlocProvider(
          create: (context) => AcceptReservationBloc(MasterRemoteDatasources()),
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
        BlocProvider(
          create: (context) =>
              GetServiceOrderBloc(MedicalRecordsRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => QrisBloc(MidtransRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => CheckStatusBloc(MidtransRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) =>
              CreatePaymentDetailBloc(PaymentDetailRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) =>
              GetMedicalRecordBloc(MedicalRecordsRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) =>
              HistoryTransactionBloc(HistoryTransactionRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => ReservationBloc(ReservationRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) =>
              HistoryReservationBloc(ReservationRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => ArticleCategoryBloc(ArticleRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => ArticleBloc(ArticleRemoteDatasource()),
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
                return const NavbarScreen(
                  initialSelectedItem: 0,
                );
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
