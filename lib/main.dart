import 'package:clinic_management_app/features/auth/data/datasources/auth_local_datasources.dart';
import 'package:clinic_management_app/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:clinic_management_app/features/auth/presentation/pages/login_screen.dart';
import 'package:clinic_management_app/features/master/data/datasources/master_remote_datasources.dart';
import 'package:clinic_management_app/features/master/presentation/bloc/data_doctor/data_doctor_bloc.dart';
import 'package:clinic_management_app/features/navbar/presentation/pages/navbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/themes/colors.dart';
import 'features/auth/presentation/bloc/login/login_bloc.dart';
import 'features/auth/presentation/bloc/logout/logout_bloc.dart';

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
