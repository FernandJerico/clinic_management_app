import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/features/master/data/models/response/master_doctor_response_model.dart';
import 'package:clinic_management_app/features/patients/presentation/bloc/get_doctor_schedules/get_doctor_schedules_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/variables.dart';
import '../../../../core/themes/colors.dart';
import '../../../master/data/models/response/doctor_schedule_response_model.dart';

class DetailDoctorScreen extends StatefulWidget {
  final MasterDoctor doctor;
  const DetailDoctorScreen({super.key, required this.doctor});

  @override
  State<DetailDoctorScreen> createState() => _DetailDoctorScreenState();
}

class _DetailDoctorScreenState extends State<DetailDoctorScreen> {
  @override
  void initState() {
    context.read<GetDoctorSchedulesBloc>().add(
        GetDoctorSchedulesEvent.getDoctorScheduleByDoctorId(
            doctorId: widget.doctor.id.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'Detail Dokter',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Profil Dokter',
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          '${Variables.imageBaseUrl}/${widget.doctor.photo?.replaceAll('public/', '')}',
                          fit: BoxFit.cover,
                          width: ResponsiveWidget.isLargeScreen(context)
                              ? context.deviceWidth * 0.075
                              : context.deviceWidth * 0.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.doctor.doctorName ?? '',
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Spesialis: ${widget.doctor.doctorSpecialist}',
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Poliklinik: ${widget.doctor.polyclinic}',
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jadwal Praktek Dokter',
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      const SizedBox(height: 8),
                      BlocBuilder<GetDoctorSchedulesBloc,
                          GetDoctorSchedulesState>(
                        builder: (context, state) {
                          return state.maybeWhen(orElse: () {
                            return const Center(
                                child: CircularProgressIndicator());
                          }, loaded: (doctorSchedules) {
                            final groupedSchedules =
                                _groupSchedulesByDay(doctorSchedules);

                            return SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: groupedSchedules.entries.map((entry) {
                                  String day = entry.key;
                                  List<DoctorSchedule> schedules = entry.value;

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          day,
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        ...schedules.map((schedule) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 64.0, top: 4.0),
                                            child: Text(
                                              schedule.time ?? '',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12),
                                            ),
                                          );
                                        }).toList(),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          });
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Map<String, List<DoctorSchedule>> _groupSchedulesByDay(
    List<DoctorSchedule> schedules) {
  final Map<String, List<DoctorSchedule>> groupedSchedules = {};

  for (var schedule in schedules) {
    if (!groupedSchedules.containsKey(schedule.day)) {
      groupedSchedules[schedule.day ?? ''] = [];
    }
    groupedSchedules[schedule.day]!.add(schedule);
  }

  return groupedSchedules;
}
