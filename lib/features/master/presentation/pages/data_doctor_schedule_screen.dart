import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/features/master/presentation/bloc/data_doctor_schedule/data_doctor_schedule_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/buttons.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/themes/colors.dart';
import '../widgets/build_app_bar.dart';

class DataDoctorScheduleScreen extends StatefulWidget {
  const DataDoctorScheduleScreen({super.key});

  @override
  State<DataDoctorScheduleScreen> createState() =>
      _DataDoctorScheduleScreenState();
}

class _DataDoctorScheduleScreenState extends State<DataDoctorScheduleScreen> {
  final searchController = TextEditingController();

  @override
  void initState() {
    context
        .read<DataDoctorScheduleBloc>()
        .add(const DataDoctorScheduleEvent.getDoctorSchedule());
    super.initState();
  }

  int _sortDays(String a, String b) {
    Map<String, int> dayOrder = {
      'Senin': 1,
      'Selasa': 2,
      'Rabu': 3,
      'Kamis': 4,
      'Jumat': 5,
      'Sabtu': 6,
      'Minggu': 7,
    };

    int indexA = dayOrder[a]!;
    int indexB = dayOrder[b]!;
    return indexA.compareTo(indexB);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: BuildAppBar(
          title: 'Data Master Jadwal Dokter',
          withSearchInput: true,
          searchController: searchController,
          keyboardType: TextInputType.text,
          withBackButton: true,
          searchChanged: (value) {
            if (value.isNotEmpty && value.length > 1) {
              context.read<DataDoctorScheduleBloc>().add(
                    DataDoctorScheduleEvent.getDoctorScheduleByDoctorName(
                      value,
                    ),
                  );
            } else {
              context.read<DataDoctorScheduleBloc>().add(
                    const DataDoctorScheduleEvent.getDoctorSchedule(),
                  );
            }
          },
          searchHint: 'Cari Dokter',
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
              child:
                  BlocBuilder<DataDoctorScheduleBloc, DataDoctorScheduleState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    loaded: (doctorSchedules) {
                      //daftar hari
                      List<String> days =
                          doctorSchedules.map((e) => e.day!).toSet().toList();

                      days.sort(_sortDays);

                      //kelompokan jadwal dokter berdasarkan nama dokter dan hari

                      Map<String, Map<String, String>> groupedSchedules = {};

                      for (var schedule in doctorSchedules) {
                        if (!groupedSchedules
                            .containsKey(schedule.doctor!.doctorName)) {
                          groupedSchedules[schedule.doctor!.doctorName!] = {
                            for (var day in days) day: '-',
                          };
                        }
                        //mengisi jadwal dokter berdasarkan hari
                        groupedSchedules[schedule.doctor!.doctorName!]![
                            schedule.day!] = schedule.time ?? '-';
                      }

                      //membuat datarow dokter berdasarkan hari
                      List<DataRow> dataRows = [];
                      dataRows = groupedSchedules.entries.map((entry) {
                        List<DataCell> cells = [
                          DataCell(
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  entry.key,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(doctorSchedules
                                        .firstWhere((element) =>
                                            element.doctor!.doctorName ==
                                            entry.key)
                                        .doctor!
                                        .doctorSpecialist ??
                                    ''),
                              ],
                            ),
                          ),
                          for (String day in days)
                            DataCell(Center(
                              child: Text(
                                  groupedSchedules[entry.key]![day] ?? '-'),
                            )),
                        ];
                        return DataRow(cells: cells);
                      }).toList();

                      return DataTable(
                        columnSpacing: context.deviceWidth * 0.0225,
                        dataRowMinHeight: 30.0,
                        dataRowMaxHeight: 60.0,
                        columns: [
                          DataColumn(
                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Button.filled(
                                onPressed: () {},
                                label: 'Nama Dokter',
                                width: null,
                                color: AppColors.title,
                                textColor: AppColors.black.withOpacity(0.5),
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          for (String day in days)
                            DataColumn(
                              label: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Button.filled(
                                  onPressed: () {},
                                  label: day,
                                  width: null,
                                  color: AppColors.title,
                                  textColor: AppColors.black.withOpacity(0.5),
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                        ],
                        rows: dataRows.isEmpty
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
                                  ],
                                ),
                              ]
                            : dataRows,
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
