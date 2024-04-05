import 'package:flutter/material.dart';

import '../../../../core/components/buttons.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/themes/colors.dart';
import '../../data/models/schedule_mode.dart';
import '../widgets/build_app_bar.dart';

class DataDoctorScheduleScreen extends StatefulWidget {
  const DataDoctorScheduleScreen({super.key});

  @override
  State<DataDoctorScheduleScreen> createState() =>
      _DataDoctorScheduleScreenState();
}

class _DataDoctorScheduleScreenState extends State<DataDoctorScheduleScreen> {
  final searchController = TextEditingController();
  final schedules = [
    ScheduleModel(
      namaDokter: 'Dr. Ryan Setiawan',
      ahli: 'Spesialis Gizi Klinik',
      senin: ['08:00 - 09:00', '13:00 - 14:00'],
      selasa: ['08:00 - 09:00'],
      rabu: ['08:00 - 09:00'],
      kamis: ['08:00 - 09:00', '13:00 - 14:00'],
      jumat: ['08:00 - 09:00'],
      sabtu: ['08:00 - 09:00'],
    ),
    ScheduleModel(
      namaDokter: 'Dr. Fauzan',
      ahli: 'Spesialis Gizi Klinik',
      senin: ['08:00 - 09:00'],
      selasa: ['08:00 - 09:00'],
      rabu: ['08:00 - 09:00', '13:00 - 14:00'],
      kamis: ['08:00 - 09:00'],
      jumat: ['08:00 - 09:00'],
      sabtu: ['08:00 - 09:00', '13:00 - 14:00'],
    ),
    ScheduleModel(
      namaDokter: 'Dr. Setiawan',
      ahli: 'Spesialis Gizi Klinik',
      senin: ['08:00 - 09:00', '13:00 - 14:00'],
      selasa: ['08:00 - 09:00'],
      rabu: ['08:00 - 09:00'],
      kamis: ['08:00 - 09:00'],
      jumat: ['08:00 - 09:00'],
      sabtu: ['08:00 - 09:00'],
    ),
  ];
  late List<ScheduleModel> searchResult;

  @override
  void initState() {
    searchResult = schedules;
    super.initState();
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
          searchChanged: (value) {},
          searchHint: 'Cari Dokter',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.stroke),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              scrollDirection: Axis.horizontal,
              child: DataTable(
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
                  DataColumn(
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Button.filled(
                        onPressed: () {},
                        label: 'Senin',
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
                        label: 'Selasa',
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
                        label: 'Rabu',
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
                        label: 'Kamis',
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
                        label: 'Jum’at',
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
                        label: 'Sabtu',
                        width: null,
                        color: AppColors.title,
                        textColor: AppColors.black.withOpacity(0.5),
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
                rows: searchResult.isEmpty
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
                    : searchResult
                        .map(
                          (schedule) => DataRow(cells: [
                            DataCell(Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  schedule.namaDokter,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(schedule.ahli),
                              ],
                            )),
                            DataCell(Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    schedule.senin.map((e) => Text(e)).toList(),
                              ),
                            )),
                            DataCell(Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: schedule.selasa
                                    .map((e) => Text(e))
                                    .toList(),
                              ),
                            )),
                            DataCell(Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    schedule.rabu.map((e) => Text(e)).toList(),
                              ),
                            )),
                            DataCell(Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    schedule.kamis.map((e) => Text(e)).toList(),
                              ),
                            )),
                            DataCell(Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    schedule.jumat.map((e) => Text(e)).toList(),
                              ),
                            )),
                            DataCell(Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    schedule.sabtu.map((e) => Text(e)).toList(),
                              ),
                            )),
                          ]),
                        )
                        .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
