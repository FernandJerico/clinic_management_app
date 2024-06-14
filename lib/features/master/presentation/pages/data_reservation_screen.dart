import 'package:clinic_management_app/core/assets/assets.gen.dart';
import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/components/spaces.dart';
import '../../../../core/themes/colors.dart';
import '../widgets/build_app_bar.dart';

class DataReservationScreen extends StatefulWidget {
  const DataReservationScreen({super.key});

  @override
  State<DataReservationScreen> createState() => _DataReservationScreenState();
}

class _DataReservationScreenState extends State<DataReservationScreen> {
  final searchController = TextEditingController();

  String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: BuildAppBar(
          title: 'Data Reservasi',
          withSearchInput: true,
          searchController: searchController,
          keyboardType: TextInputType.text,
          withBackButton: true,
          searchChanged: (value) {},
          searchHint: 'Cari Reseverasi',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Reservasi Online',
              style: GoogleFonts.poppins(
                  fontSize: 21, fontWeight: FontWeight.bold),
            ),
            const SpaceHeight(16.0),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const SpaceHeight(16),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    height: context.deviceHeight * 0.14,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.stroke),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: double.infinity,
                          width: 16,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                          ),
                        ),
                        const SpaceWidth(8),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Fajar Gema',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black),
                                  ),
                                  Text(
                                    'Laki-Laki (20 April 2002)',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14, color: AppColors.black),
                                  ),
                                  Text(
                                    'Poli Kulit dan Kelamin',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14, color: AppColors.black),
                                  ),
                                  Text(
                                    'Waktu Kedatangan: Senin, 20 April 2022 10:00 WIB',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 0),
                                    height: 24,
                                    decoration: BoxDecoration(
                                      // color: history.status == 'pending'
                                      //     ? AppColors.orderIsWaiting
                                      //         .withOpacity(0.25)
                                      //     : history.status == 'approved'
                                      //         ? AppColors.orderIsCompleted
                                      //             .withOpacity(0.25)
                                      //         : AppColors.orderIsRejected
                                      //             .withOpacity(0.25),
                                      color: AppColors.orderIsCompleted
                                          .withOpacity(0.25),
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        // color: history.status == 'pending'
                                        //     ? AppColors.orderIsWaiting
                                        //     : history.status == 'approved'
                                        //         ? AppColors.orderIsCompleted
                                        //         : AppColors.orderIsRejected,
                                        color: AppColors.orderIsCompleted,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Status: ${capitalize('pending')}',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        // color: history.status == 'pending'
                                        //     ? AppColors.orderIsWaiting
                                        //     : history.status == 'approved'
                                        //         ? AppColors.orderIsCompleted
                                        //         : AppColors.orderIsRejected,
                                        color: AppColors.orderIsCompleted,
                                      ),
                                    ),
                                  ),
                                  const SpaceWidth(16),
                                  PopupMenuButton(
                                    color: Colors.white,
                                    padding: const EdgeInsets.only(right: 20),
                                    offset: const Offset(-20, 0),
                                    icon: SvgPicture.asset(
                                        Assets.icons.action.path),
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          height: 36,
                                          child: Text(
                                            'Accept',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          onTap: () {},
                                        ),
                                      ];
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
