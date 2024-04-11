import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'package:clinic_management_app/features/auth/presentation/pages/login_screen.dart';
import 'package:clinic_management_app/features/master/presentation/pages/master_screen.dart';
import 'package:clinic_management_app/features/patient-schedule/presentation/pages/patient_schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/themes/colors.dart';
import '../widgets/nav_item.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Center(child: Text('This is page 1')),
    MasterScreen(onTap: (_) {}),
    const Center(child: Text('This is page 3')),
    const PatientScheduleScreen(),
    const Center(child: Text('This is page 5')),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Row(
          children: [
            SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.lerp(
                      Border.all(color: AppColors.stroke, width: 1.0),
                      Border.all(color: AppColors.stroke, width: 3.0),
                      0.5),
                  borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(0), right: Radius.circular(16.0)),
                ),
                width: context.deviceWidth * 0.1,
                height: context.deviceHeight - 20.0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(16.0)),
                  child: ColoredBox(
                    color: AppColors.navbarColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Image.asset(
                            Assets.images.klinikFujiLogo.path,
                            width: 75.0,
                            height: 75.0,
                          ),
                        ),
                        Column(
                          children: [
                            NavItem(
                              iconPath: Assets.icons.logo.path,
                              isActive: _selectedIndex == 0,
                              onTap: () => _onItemTapped(0),
                              text: 'Home',
                            ),
                            NavItem(
                              iconPath: Assets.icons.folderOpen.path,
                              isActive: _selectedIndex == 1,
                              onTap: () => _onItemTapped(1),
                              text: 'Master',
                            ),
                            NavItem(
                              iconPath: Assets.icons.chartPie.path,
                              isActive: _selectedIndex == 2,
                              onTap: () => _onItemTapped(2),
                              text: 'Report',
                            ),
                            NavItem(
                              iconPath: Assets.icons.shoppingBagProduct.path,
                              isActive: _selectedIndex == 3,
                              onTap: () => _onItemTapped(3),
                              text: 'Patient',
                            ),
                            NavItem(
                              iconPath: Assets.icons.setting.path,
                              isActive: _selectedIndex == 4,
                              onTap: () => _onItemTapped(4),
                              text: 'Setting',
                            ),
                          ],
                        ),
                        NavItem(
                          iconPath: Assets.icons.logOut.path,
                          isActive: false,
                          text: 'Logout',
                          onTap: () {
                            context
                                .read<LogoutBloc>()
                                .add(const LogoutEvent.logout());
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: _pages[_selectedIndex],
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    _selectedIndex = index;
    setState(() {});
  }
}
