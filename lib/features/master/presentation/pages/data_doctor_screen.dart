import 'package:clinic_management_app/core/components/components.dart';
import 'package:clinic_management_app/core/constants/responsive.dart';
import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/core/themes/colors.dart';
import 'package:clinic_management_app/features/master/presentation/bloc/data_doctor/data_doctor_bloc.dart';
import 'package:clinic_management_app/features/master/presentation/widgets/build_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/variables.dart';
import '../widgets/card_shimmer_loading.dart';

class DataDoctorScreen extends StatefulWidget {
  const DataDoctorScreen({super.key});

  @override
  State<DataDoctorScreen> createState() => _DataDoctorScreenState();
}

class _DataDoctorScreenState extends State<DataDoctorScreen> {
  final searchController = TextEditingController();

  @override
  void initState() {
    context.read<DataDoctorBloc>().add(const DataDoctorEvent.getDoctors());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: BuildAppBar(
          title: 'Data Master Dokter',
          withSearchInput: true,
          searchController: searchController,
          keyboardType: TextInputType.text,
          withBackButton: true,
          searchChanged: (value) {
            if (value.isNotEmpty && value.length > 2) {
              context
                  .read<DataDoctorBloc>()
                  .add(DataDoctorEvent.getDoctorByName(searchController.text));
            } else {
              context
                  .read<DataDoctorBloc>()
                  .add(const DataDoctorEvent.getDoctors());
            }
          },
          searchHint: 'Cari Dokter Berdasarkan Nama',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Dokter',
              style: GoogleFonts.poppins(
                  fontSize: 21, fontWeight: FontWeight.bold),
            ),
            const SpaceHeight(16.0),
            BlocBuilder<DataDoctorBloc, DataDoctorState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return const Center(child: CircularProgressIndicator());
                  },
                  loading: () {
                    return Expanded(
                      child: ListView.separated(
                        itemCount: 5,
                        itemBuilder: (context, index) =>
                            const CardShimmerLoading(),
                        separatorBuilder: (context, index) =>
                            const SpaceHeight(16),
                      ),
                    );
                  },
                  loaded: (doctors) {
                    return Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 16,
                        ),
                        itemCount: doctors.length,
                        itemBuilder: (context, index) {
                          final doctor = doctors[index];
                          return Container(
                            height: context.deviceHeight * 0.15,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.stroke),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: context.deviceHeight * 0.15,
                                      width: 16,
                                      decoration: const BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomLeft: Radius.circular(12),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Image.network(
                                        '${Variables.imageBaseUrl}/${doctor.photo.replaceAll('public/', '')}',
                                        height: ResponsiveWidget.isLargeScreen(
                                                context)
                                            ? 75
                                            : 50,
                                      ),
                                    ),
                                    const SpaceWidth(8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          doctor.doctorName,
                                          style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SpaceHeight(4.0),
                                        Text(
                                          doctor.doctorPhone,
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        const SpaceHeight(4.0),
                                        Text(
                                          'ID IHS: ${doctor.idIhs}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        const SpaceHeight(4.0),
                                        Text(
                                          'SIP: ${doctor.sip}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 24),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8),
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(4),
                                    border:
                                        Border.all(color: AppColors.primary),
                                  ),
                                  child: Text(
                                    'Spesialis: ${doctor.doctorSpecialist}',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: AppColors.primary),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
