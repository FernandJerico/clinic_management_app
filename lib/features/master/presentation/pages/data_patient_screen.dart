import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/core/extensions/date_time_ext.dart';
import 'package:clinic_management_app/features/master/presentation/widgets/build_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/buttons.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/themes/colors.dart';
import '../bloc/data_patient/data_patient_bloc.dart';
import '../dialogs/create_patient_dialog.dart';

class DataPatientScreen extends StatefulWidget {
  const DataPatientScreen({super.key});

  @override
  State<DataPatientScreen> createState() => _DataPatientScreenState();
}

class _DataPatientScreenState extends State<DataPatientScreen> {
  final searchController = TextEditingController();

  @override
  void initState() {
    context.read<DataPatientBloc>().add(const DataPatientEvent.getPatients());
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: BuildAppBar(
          title: 'Data Master Pasien',
          withSearchInput: true,
          searchController: searchController,
          searchHint: 'Cari Pasien',
          searchChanged: (value) {
            if (value.isNotEmpty && value.length > 1) {
              context
                  .read<DataPatientBloc>()
                  .add(DataPatientEvent.getPatientByNIK(searchController.text));
            } else {
              context
                  .read<DataPatientBloc>()
                  .add(const DataPatientEvent.getPatients());
            }
          },
          trailing: Button.filled(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const CreatePatientDialog(),
              );
            },
            label: 'Pasien Baru',
            width: 250,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.stroke),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              scrollDirection: Axis.horizontal,
              child: BlocBuilder<DataPatientBloc, DataPatientState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const Center(child: CircularProgressIndicator());
                    },
                    loaded: (patients) {
                      return DataTable(
                        columnSpacing: context.deviceWidth * 0.063,
                        dataRowMinHeight: 30.0,
                        dataRowMaxHeight: 60.0,
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
                                label: 'Alamat Email',
                                width: null,
                                color: AppColors.title,
                                textColor: AppColors.black.withOpacity(0.5),
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ],
                        rows: patients.isEmpty
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
                                          patient.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(patient.gender),
                                      ],
                                    )),
                                    DataCell(
                                        Center(child: Text(patient.gender))),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          patient.birthDate.toFormattedDate(),
                                        ),
                                      ),
                                    ),
                                    DataCell(Center(child: Text(patient.nik))),
                                    DataCell(Text(patient.email)),
                                  ]),
                                )
                                .toList(),
                      );
                    },
                    loading: () {
                      return const Center(child: CircularProgressIndicator());
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
