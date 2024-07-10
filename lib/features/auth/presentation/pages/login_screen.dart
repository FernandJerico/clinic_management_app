import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/features/auth/presentation/pages/register_screen.dart';
import 'package:clinic_management_app/features/navbar/presentation/pages/navbar_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/button_gradient.dart';
import '../../../../core/components/custom_text_field.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../core/themes/colors.dart';
import '../bloc/login/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? fcmToken;

  void _getFcmToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    setState(() {
      fcmToken = token;
    });
  }

  @override
  void initState() {
    super.initState();
    _getFcmToken();
  }

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
                        const SpaceHeight(80.0),
                        const Center(
                          child: Text(
                            'Masuk ke Akun Anda',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SpaceHeight(30.0),
                        CustomTextField(
                          controller: emailController,
                          label: 'Email',
                          isEmail: true,
                        ),
                        const SpaceHeight(20.0),
                        CustomTextField(
                          controller: passwordController,
                          label: 'Kata Sandi',
                          obscureText: true,
                        ),
                        const SpaceHeight(40.0),
                        BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            state.maybeWhen(
                              success: (data) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const NavbarScreen(
                                      initialSelectedItem: 0,
                                    ),
                                  ),
                                  (route) => false,
                                );
                              },
                              error: (message) {
                                ResponsiveWidget.isLargeScreen(context)
                                    ? AnimatedSnackBar.material(message,
                                            type: AnimatedSnackBarType.error,
                                            duration:
                                                const Duration(seconds: 3),
                                            desktopSnackBarPosition:
                                                DesktopSnackBarPosition.topLeft)
                                        .show(context)
                                    : AnimatedSnackBar.material(
                                        message,
                                        type: AnimatedSnackBarType.error,
                                        duration: const Duration(seconds: 3),
                                      ).show(context);
                              },
                              orElse: () {},
                            );
                          },
                          builder: (context, state) {
                            // debugPrint('FCM Token: $fcmToken');
                            return state.maybeWhen(
                              orElse: () {
                                return ButtonGradient.filled(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<LoginBloc>().add(
                                            LoginEvent.login(
                                              emailController.text,
                                              passwordController.text,
                                              fcmToken,
                                            ),
                                          );
                                    }
                                  },
                                  label: 'MASUK',
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
                            onTap: () => context.push(const RegisterScreen()),
                            child: Text.rich(TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Belum Memiliki Akun? ',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: AppColors.darkGrey,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Daftar Disini',
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
                        const SpaceHeight(100.0),
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
