import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/features/patients/presentation/bloc/history_reservation/history_reservation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/themes/colors.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final searchController = TextEditingController();
  @override
  void initState() {
    context
        .read<HistoryReservationBloc>()
        .add(const HistoryReservationEvent.getHistoryReservation());
    initializeDateFormatting('id_ID', null);
    super.initState();
  }

  String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              Container(
                height: 56,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      context.read<HistoryReservationBloc>().add(
                          HistoryReservationEvent.getHistoryReservationByName(
                              searchController.text));
                    } else {
                      context.read<HistoryReservationBloc>().add(
                          const HistoryReservationEvent
                              .getHistoryReservation());
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Cari Riwayat',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<HistoryReservationBloc, HistoryReservationState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const CardHistoryReservationShimmerLoading();
                    },
                    loaded: (historyReservations) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 12,
                        ),
                        itemCount: historyReservations.length,
                        itemBuilder: (context, index) {
                          final history = historyReservations[index];
                          return Container(
                            height: context.deviceHeight * 0.145,
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
                            child: Row(
                              children: [
                                Container(
                                  height: double.infinity,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    // ternary for pending, approved, or rejected
                                    color: history.status == 'pending'
                                        ? AppColors.orderIsWaiting
                                        : history.status == 'approved'
                                            ? AppColors.orderIsCompleted
                                            : AppColors.orderIsRejected,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      bottomLeft: Radius.circular(4),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                history.patient!.name ?? '',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.black),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 0),
                                              height: 24,
                                              decoration: BoxDecoration(
                                                color: history.status ==
                                                        'pending'
                                                    ? AppColors.orderIsWaiting
                                                        .withOpacity(0.25)
                                                    : history.status ==
                                                            'approved'
                                                        ? AppColors
                                                            .orderIsCompleted
                                                            .withOpacity(0.25)
                                                        : AppColors
                                                            .orderIsRejected
                                                            .withOpacity(0.25),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                border: Border.all(
                                                  color: history.status ==
                                                          'pending'
                                                      ? AppColors.orderIsWaiting
                                                      : history.status ==
                                                              'approved'
                                                          ? AppColors
                                                              .orderIsCompleted
                                                          : AppColors
                                                              .orderIsRejected,
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                capitalize(
                                                    history.status ?? ''),
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 10,
                                                  color: history.status ==
                                                          'pending'
                                                      ? AppColors.orderIsWaiting
                                                      : history.status ==
                                                              'approved'
                                                          ? AppColors
                                                              .orderIsCompleted
                                                          : AppColors
                                                              .orderIsRejected,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              history.patient!.gender ?? '',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.black),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              DateFormat('dd MMMM yyyy').format(
                                                  history.patient!.birthDate ??
                                                      DateTime.now()),
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: AppColors.black),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          history.phone ?? '',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: AppColors.black),
                                        ),
                                        Text(
                                          history.doctor!.polyclinic ?? '',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: AppColors.black),
                                        ),
                                        Text(
                                          '${DateFormat('EEEE, dd-MM-yyyy', 'id_ID').format(history.dayAppointment!)} Jam ${history.timeAppointment} WIB',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: AppColors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CardHistoryReservationShimmerLoading extends StatelessWidget {
  const CardHistoryReservationShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: context.deviceHeight * 0.135,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: AppColors.grey.withOpacity(0.25),
                blurRadius: 4,
                offset: const Offset(2, 4),
              )
            ],
          ),
        ),
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: 12,
      ),
      itemCount: 3,
    );
  }
}
