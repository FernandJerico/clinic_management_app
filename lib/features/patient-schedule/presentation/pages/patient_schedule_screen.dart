import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/core/extensions/date_time_ext.dart';
import 'package:clinic_management_app/features/patient-schedule/data/models/response/patient_schedule_response_model.dart';
import 'package:clinic_management_app/features/patient-schedule/presentation/dialogs/create_medical_record_dialog.dart';
import 'package:clinic_management_app/features/patient-schedule/presentation/pages/confirm_payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/components/buttons.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/enums/pasient_status.dart';
import '../../../../core/themes/colors.dart';
import '../../../auth/data/datasources/auth_local_datasources.dart';
import '../../../master/presentation/widgets/build_app_bar.dart';
import '../bloc/patient_schedule/patient_schedule_bloc.dart';
import 'package:shimmer/shimmer.dart';

class PatientScheduleScreen extends StatefulWidget {
  const PatientScheduleScreen({super.key});

  @override
  State<PatientScheduleScreen> createState() => _PatientScheduleScreenState();
}

class _PatientScheduleScreenState extends State<PatientScheduleScreen> {
  final searchController = TextEditingController();
  final scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    context
        .read<PatientScheduleBloc>()
        .add(const PatientScheduleEvent.getPatientSchedules());
    super.initState();
  }

  void createRmPatientTap(int patientScheduleId, DateTime scheduleTime,
      String complaint, int doctorId, Patient patient) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CreateMedicalRecordDialog(
          doctorId: doctorId,
          patient: patient,
          patientScheduleId: patientScheduleId,
          scheduleTime: scheduleTime,
          complaint: complaint),
    );
  }

  void createPayment(PatientSchedule schedulePatient, int totalPrice) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConfirmPaymentScreen(
        schedulePatient: schedulePatient,
        totalPrice: totalPrice,
      ),
    );
  }

  var columns = [
    DataColumn(
      label: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Button.filled(
          onPressed: () {},
          label: 'No Antrian',
          width: null,
          color: AppColors.title,
          textColor: AppColors.black.withOpacity(0.5),
          fontSize: 14.0,
        ),
      ),
    ),
    DataColumn(
      label: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Button.filled(
          onPressed: () {},
          label: 'Nama Pasien',
          width: null,
          color: AppColors.title,
          textColor: AppColors.black.withOpacity(0.5),
          fontSize: 14.0,
        ),
      ),
    ),
    DataColumn(
      label: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Button.filled(
          onPressed: () {},
          label: 'Keluhan',
          width: null,
          color: AppColors.title,
          textColor: AppColors.black.withOpacity(0.5),
          fontSize: 14.0,
        ),
      ),
    ),
    DataColumn(
      label: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Button.filled(
          onPressed: () {},
          label: 'Jenis Kelamin',
          width: null,
          color: AppColors.title,
          textColor: AppColors.black.withOpacity(0.5),
          fontSize: 14.0,
        ),
      ),
    ),
    DataColumn(
      label: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Button.filled(
          onPressed: () {},
          label: 'Tanggal Lahir',
          width: null,
          color: AppColors.title,
          textColor: AppColors.black.withOpacity(0.5),
          fontSize: 14.0,
        ),
      ),
    ),
    DataColumn(
      label: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Button.filled(
          onPressed: () {},
          label: 'NIK',
          width: null,
          color: AppColors.title,
          textColor: AppColors.black.withOpacity(0.5),
          fontSize: 14.0,
        ),
      ),
    ),
    DataColumn(
      label: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Button.filled(
          onPressed: () {},
          label: 'Status',
          width: null,
          color: AppColors.title,
          textColor: AppColors.black.withOpacity(0.5),
          fontSize: 14.0,
        ),
      ),
    ),
    DataColumn(
      label: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Button.filled(
          onPressed: () {},
          label: 'Action',
          width: null,
          color: AppColors.title,
          textColor: AppColors.black.withOpacity(0.5),
          fontSize: 14.0,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      key: scaffoldkey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: BuildAppBar(
          title: 'Jadwal Pasien',
          withSearchInput: true,
          searchController: searchController,
          keyboardType: TextInputType.number,
          searchChanged: (value) {
            if (value.isNotEmpty) {
              context.read<PatientScheduleBloc>().add(
                  PatientScheduleEvent.getPatientSchedulesByNIK(
                      searchController.text));
            } else {
              context
                  .read<PatientScheduleBloc>()
                  .add(const PatientScheduleEvent.getPatientSchedules());
            }
          },
          searchHint: 'Cari Pasien Berdasarkan NIK',
        ),
      ),
      endDrawer: Drawer(
        width: context.deviceWidth / 1.25,
        child: const SizedBox(),
      ),
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: AppColors.primary,
        onRefresh: () async {
          searchController.clear();
          Future.delayed(const Duration(seconds: 1), () {
            context
                .read<PatientScheduleBloc>()
                .add(const PatientScheduleEvent.getPatientSchedules());
          });
        },
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Badge(
                    backgroundColor: PatientStatus.waiting.color,
                    smallSize: 18.0,
                  ),
                  const SpaceWidth(4.0),
                  Text(PatientStatus.waiting.value),
                  const SpaceWidth(40.0),
                  Badge(
                    backgroundColor: PatientStatus.processing.color,
                    smallSize: 18.0,
                  ),
                  const SpaceWidth(4.0),
                  Text(PatientStatus.processing.value),
                  const SpaceWidth(40.0),
                  Badge(
                    backgroundColor: PatientStatus.completed.color,
                    smallSize: 18.0,
                  ),
                  const SpaceWidth(4.0),
                  Text(PatientStatus.completed.value),
                  const SpaceWidth(40.0),
                  Badge(
                    backgroundColor: PatientStatus.rejected.color,
                    smallSize: 18.0,
                  ),
                  const SpaceWidth(4.0),
                  Text(PatientStatus.rejected.value),
                ],
              ),
            ),
            const SpaceHeight(40.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.stroke),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                scrollDirection: Axis.horizontal,
                child: BlocBuilder<PatientScheduleBloc, PatientScheduleState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return const SizedBox();
                      },
                      loading: () {
                        return DataTable(
                          columns: columns,
                          rows: const [
                            DataRow(cells: [
                              DataCell(SkeletonLoading()),
                              DataCell(SkeletonLoading()),
                              DataCell(SkeletonLoading()),
                              DataCell(SkeletonLoading()),
                              DataCell(SkeletonLoading()),
                              DataCell(SkeletonLoading()),
                              DataCell(SkeletonLoading()),
                              DataCell(SkeletonLoading()),
                            ])
                          ],
                        );
                      },
                      loaded: (patientSchedules) {
                        return DataTable(
                          columns: columns,
                          rows: patientSchedules.isEmpty
                              ? [
                                  const DataRow(
                                    cells: [
                                      DataCell.empty,
                                      DataCell.empty,
                                      DataCell.empty,
                                      DataCell(Row(
                                        children: [
                                          Icon(Icons.highlight_off),
                                          SpaceWidth(4.0),
                                          Text('Data tidak ditemukan..'),
                                        ],
                                      )),
                                      DataCell.empty,
                                      DataCell.empty,
                                      DataCell.empty,
                                      DataCell.empty,
                                    ],
                                  ),
                                ]
                              : patientSchedules
                                  .map(
                                    (patient) => DataRow(cells: [
                                      DataCell(Center(
                                        child: Text(
                                          patient.queueNumber.toString(),
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                      DataCell(
                                          Text(patient.patient!.name ?? '')),
                                      DataCell(Text(
                                          '${patient.complaint!.length > 10 ? patient.complaint!.substring(0, 10) : patient.complaint!}...')),
                                      DataCell(Center(
                                          child: Text(
                                              patient.patient!.gender ?? ''))),
                                      DataCell(Center(
                                        child: Text(patient.patient!.birthDate!
                                            .toFormattedDate()),
                                      )),
                                      DataCell(Center(
                                          child: Text(
                                              patient.patient!.nik ?? ''))),
                                      DataCell(Center(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          child: ColoredBox(
                                            color: patient.status == 'waiting'
                                                ? PatientStatus
                                                    .waiting.backgroundColor
                                                : patient.status == 'processing'
                                                    ? PatientStatus.processing
                                                        .backgroundColor
                                                    : patient.status == 'onHold'
                                                        ? PatientStatus.onHold
                                                            .backgroundColor
                                                        : patient.status ==
                                                                'completed'
                                                            ? PatientStatus
                                                                .completed
                                                                .backgroundColor
                                                            : patient.status ==
                                                                    'canceled'
                                                                ? PatientStatus
                                                                    .rejected
                                                                    .backgroundColor
                                                                : patient.status ==
                                                                        'processed'
                                                                    ? PatientStatus
                                                                        .processed
                                                                        .backgroundColor
                                                                    : AppColors
                                                                        .white,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0,
                                                      vertical: 8.0),
                                              child: Text(
                                                patient.status ?? '',
                                                style: TextStyle(
                                                  color: patient.status ==
                                                          'waiting'
                                                      ? PatientStatus
                                                          .waiting.color
                                                      : patient.status ==
                                                              'processing'
                                                          ? PatientStatus
                                                              .processing.color
                                                          : patient.status ==
                                                                  'onHold'
                                                              ? PatientStatus
                                                                  .onHold.color
                                                              : patient.status ==
                                                                      'completed'
                                                                  ? PatientStatus
                                                                      .completed
                                                                      .color
                                                                  : patient.status ==
                                                                          'canceled'
                                                                      ? PatientStatus
                                                                          .rejected
                                                                          .color
                                                                      : patient.status ==
                                                                              'processed'
                                                                          ? PatientStatus
                                                                              .processed
                                                                              .color
                                                                          : AppColors
                                                                              .black
                                                                              .withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                      DataCell(
                                        Center(
                                          child: FutureBuilder(
                                            future: AuthLocalDatasources()
                                                .getAuthData(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const CircularProgressIndicator();
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    'Error: ${snapshot.error}');
                                              } else {
                                                final role =
                                                    snapshot.data?.user?.role;
                                                return PopupMenuButton<
                                                    PatientStatus>(
                                                  color: Colors.white,
                                                  offset: const Offset(0, 50),
                                                  icon: const Icon(
                                                      Icons.more_horiz),
                                                  itemBuilder:
                                                      (BuildContext context) {
                                                    return [
                                                      if (patient.status ==
                                                          'waiting')
                                                        const PopupMenuItem<
                                                            PatientStatus>(
                                                          value: PatientStatus
                                                              .processing,
                                                          child: _PopupMenuItemValue(
                                                              PatientStatus
                                                                  .processing),
                                                        ),
                                                      if (patient.status ==
                                                          'waiting')
                                                        const PopupMenuItem<
                                                            PatientStatus>(
                                                          value: PatientStatus
                                                              .rejected,
                                                          child:
                                                              _PopupMenuItemValue(
                                                                  PatientStatus
                                                                      .rejected),
                                                        ),
                                                      if (!(role == 'doctor' &&
                                                              patient.status ==
                                                                  'processed') &&
                                                          patient.status !=
                                                              'completed' &&
                                                          patient.status !=
                                                              'waiting')
                                                        const PopupMenuItem<
                                                            PatientStatus>(
                                                          value: PatientStatus
                                                              .completed,
                                                          child:
                                                              _PopupMenuItemValue(
                                                                  PatientStatus
                                                                      .completed),
                                                        ),
                                                      if (patient.status !=
                                                          'waiting')
                                                        const PopupMenuItem<
                                                            PatientStatus>(
                                                          value: PatientStatus
                                                              .rejected,
                                                          child:
                                                              _PopupMenuItemValue(
                                                                  PatientStatus
                                                                      .rejected),
                                                        ),
                                                    ];
                                                  },
                                                  onSelected:
                                                      (PatientStatus value) {
                                                    if (value ==
                                                        PatientStatus
                                                            .processing) {
                                                      createRmPatientTap(
                                                          patient.id!,
                                                          patient.scheduleTime!,
                                                          patient.complaint!,
                                                          patient.doctorId!,
                                                          patient.patient!);
                                                    } else if (value ==
                                                        PatientStatus
                                                            .completed) {
                                                      createPayment(
                                                        patient,
                                                        patient.totalPrice ?? 0,
                                                      );
                                                    } else {
                                                      scaffoldkey.currentState!
                                                          .openEndDrawer();
                                                    }
                                                  },
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ]),
                                  )
                                  .toList(),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SkeletonLoading extends StatelessWidget {
  const SkeletonLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Shimmer.fromColors(
          baseColor: AppColors.grey,
          highlightColor: AppColors.grey.withOpacity(0.5),
          child: Container(
            width: 100.0,
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ));
  }
}

class _PopupMenuItemValue extends StatelessWidget {
  final PatientStatus item;
  const _PopupMenuItemValue(this.item);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 18.0,
          height: 18.0,
          decoration: BoxDecoration(
            border: Border.all(
              color: item.color,
              width: 2,
            ),
            shape: BoxShape.circle,
          ),
        ),
        const SpaceWidth(4.0),
        Text(item.value),
      ],
    );
  }
}
