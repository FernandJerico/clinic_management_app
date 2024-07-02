import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/features/master/presentation/widgets/build_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/components/spaces.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../core/themes/colors.dart';
import '../../../master/presentation/widgets/card_shimmer_loading.dart';
import '../bloc/get_medical_record/get_medical_record_bloc.dart';

class MedicalRecordScreen extends StatefulWidget {
  const MedicalRecordScreen({super.key});

  @override
  State<MedicalRecordScreen> createState() => _MedicalRecordScreenState();
}

class _MedicalRecordScreenState extends State<MedicalRecordScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    context
        .read<GetMedicalRecordBloc>()
        .add(const GetMedicalRecordEvent.getMedicalRecord());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: BuildAppBar(
          title: 'Rekam Medis',
          withSearchInput: true,
          searchController: searchController,
          searchChanged: (value) {
            if (value.isNotEmpty) {
              context.read<GetMedicalRecordBloc>().add(
                  GetMedicalRecordEvent.getMedicalRecordByName(
                      searchController.text));
            } else {
              context
                  .read<GetMedicalRecordBloc>()
                  .add(const GetMedicalRecordEvent.getMedicalRecord());
            }
          },
          searchHint: 'Cari Rekam Medis Berdasarkan Nama',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Rekam Medis Pasien',
              style: GoogleFonts.poppins(
                  fontSize: 21, fontWeight: FontWeight.bold),
            ),
            const SpaceHeight(16.0),
            BlocBuilder<GetMedicalRecordBloc, GetMedicalRecordState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
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
                  loaded: (medicalRecords) {
                    if (medicalRecords.isEmpty) {
                      return const Center(
                        child: Text('Data tidak ditemukan'),
                      );
                    }
                    return Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SpaceHeight(16.0);
                        },
                        itemCount: medicalRecords.length,
                        itemBuilder: (context, index) {
                          final medicalRecord = medicalRecords[index];
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
                                        'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                                        height: ResponsiveWidget.isLargeScreen(
                                                context)
                                            ? 85
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
                                        Row(
                                          children: [
                                            Text(
                                              medicalRecord.patient!.name ?? '',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              ' (${medicalRecord.patient!.nik})',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        const SpaceHeight(4.0),
                                        Text(
                                          'Dokter: ${medicalRecord.doctor!.doctorName}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        const SpaceHeight(4.0),
                                        Text(
                                          'Diagnosis: ${medicalRecord.diagnosis}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        const SpaceHeight(4.0),
                                        Text(
                                          'Treatment: ${medicalRecord.medicalTreatments}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Container(
                                    width: context.deviceWidth * 0.1,
                                    margin: const EdgeInsets.only(right: 24),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color:
                                          AppColors.primary.withOpacity(0.13),
                                      border:
                                          Border.all(color: AppColors.primary),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Catatan Dokter:',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          medicalRecord.doctorNotes!.length > 25
                                              ? medicalRecord.doctorNotes!
                                                  .substring(0, 25)
                                              : medicalRecord.doctorNotes!,
                                          style:
                                              GoogleFonts.poppins(fontSize: 12),
                                        ),
                                      ],
                                    ),
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
            )
          ],
        ),
      ),
    );
  }
}
