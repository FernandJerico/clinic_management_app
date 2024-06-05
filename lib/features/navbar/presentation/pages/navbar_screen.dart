// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:clinic_management_app/core/constants/responsive.dart';
import 'package:clinic_management_app/features/history/presentation/pages/history_transaction_screen.dart';
import 'package:clinic_management_app/features/home/presentation/pages/dashboard_screen.dart';
import 'package:clinic_management_app/features/medical-record/presentation/pages/medical_record_screen.dart';
import 'package:clinic_management_app/features/patients/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'package:clinic_management_app/features/auth/presentation/pages/login_screen.dart';
import 'package:clinic_management_app/features/master/presentation/pages/master_screen.dart';
import 'package:clinic_management_app/features/patient-schedule/presentation/pages/patient_schedule_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/themes/colors.dart';
import '../../../auth/data/datasources/auth_local_datasources.dart';
import '../widgets/nav_item.dart';

class NavbarScreen extends StatefulWidget {
  final int initialSelectedItem;
  const NavbarScreen({
    Key? key,
    required this.initialSelectedItem,
  }) : super(key: key);

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    // pages for patient
    const HomeScreen(),
    const Center(child: Text('This is page reservation')),
    const Center(child: Text('This is page history')),
    // end pages for patient
    const DashboardScreen(),
    MasterScreen(onTap: (_) {}),
    const MedicalRecordScreen(),
    const PatientScheduleScreen(),
    const HistoryTransactionScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _setInitialSelectedIndex();
  }

  Future<void> _setInitialSelectedIndex() async {
    String role = await _fetchRoleUser();

    setState(() {
      if (role == 'admin' || role == 'staff') {
        _selectedIndex = 3; // Set the default page for admin/staff
      } else if (role == 'doctor') {
        _selectedIndex = 3; // Set the default page for doctor
      } else {
        _selectedIndex = 0; // Set the default page for patient
      }
    });
  }

  Future<String> _fetchRoleUser() async {
    final authData = await AuthLocalDatasources().getAuthData();
    return authData!.user!.role!;
  }

  Future<Widget> roleUser() async {
    String role = await _fetchRoleUser();

    if (ResponsiveWidget.isSmallScreen(context)) {
      if (role == 'admin' || role == 'staff') {
        return BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: AppColors.primary,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.icons.logo.path),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.icons.folderOpen.path),
              label: 'Master',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.icons.chartPie.path),
              label: 'Records',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.icons.shoppingBagProduct.path),
              label: 'Patient',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.icons.history.path),
              label: 'History',
            ),
          ],
        );
      } else if (role == 'doctor') {
        return BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: AppColors.primary,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.icons.logo.path),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.icons.chartPie.path),
              label: 'Records',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.icons.shoppingBagProduct.path),
              label: 'Patient',
            ),
          ],
        );
      } else {
        return BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: AppColors.primary,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.icons.home.path),
              activeIcon: SvgPicture.asset(Assets.icons.homeActive.path),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.icons.reservation.path),
              activeIcon: SvgPicture.asset(Assets.icons.reservationActive.path),
              label: 'Reservasi',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.icons.notification.path),
              activeIcon:
                  SvgPicture.asset(Assets.icons.notificationActive.path),
              label: 'History',
            ),
          ],
        );
      }
    } else {
      if (role == 'admin' || role == 'staff') {
        return Column(
          children: [
            NavItem(
              iconPath: Assets.icons.logo.path,
              isActive: _selectedIndex == 3,
              onTap: () => _onItemTapped(3),
              text: 'Home',
            ),
            NavItem(
              iconPath: Assets.icons.folderOpen.path,
              isActive: _selectedIndex == 4,
              onTap: () => _onItemTapped(4),
              text: 'Master',
            ),
            NavItem(
              iconPath: Assets.icons.chartPie.path,
              isActive: _selectedIndex == 5,
              onTap: () => _onItemTapped(5),
              text: 'Records',
            ),
            NavItem(
              iconPath: Assets.icons.shoppingBagProduct.path,
              isActive: _selectedIndex == 6,
              onTap: () => _onItemTapped(6),
              text: 'Patient',
            ),
            NavItem(
              iconPath: Assets.icons.history.path,
              isActive: _selectedIndex == 7,
              onTap: () => _onItemTapped(7),
              text: 'History',
            ),
          ],
        );
      } else if (role == 'doctor') {
        return Column(
          children: [
            NavItem(
              iconPath: Assets.icons.logo.path,
              isActive: _selectedIndex == 3,
              onTap: () => _onItemTapped(3),
              text: 'Home',
            ),
            NavItem(
              iconPath: Assets.icons.chartPie.path,
              isActive: _selectedIndex == 5,
              onTap: () => _onItemTapped(5),
              text: 'Records',
            ),
            NavItem(
              iconPath: Assets.icons.shoppingBagProduct.path,
              isActive: _selectedIndex == 6,
              onTap: () => _onItemTapped(6),
              text: 'Patient',
            ),
          ],
        );
      } else {
        return Column(
          children: [
            NavItem(
              iconPath: Assets.icons.home.path,
              isActive: _selectedIndex == 0,
              onTap: () => _onItemTapped(0),
              text: 'Home',
            ),
            NavItem(
              iconPath: Assets.icons.reservation.path,
              isActive: _selectedIndex == 1,
              onTap: () => _onItemTapped(1),
              text: 'Reservasi',
            ),
            NavItem(
              iconPath: Assets.icons.notification.path,
              isActive: _selectedIndex == 2,
              onTap: () => _onItemTapped(2),
              text: 'History',
            ),
          ],
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          appBar: ResponsiveWidget.isSmallScreen(context)
              ? AppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(Assets.images.klinikFujiLogo.path,
                          width: 30.0, height: 30.0),
                      const SizedBox(width: 8),
                      Text(
                        'Klinik Pratama Fuji',
                        style: GoogleFonts.poppins(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  backgroundColor: AppColors.primary,
                  actions: [
                    IconButton(
                        onPressed: () {
                          context
                              .read<LogoutBloc>()
                              .add(const LogoutEvent.logout());
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ));
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: AppColors.white,
                        )),
                  ],
                  // leading: ResponsiveWidget.isSmallScreen(context)
                  //     ? Drawer(
                  //         backgroundColor: Colors.transparent,
                  //         child: IconButton(
                  //           icon:
                  //               const Icon(Icons.menu, color: AppColors.white),
                  //           onPressed: () {
                  //             _scaffoldKey.currentState?.openDrawer();
                  //           },
                  //         ),
                  //       )
                  //     : null,
                )
              : null,
          bottomNavigationBar: ResponsiveWidget.isSmallScreen(context)
              ? FutureBuilder(
                  future: roleUser(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data as Widget;
                    } else {
                      return const CircularProgressIndicator();
                    }
                  })
              : null,
          // drawer: ResponsiveWidget.isSmallScreen(context)
          //     ? Drawer(
          //         backgroundColor: AppColors.white,
          //         width: context.deviceWidth * 0.3,
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Padding(
          //               padding: const EdgeInsets.only(top: 20),
          //               child: Image.asset(
          //                 Assets.images.klinikFujiLogo.path,
          //                 width: 75.0,
          //                 height: 75.0,
          //               ),
          //             ),
          //             FutureBuilder(
          //               future: roleUser(),
          //               builder: (context, snapshot) {
          //                 if (snapshot.hasData) {
          //                   return snapshot.data as Widget;
          //                 } else {
          //                   return const CircularProgressIndicator();
          //                 }
          //               },
          //             ),
          //             NavItem(
          //               iconPath: Assets.icons.logOut.path,
          //               isActive: false,
          //               text: 'Logout',
          //               onTap: () {
          //                 context
          //                     .read<LogoutBloc>()
          //                     .add(const LogoutEvent.logout());
          //                 Navigator.pushReplacement(
          //                     context,
          //                     MaterialPageRoute(
          //                       builder: (context) => const LoginScreen(),
          //                     ));
          //               },
          //             ),
          //           ],
          //         ),
          //       )
          //     : null,
          backgroundColor: AppColors.white,
          body: ResponsiveWidget(
            smallScreen: _pages[_selectedIndex],
            largeScreen: Row(
              children: [
                SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.lerp(
                          Border.all(color: AppColors.stroke, width: 1.0),
                          Border.all(color: AppColors.stroke, width: 3.0),
                          0.5),
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(0),
                          right: Radius.circular(16.0)),
                    ),
                    width: context.deviceWidth * 0.1,
                    height: ResponsiveWidget.isSmallScreen(context)
                        ? context.deviceHeight
                        : context.deviceHeight - 24,
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
                            FutureBuilder(
                              future: roleUser(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return snapshot.data as Widget;
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
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
          )),
    );
  }

  void _onItemTapped(int index) {
    _selectedIndex = index;
    setState(() {});
  }
}
