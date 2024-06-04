import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/themes/colors.dart';
import '../../../master/presentation/widgets/build_app_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: BuildAppBar(
          keyboardType: TextInputType.text,
          title: 'KLINIK PRATAMA FUJI',
        ),
      ),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Wrap(
                runSpacing: 8,
                children: [
                  Column(
                    children: [
                      InformationWidget(
                        text: 'Pasien Baru\nBulan Ini',
                        amount: '20',
                        iconPath: Assets.images.dashboard.newPatient.path,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      InformationWidget(
                        text: 'Pasien Terdaftar\ndi Klinik Ini',
                        amount: '55',
                        iconPath:
                            Assets.images.dashboard.patientRegistered.path,
                      )
                    ],
                  ),
                  const SizedBox(width: 8),
                  Container(
                    height: 308,
                    width: context.deviceWidth * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            'Total Pasien di Klinik',
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 12),
                          CircularPercentIndicator(
                            radius: 100,
                            lineWidth: 20,
                            percent: 0.7,
                            progressColor: AppColors.primary700,
                            backgroundColor: AppColors.primary.withOpacity(0.9),
                            circularStrokeCap: CircularStrokeCap.round,
                            center: Container(
                              height: 86,
                              width: 86,
                              decoration: const BoxDecoration(
                                color: AppColors.primary700,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '75',
                                  style: GoogleFonts.poppins(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: AppColors.primary700,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Rawat Jalan: 20 Pasien',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    children: [
                      InformationWidget(
                        text: 'Rentang waktu Tunggu Dokter',
                        amount: '10 hingga 15 menit',
                        iconPath: Assets.images.dashboard.waitingTime.path,
                        withIconChart: false,
                      ),
                      const SizedBox(height: 8),
                      InformationWidget(
                        text: 'Rentang waktu Konsultasi',
                        amount: '10 hingga 15 menit',
                        iconPath: Assets.images.dashboard.timeConsultation.path,
                        withIconChart: false,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                runSpacing: 8,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    height: 360,
                    width: context.deviceWidth * 0.575,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daftar Data Pasien',
                          style: GoogleFonts.poppins(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    height: 360,
                    width: context.deviceWidth * 0.275,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Rawat Inap',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                )
                              ],
                            ),
                            const SizedBox(width: 20),
                            Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: AppColors.primary700,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Rawat Jalan',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InformationWidget extends StatelessWidget {
  final String text;
  final String amount;
  final String iconPath;
  final bool withIconChart;
  const InformationWidget({
    super.key,
    required this.text,
    required this.amount,
    required this.iconPath,
    this.withIconChart = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: context.deviceWidth * 0.275,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: context.deviceWidth * 0.075,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Image.asset(
              iconPath,
              width: 50,
              height: 50,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: GoogleFonts.poppins(
                        fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        amount,
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      withIconChart
                          ? Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: AppColors.red.withOpacity(0.2),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                              child: Center(
                                child: Image.asset(
                                  Assets.images.dashboard.chart.path,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          : const SizedBox()
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
