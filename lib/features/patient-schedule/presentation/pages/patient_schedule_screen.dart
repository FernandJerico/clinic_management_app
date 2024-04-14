import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/core/extensions/date_time_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/buttons.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/enums/pasient_status.dart';
import '../../../../core/themes/colors.dart';
import '../../../master/presentation/dialogs/create_patient_dialog.dart';
import '../../../master/presentation/widgets/build_app_bar.dart';
import '../../data/patient_model.dart';
import '../bloc/patient_schedule/patient_schedule_bloc.dart';

class PatientScheduleScreen extends StatefulWidget {
  const PatientScheduleScreen({super.key});

  @override
  State<PatientScheduleScreen> createState() => _PatientScheduleScreenState();
}

class _PatientScheduleScreenState extends State<PatientScheduleScreen> {
  final searchController = TextEditingController();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final patients = [
    PasientModel(
      nama: 'John Doe',
      keluhan: 'Flu',
      jenisKelamin: 'Laki-laki',
      tanggalLahir: DateTime(1990, 5, 15),
      nik: '1234567890',
      status: PasientStatus.waiting,
    ),
    PasientModel(
      nama: 'Jane Smith',
      keluhan: 'Headache',
      jenisKelamin: 'Perempuan',
      tanggalLahir: DateTime(1985, 8, 21),
      nik: '0987654321',
      status: PasientStatus.processing,
    ),
    PasientModel(
      nama: 'Michael Johnson',
      keluhan: 'Stomachache',
      jenisKelamin: 'Laki-laki',
      tanggalLahir: DateTime(1978, 3, 10),
      nik: '5432167890',
      status: PasientStatus.rejected,
    ),
    PasientModel(
      nama: 'Emily Williams',
      keluhan: 'Fever',
      jenisKelamin: 'Perempuan',
      tanggalLahir: DateTime(1992, 11, 30),
      nik: '0987123456',
      status: PasientStatus.completed,
    ),
    PasientModel(
      nama: 'David Brown',
      keluhan: 'Cough',
      jenisKelamin: 'Laki-laki',
      tanggalLahir: DateTime(1980, 7, 5),
      nik: '6789012345',
      status: PasientStatus.confirmed,
    ),
  ];
  late List<PasientModel> searchResult;

  @override
  void initState() {
    searchResult = patients;
    context
        .read<PatientScheduleBloc>()
        .add(const PatientScheduleEvent.getPatientSchedules());
    super.initState();
  }

  void createPatientTap([PasientModel? patient]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const CreatePatientDialog(),
    );
  }

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
          searchHint: 'Cari Pasien',
          trailing: Button.filled(
            onPressed: () => createPatientTap(),
            label: 'Daftar Pasien',
            width: null,
          ),
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
              borderRadius: BorderRadius.circular(20.0),
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
                      return const Center(child: CircularProgressIndicator());
                    },
                    loaded: (patientSchedules) {
                      return DataTable(
                        columns: [
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
                                label: 'Jenis Kelamnin',
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
                        ],
                        rows: patientSchedules.isEmpty
                            ? [
                                const DataRow(
                                  cells: [
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
                                        color: Colors.grey.withOpacity(0.1),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 8.0),
                                          child: Text(
                                            patient.status ?? '',
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
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
