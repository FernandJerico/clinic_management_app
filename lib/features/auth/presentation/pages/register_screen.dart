import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:clinic_management_app/core/components/button_gradient.dart';
import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/features/auth/presentation/pages/login_screen.dart';
import 'package:clinic_management_app/features/patients/presentation/widgets/success_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/custom_text_field.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../core/themes/colors.dart';
import '../bloc/register/register_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final fullnameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: [
            // LEFT CONTENT
            Expanded(
              flex: 1,
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
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
                          isEmail: true,
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
                          obscureText: true,
                        ),
                        const SpaceHeight(40.0),
                        BlocConsumer<RegisterBloc, RegisterState>(
                          listener: (context, state) {
                            state.maybeWhen(
                              success: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => SuccessDialog(
                                    message:
                                        'Register Berhasil!\nSilahkan Cek Email Anda Untuk Verifikasi.',
                                    buttonText: 'Login',
                                    onPressed: () =>
                                        context.push(const LoginScreen()),
                                  ),
                                );
                              },
                              error: (message) {
                                AnimatedSnackBar.material(
                                  message,
                                  type: AnimatedSnackBarType.error,
                                  duration: const Duration(seconds: 3),
                                ).show(context);
                              },
                              orElse: () {},
                            );
                          },
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () {
                                return ButtonGradient.filled(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<RegisterBloc>().add(
                                            RegisterEvent.register(
                                              password: passwordController.text,
                                              fullname: fullnameController.text,
                                              phone: phoneController.text,
                                              email: emailController.text,
                                            ),
                                          );
                                    }
                                  },
                                  label: 'DAFTAR',
                                );
                              },
                              loading: () {
                                return ButtonGradient.loading(onPressed: () {});
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
