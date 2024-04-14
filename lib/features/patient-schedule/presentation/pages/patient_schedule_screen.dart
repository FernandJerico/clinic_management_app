import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/core/extensions/date_time_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/buttons.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/enums/pasient_status.dart';
import '../../../../core/themes/colors.dart';
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

  var columns = [
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
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          Row(
            children: [
              Badge(
                backgroundColor: PasientStatus.waiting.color,
                smallSize: 18.0,
              ),
              const SpaceWidth(4.0),
              Text(PasientStatus.waiting.value),
              const SpaceWidth(40.0),
              Badge(
                backgroundColor: PasientStatus.processing.color,
                smallSize: 18.0,
              ),
              const SpaceWidth(4.0),
              Text(PasientStatus.processing.value),
              const SpaceWidth(40.0),
              Badge(
                backgroundColor: PasientStatus.onHold.color,
                smallSize: 18.0,
              ),
              const SpaceWidth(4.0),
              Text(PasientStatus.onHold.value),
              const SpaceWidth(40.0),
              Badge(
                backgroundColor: PasientStatus.completed.color,
                smallSize: 18.0,
              ),
              const SpaceWidth(4.0),
              Text(PasientStatus.completed.value),
            ],
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
                                    DataCell(Text(patient.patient!.name ?? '')),
                                    DataCell(Text(
                                        '${patient.complaint!.length > 10 ? patient.complaint!.substring(0, 10) : patient.complaint!}...')),
                                    DataCell(
                                        Text(patient.patient!.gender ?? '')),
                                    DataCell(Text(patient.patient!.birthDate!
                                        .toFormattedDate())),
                                    DataCell(Text(patient.patient!.nik ?? '')),
                                    DataCell(ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: ColoredBox(
                                        color: patient.status == 'waiting'
                                            ? PasientStatus
                                                .waiting.backgroundColor
                                            : patient.status == 'processing'
                                                ? PasientStatus
                                                    .processing.backgroundColor
                                                : patient.status == 'onHold'
                                                    ? PasientStatus
                                                        .onHold.backgroundColor
                                                    : patient.status ==
                                                            'completed'
                                                        ? PasientStatus
                                                            .completed
                                                            .backgroundColor
                                                        : patient.status ==
                                                                'canceled'
                                                            ? PasientStatus
                                                                .rejected
                                                                .backgroundColor
                                                            : patient.status ==
                                                                    'processed'
                                                                ? PasientStatus
                                                                    .processed
                                                                    .backgroundColor
                                                                : AppColors
                                                                    .white,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 8.0),
                                          child: Text(
                                            patient.status ?? '',
                                            style: TextStyle(
                                              color: patient.status == 'waiting'
                                                  ? PasientStatus.waiting.color
                                                  : patient.status ==
                                                          'processing'
                                                      ? PasientStatus
                                                          .processing.color
                                                      : patient.status ==
                                                              'onHold'
                                                          ? PasientStatus
                                                              .onHold.color
                                                          : patient.status ==
                                                                  'completed'
                                                              ? PasientStatus
                                                                  .completed
                                                                  .color
                                                              : patient.status ==
                                                                      'canceled'
                                                                  ? PasientStatus
                                                                      .rejected
                                                                      .color
                                                                  : patient.status ==
                                                                          'processed'
                                                                      ? PasientStatus
                                                                          .processed
                                                                          .color
                                                                      : AppColors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                                    DataCell(
                                      PopupMenuButton<PasientStatus>(
                                        offset: const Offset(0, 50),
                                        icon: const Icon(Icons.more_horiz),
                                        itemBuilder: (BuildContext context) =>
                                            <PopupMenuEntry<PasientStatus>>[
                                          const PopupMenuItem<PasientStatus>(
                                            value: PasientStatus.processing,
                                            child: _PopupMenuItemValue(
                                                PasientStatus.processing),
                                          ),
                                          const PopupMenuItem<PasientStatus>(
                                            value: PasientStatus.onHold,
                                            child: _PopupMenuItemValue(
                                                PasientStatus.onHold),
                                          ),
                                          const PopupMenuItem<PasientStatus>(
                                            value: PasientStatus.waiting,
                                            child: _PopupMenuItemValue(
                                                PasientStatus.waiting),
                                          ),
                                          const PopupMenuItem<PasientStatus>(
                                            value: PasientStatus.completed,
                                            child: _PopupMenuItemValue(
                                                PasientStatus.completed),
                                          ),
                                          const PopupMenuItem<PasientStatus>(
                                            value: PasientStatus.rejected,
                                            child: _PopupMenuItemValue(
                                                PasientStatus.rejected),
                                          ),
                                        ],
                                        onSelected: (PasientStatus value) {
                                          if (value == PasientStatus.waiting) {
                                            // createPatientTap(patientSchedules);
                                          } else {
                                            scaffoldkey.currentState!
                                                .openEndDrawer();
                                          }
                                        },
                                      ),
                                    )
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
  final PasientStatus item;
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
