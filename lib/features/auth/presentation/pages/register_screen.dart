import 'package:clinic_management_app/core/components/button_gradient.dart';
import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/custom_text_field.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../core/themes/colors.dart';
import '../../../navbar/presentation/pages/navbar_screen.dart';
import '../bloc/login/login_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final fullnameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            // LEFT CONTENT
            Expanded(
              flex: 1,
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SpaceHeight(40.0),
                      const Center(
                        child: Text(
                          'Register Akun Anda',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SpaceHeight(30.0),
                      CustomTextField(
                        controller: fullnameController,
                        label: 'Nama Lengkap',
                      ),
                      const SpaceHeight(20.0),
                      CustomTextField(
                        controller: emailController,
                        label: 'Email',
                      ),
                      const SpaceHeight(20.0),
                      CustomTextField(
                        controller: phoneController,
                        label: 'Nomor Telepon',
                      ),
                      const SpaceHeight(20.0),
                      CustomTextField(
                        controller: passwordController,
                        label: 'Kata Sandi',
                      ),
                      const SpaceHeight(40.0),
                      BlocConsumer<LoginBloc, LoginState>(
                        listener: (context, state) {
                          state.maybeWhen(
                            success: (data) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const NavbarScreen(
                                    initialSelectedItem: 0,
                                  ),
                                ),
                              );
                            },
                            error: (message) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(message),
                                  backgroundColor: AppColors.red,
                                ),
                              );
                            },
                            orElse: () {},
                          );
                        },
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () {
                              return Button.gradient(
                                onPressed: () {},
                                label: 'DAFTAR',
                              );
                            },
                            loading: () {
                              return Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF2B8D77),
                                      Color(0xFF00BC00)
                                    ],
                                  ),
                                ),
                                child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                    ),
                                    child: const CircularProgressIndicator(
                                      color: AppColors.white,
                                    )),
                              );
                            },
                          );
                        },
                      ),
                      const SpaceHeight(20.0),
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () => context.push(const LoginScreen()),
                          child: Text.rich(TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Sudah Memiliki Akun? ',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: AppColors.darkGrey,
                                ),
                              ),
                              TextSpan(
                                text: 'Masuk',
                                style: GoogleFonts.poppins(
                                  fontSize: 12.0,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )),
                        ),
                      ),
                      const SpaceHeight(60.0),
                      const Text(
                        '© 2024 Klinik Pratama Fuji | Clinic Management App',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // RIGHT CONTENT
            if (ResponsiveWidget.isLargeScreen(context))
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: context.deviceWidth,
                    height: context.deviceHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: Assets.images.splashScreen.provider(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 67.0, right: 15.0, left: 120.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'SELAMAT DATANG!, \nDi Klinik Pratama Fuji Cirebon',
                            style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                            textAlign: TextAlign.end,
                          ),
                          const SpaceHeight(50.0),
                          Flexible(child: Assets.images.dokterku.image()),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
