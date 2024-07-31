// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/core/extensions/date_time_ext.dart';
import 'package:clinic_management_app/features/home/presentation/bloc/get_patient_this_month/get_patient_this_month_bloc.dart';
import 'package:clinic_management_app/features/home/presentation/bloc/get_total_patient/get_total_patient_bloc.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/themes/colors.dart';
import '../../../master/presentation/bloc/data_patient/data_patient_bloc.dart';
import '../../../master/presentation/widgets/build_app_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<GetPatientThisMonthBloc>()
        .add(const GetPatientThisMonthEvent.getPatientThisMonth());
    context
        .read<GetTotalPatientBloc>()
        .add(const GetTotalPatientEvent.getTotalPatient());
    context.read<DataPatientBloc>().add(const DataPatientEvent.getPatients());
  }

  @override
  Widget build(BuildContext context) {
    final portrait = MediaQuery.of(context).orientation == Orientation.portrait;
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
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (portrait) {
                        return Row(
                          children: [
                            Expanded(child: newPatientThisMonth()),
                            const SizedBox(width: 12),
                            Expanded(child: registeredPatientAtClinic())
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            newPatientThisMonth(),
                            const SizedBox(
                              height: 8,
                            ),
                            registeredPatientAtClinic()
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                  Container(
                    height: 308,
                    width:
                        portrait ? double.infinity : context.deviceWidth * 0.3,
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
                          BlocBuilder<GetTotalPatientBloc,
                              GetTotalPatientState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () {
                                  return CircularPercentIndicator(
                                    radius: 100,
                                    lineWidth: 20,
                                    percent: 0.0,
                                    progressColor: AppColors.primary700,
                                    backgroundColor:
                                        AppColors.primary.withOpacity(0.9),
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
                                          '0',
                                          style: GoogleFonts.poppins(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                loaded: (countPatient) {
                                  return CircularPercentIndicator(
                                    radius: 100,
                                    lineWidth: 20,
                                    percent: countPatient / 100,
                                    progressColor:
                                        const Color.fromRGBO(43, 141, 119, 1),
                                    backgroundColor:
                                        AppColors.primary.withOpacity(0.9),
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
                                          '$countPatient',
                                          style: GoogleFonts.poppins(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
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
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (portrait) {
                        return Row(
                          children: [
                            Expanded(
                              child: InformationWidget(
                                text: 'Rentang waktu Tunggu Dokter',
                                amount: '10 hingga 15 menit',
                                iconPath:
                                    Assets.images.dashboard.waitingTime.path,
                                withIconChart: false,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: InformationWidget(
                                text: 'Rentang waktu Konsultasi',
                                amount: '10 hingga 15 menit',
                                iconPath: Assets
                                    .images.dashboard.timeConsultation.path,
                                withIconChart: false,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            InformationWidget(
                              text: 'Rentang waktu Tunggu Dokter',
                              amount: '10 hingga 15 menit',
                              iconPath:
                                  Assets.images.dashboard.waitingTime.path,
                              withIconChart: false,
                            ),
                            const SizedBox(height: 8),
                            InformationWidget(
                              text: 'Rentang waktu Konsultasi',
                              amount: '10 hingga 15 menit',
                              iconPath:
                                  Assets.images.dashboard.timeConsultation.path,
                              withIconChart: false,
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                runSpacing: 8,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: portrait
                        ? double.infinity
                        : context.deviceWidth * 0.575,
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
                        ),
                        BlocBuilder<DataPatientBloc, DataPatientState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () {
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                              loaded: (patients) {
                                return DataTable(
                                  dataRowMinHeight: 30.0,
                                  dataRowMaxHeight: 60.0,
                                  columns: [
                                    DataColumn(
                                        label: Text(
                                      'Nama Pasien',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Alamat Email',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Tanggal Lahir',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ],
                                  rows: patients.isEmpty
                                      ? [
                                          const DataRow(
                                            cells: [
                                              DataCell.empty,
                                              DataCell.empty,
                                              DataCell.empty,
                                              DataCell.empty,
                                            ],
                                          ),
                                          const DataRow(
                                            cells: [
                                              DataCell.empty,
                                              DataCell.empty,
                                              DataCell.empty,
                                              DataCell.empty,
                                            ],
                                          ),
                                        ]
                                      : patients
                                          .map(
                                            (patient) => DataRow(cells: [
                                              DataCell(Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    patient.name ?? '',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(patient.gender ?? ''),
                                                ],
                                              )),
                                              DataCell(Center(
                                                  child: Text(
                                                      patient.email ?? ''))),
                                              DataCell(
                                                Center(
                                                  child: Text(
                                                    patient.birthDate!
                                                        .toFormattedDate(),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          )
                                          .toList(),
                                );
                              },
                              loading: () {
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    height: portrait
                        ? context.deviceHeight * 0.35
                        : context.deviceHeight * 0.49,
                    width: portrait
                        ? double.infinity
                        : context.deviceWidth * 0.275,
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
                            ),
                          ],
                        ),
                        SfCartesianChart(
                          plotAreaBackgroundColor: Colors.transparent,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          borderColor: Colors.transparent,
                          borderWidth: 0,
                          plotAreaBorderWidth: 0,
                          enableSideBySideSeriesPlacement: false,
                          primaryXAxis: const CategoryAxis(
                            isVisible: false,
                          ),
                          primaryYAxis: const NumericAxis(
                            isVisible: false,
                            minimum: 0,
                            maximum: 2,
                            interval: 0.75,
                          ),
                          series: <CartesianSeries>[
                            ColumnSeries<ChartColumnData, String>(
                              borderRadius: BorderRadius.circular(8),
                              width: 0.25,
                              color: AppColors.primary.withOpacity(0.2),
                              dataSource: chartData,
                              xValueMapper: (ChartColumnData data, _) => data.x,
                              yValueMapper: (ChartColumnData data, _) => data.y,
                            ),
                            ColumnSeries<ChartColumnData, String>(
                              borderRadius: BorderRadius.circular(8),
                              width: 0.25,
                              color: AppColors.primary,
                              dataSource: chartData,
                              xValueMapper: (ChartColumnData data, _) => data.x,
                              yValueMapper: (ChartColumnData data, _) =>
                                  data.y1,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  BlocBuilder<GetTotalPatientBloc, GetTotalPatientState>
      registeredPatientAtClinic() {
    return BlocBuilder<GetTotalPatientBloc, GetTotalPatientState>(
      builder: (context, state) {
        return state.maybeMap(
          orElse: () {
            return InformationWidget(
                text: 'Pasien Terdaftar\ndi Klinik Ini',
                amount: '0',
                iconPath: Assets.images.dashboard.patientRegistered.path);
          },
          loaded: (value) {
            final countPatient = value.countPatient;
            return InformationWidget(
              text: 'Pasien Terdaftar\ndi Klinik Ini',
              amount: '$countPatient',
              iconPath: Assets.images.dashboard.patientRegistered.path,
            );
          },
        );
      },
    );
  }

  BlocBuilder<GetPatientThisMonthBloc, GetPatientThisMonthState>
      newPatientThisMonth() {
    return BlocBuilder<GetPatientThisMonthBloc, GetPatientThisMonthState>(
      builder: (context, state) {
        return state.maybeMap(orElse: () {
          return InformationWidget(
              text: 'Pasien Baru\nBulan Ini',
              amount: '0',
              iconPath: Assets.images.dashboard.newPatient.path);
        }, loaded: (data) {
          final countPatient = data.countPatientThisMonth;
          return InformationWidget(
            text: 'Pasien Baru\nBulan Ini',
            amount: countPatient.toString(),
            iconPath: Assets.images.dashboard.newPatient.path,
          );
        });
      },
    );
  }
}

class ChartColumnData {
  final String? x;
  final double? y;
  final double? y1;
  ChartColumnData({
    this.x,
    this.y,
    this.y1,
  });
}

final List<ChartColumnData> chartData = <ChartColumnData>[
  ChartColumnData(x: 'Rawat Inap 1', y: 1.5, y1: 0.5),
  ChartColumnData(x: 'Rawat Jalan 1', y: 1.5, y1: 0.65),
  ChartColumnData(x: 'Rawat Inap 2', y: 1.5, y1: 1.1),
  ChartColumnData(x: 'Rawat Jalan 2', y: 1.5, y1: 0.95),
  ChartColumnData(x: 'Rawat Inap 3', y: 1.5, y1: 1.1),
  ChartColumnData(x: 'Rawat Jalan 3', y: 1.5, y1: 0.95),
];

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
      width: MediaQuery.of(context).orientation == Orientation.portrait
          ? double.infinity
          : context.deviceWidth * 0.275,
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
