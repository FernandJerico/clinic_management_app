import 'package:clinic_management_app/core/assets/assets.gen.dart';
import 'package:clinic_management_app/core/components/button_gradient.dart';
import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../../core/components/buttons.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/themes/colors.dart';
import '../bloc/accept_reservation/accept_reservation_bloc.dart';
import '../bloc/data_reservation/data_reservation_bloc.dart';
import '../widgets/build_app_bar.dart';

class DataReservationScreen extends StatefulWidget {
  const DataReservationScreen({super.key});

  @override
  State<DataReservationScreen> createState() => _DataReservationScreenState();
}

class _DataReservationScreenState extends State<DataReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  final searchController = TextEditingController();
  final messageController = TextEditingController();

  String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  @override
  void dispose() {
    searchController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    context
        .read<DataReservationBloc>()
        .add(const DataReservationEvent.getReservationData());
    initializeDateFormatting('id_ID', null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: BuildAppBar(
          title: 'Data Reservasi',
          withSearchInput: true,
          searchController: searchController,
          keyboardType: TextInputType.text,
          withBackButton: true,
          searchChanged: (value) {
            if (value.isNotEmpty) {
              context.read<DataReservationBloc>().add(
                  DataReservationEvent.getReservationDataByName(
                      searchController.text));
            } else {
              context
                  .read<DataReservationBloc>()
                  .add(const DataReservationEvent.getReservationData());
            }
          },
          searchHint: 'Cari Reseverasi',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Reservasi Online',
              style: GoogleFonts.poppins(
                  fontSize: 21, fontWeight: FontWeight.bold),
            ),
            const SpaceHeight(16.0),
            Expanded(
              child: BlocBuilder<DataReservationBloc, DataReservationState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    loaded: (reservations) {
                      return ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SpaceHeight(16),
                        itemCount: reservations.length,
                        itemBuilder: (context, index) {
                          final history = reservations[index];
                          return Container(
                            height: context.deviceHeight * 0.14,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.stroke),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: double.infinity,
                                  width: 16,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      bottomLeft: Radius.circular(12),
                                    ),
                                  ),
                                ),
                                const SpaceWidth(8),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            history.patient?.name ?? '',
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.black),
                                          ),
                                          Text(
                                            '${history.patient?.gender} (${DateFormat('d MMMM yyyy', 'id_ID').format(history.patient?.birthDate ?? DateTime.now())}) Umur ${DateTime.now().year - history.patient!.birthDate!.year} Tahun',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: AppColors.black),
                                          ),
                                          Text(
                                            history.doctor?.polyclinic ?? '',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: AppColors.black),
                                          ),
                                          Text(
                                            'Waktu Kedatangan: ${DateFormat('EEEE, dd-MM-yyyy', 'id_ID').format(history.dayAppointment!)} Jam ${history.timeAppointment} WIB',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.black),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 0),
                                            height: 24,
                                            decoration: BoxDecoration(
                                              color: history.status == 'pending'
                                                  ? AppColors.orderIsWaiting
                                                      .withOpacity(0.25)
                                                  : history.status == 'approved'
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
                                              'Status: ${capitalize(history.status.toString())}',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
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
                                          const SpaceWidth(16),
                                          PopupMenuButton(
                                            color: Colors.white,
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            offset: const Offset(-20, 0),
                                            icon: SvgPicture.asset(
                                                Assets.icons.action.path),
                                            itemBuilder: (context) {
                                              return [
                                                PopupMenuItem(
                                                  height: 36,
                                                  child: Text(
                                                    'Detail Reservasi',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  onTap: () {
                                                    showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return Dialog(
                                                          backgroundColor:
                                                              AppColors.white,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Container(
                                                              width: context
                                                                      .deviceWidth *
                                                                  0.8,
                                                              height: context
                                                                      .deviceHeight *
                                                                  0.5,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      16.0),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Container(
                                                                        height: context.deviceHeight *
                                                                            0.34,
                                                                        width: context.deviceWidth *
                                                                            0.38,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius: BorderRadius.circular(4),
                                                                            boxShadow: [
                                                                              BoxShadow(
                                                                                color: AppColors.black.withOpacity(0.25),
                                                                                spreadRadius: 0,
                                                                                blurRadius: 2,
                                                                                offset: const Offset(0, 1),
                                                                              ),
                                                                            ]),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              8.0),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                'Data Pasien',
                                                                                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
                                                                              ),
                                                                              const Divider(),
                                                                              const SizedBox(height: 8),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      history.patient!.name ?? '',
                                                                                      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.black),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                                                                    height: 24,
                                                                                    decoration: BoxDecoration(
                                                                                      color: history.patient!.status == 0
                                                                                          ? AppColors.orderIsWaiting.withOpacity(0.25)
                                                                                          : history.patient!.status == 1
                                                                                              ? AppColors.orderIsCompleted.withOpacity(0.25)
                                                                                              : AppColors.orderIsRejected.withOpacity(0.25),
                                                                                      borderRadius: BorderRadius.circular(4),
                                                                                      border: Border.all(
                                                                                        color: history.patient!.status == 0
                                                                                            ? AppColors.orderIsWaiting
                                                                                            : history.patient!.status == 1
                                                                                                ? AppColors.orderIsCompleted
                                                                                                : AppColors.orderIsRejected,
                                                                                      ),
                                                                                    ),
                                                                                    alignment: Alignment.center,
                                                                                    child: Text(
                                                                                      history.patient!.status == 0
                                                                                          ? 'Pasien Baru'
                                                                                          : history.patient!.status == 1
                                                                                              ? 'Pasien Terdaftar'
                                                                                              : 'Rejected',
                                                                                      textAlign: TextAlign.center,
                                                                                      style: GoogleFonts.poppins(
                                                                                        fontSize: 14,
                                                                                        color: history.patient!.status == 0
                                                                                            ? AppColors.orderIsWaiting
                                                                                            : history.patient!.status == 1
                                                                                                ? AppColors.orderIsCompleted
                                                                                                : AppColors.orderIsRejected,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              const SizedBox(height: 4),
                                                                              Text(
                                                                                history.patient!.gender ?? '',
                                                                                style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.black),
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 8,
                                                                              ),
                                                                              Text(
                                                                                '${DateFormat('dd MMMM yyyy').format(history.patient!.birthDate ?? DateTime.now())} (${DateTime.now().year - history.patient!.birthDate!.year} Tahun)',
                                                                                style: GoogleFonts.poppins(fontSize: 15, color: AppColors.black),
                                                                              ),
                                                                              const SizedBox(height: 2),
                                                                              Text(
                                                                                'Email: ${history.patient!.email}',
                                                                                style: GoogleFonts.poppins(fontSize: 15, color: AppColors.black),
                                                                              ),
                                                                              const SizedBox(height: 2),
                                                                              Text(
                                                                                'Nomor Telepon: ${history.patient!.phone}',
                                                                                style: GoogleFonts.poppins(fontSize: 15, color: AppColors.black),
                                                                              ),
                                                                              const SizedBox(height: 2),
                                                                              Text(
                                                                                'NIK: ${history.patient!.nik}',
                                                                                style: GoogleFonts.poppins(fontSize: 15, color: AppColors.black),
                                                                              ),
                                                                              const SizedBox(height: 12),
                                                                              Text.rich(TextSpan(
                                                                                text: 'Note Klinik: ',
                                                                                style: GoogleFonts.poppins(fontSize: 15, color: AppColors.red, fontWeight: FontWeight.bold),
                                                                                children: [
                                                                                  TextSpan(
                                                                                    text: history.note ?? '-',
                                                                                    style: GoogleFonts.poppins(fontSize: 15, color: Colors.black),
                                                                                  ),
                                                                                ],
                                                                              )),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        height: context.deviceHeight *
                                                                            0.34,
                                                                        width: context.deviceWidth *
                                                                            0.38,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius: BorderRadius.circular(4),
                                                                            boxShadow: [
                                                                              BoxShadow(
                                                                                color: AppColors.black.withOpacity(0.25),
                                                                                spreadRadius: 0,
                                                                                blurRadius: 2,
                                                                                offset: const Offset(0, 1),
                                                                              ),
                                                                            ]),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              8.0),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                'Data Detail Reservasi',
                                                                                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
                                                                              ),
                                                                              const Divider(),
                                                                              const SizedBox(height: 8),
                                                                              Row(
                                                                                children: [
                                                                                  Container(
                                                                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                                                                    height: 24,
                                                                                    decoration: BoxDecoration(
                                                                                      color: history.status == 'pending'
                                                                                          ? AppColors.orderIsWaiting.withOpacity(0.25)
                                                                                          : history.status == 'approved'
                                                                                              ? AppColors.orderIsCompleted.withOpacity(0.25)
                                                                                              : AppColors.orderIsRejected.withOpacity(0.25),
                                                                                      borderRadius: BorderRadius.circular(4),
                                                                                      border: Border.all(
                                                                                        color: history.status == 'pending'
                                                                                            ? AppColors.orderIsWaiting
                                                                                            : history.status == 'approved'
                                                                                                ? AppColors.orderIsCompleted
                                                                                                : AppColors.orderIsRejected,
                                                                                      ),
                                                                                    ),
                                                                                    alignment: Alignment.center,
                                                                                    child: Text(
                                                                                      'Status: ${history.status == 'pending' ? 'Menunggu Persetujuan' : history.status == 'approved' ? 'Reservasi Disetujui' : 'Reservasi Ditolak'}',
                                                                                      textAlign: TextAlign.center,
                                                                                      style: GoogleFonts.poppins(
                                                                                        fontSize: 14,
                                                                                        color: history.status == 'pending'
                                                                                            ? AppColors.orderIsWaiting
                                                                                            : history.status == 'approved'
                                                                                                ? AppColors.orderIsCompleted
                                                                                                : AppColors.orderIsRejected,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              const SizedBox(height: 4),
                                                                              Text(
                                                                                'Dokter: ${history.doctor!.doctorName}',
                                                                                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.black),
                                                                              ),
                                                                              const SizedBox(height: 4),
                                                                              Text(
                                                                                'Spesialis: ${history.doctor!.doctorSpecialist}',
                                                                                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.black),
                                                                              ),
                                                                              const SizedBox(height: 4),
                                                                              Text(
                                                                                'Hari: ${DateFormat('EEEE, dd-MM-yyyy', 'id_ID').format(history.dayAppointment!)}',
                                                                                style: GoogleFonts.poppins(fontSize: 15, color: AppColors.black),
                                                                              ),
                                                                              const SizedBox(height: 2),
                                                                              Text(
                                                                                'Jam: ${history.timeAppointment} WIB',
                                                                                style: GoogleFonts.poppins(fontSize: 15, color: AppColors.black),
                                                                              ),
                                                                              const SizedBox(height: 2),
                                                                              Text(
                                                                                'Penjamin Kesehatan: ${history.guarantor}',
                                                                                style: GoogleFonts.poppins(fontSize: 15, color: AppColors.black),
                                                                              ),
                                                                              const SizedBox(height: 2),
                                                                              Text(
                                                                                'Nomor BPJS: ${history.bpjsNumber}',
                                                                                style: GoogleFonts.poppins(fontSize: 15, color: AppColors.black),
                                                                              ),
                                                                              const SizedBox(height: 2),
                                                                              Text(
                                                                                'Keluhan: ${history.complaint}',
                                                                                style: GoogleFonts.poppins(fontSize: 15, color: AppColors.black),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          20),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: [
                                                                      ButtonGradient.filled(
                                                                          width: 200,
                                                                          onPressed: () {
                                                                            context.pop();
                                                                          },
                                                                          label: 'Close'),
                                                                      if (history
                                                                              .status ==
                                                                          'pending')
                                                                        ButtonGradient.filled(
                                                                            width: 200,
                                                                            onPressed: () {
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (context) {
                                                                                  return AlertDialog(
                                                                                    backgroundColor: Colors.white,
                                                                                    title: const Text('Accept Reservation'),
                                                                                    content: Form(
                                                                                      key: _formKey,
                                                                                      child: Column(
                                                                                        mainAxisSize: MainAxisSize.min,
                                                                                        children: [
                                                                                          TextFormField(
                                                                                            maxLines: 3,
                                                                                            controller: messageController,
                                                                                            decoration: InputDecoration(
                                                                                              hintText: 'Masukkan Pesan',
                                                                                              border: OutlineInputBorder(
                                                                                                borderRadius: BorderRadius.circular(8),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          const SpaceHeight(16),
                                                                                          Row(
                                                                                            children: [
                                                                                              ElevatedButton(
                                                                                                  style: ElevatedButton.styleFrom(
                                                                                                    backgroundColor: Colors.white,
                                                                                                    shape: RoundedRectangleBorder(
                                                                                                      side: const BorderSide(color: AppColors.primary),
                                                                                                      borderRadius: BorderRadius.circular(8),
                                                                                                    ),
                                                                                                  ),
                                                                                                  onPressed: () {
                                                                                                    context.pop();
                                                                                                    messageController.clear();
                                                                                                  },
                                                                                                  child: Text(
                                                                                                    'Cancel',
                                                                                                    style: GoogleFonts.poppins(fontSize: 18, color: AppColors.primary),
                                                                                                  )),
                                                                                              const SpaceWidth(32),
                                                                                              BlocListener<AcceptReservationBloc, AcceptReservationState>(
                                                                                                listener: (context, state) {
                                                                                                  state.maybeWhen(
                                                                                                      orElse: () {},
                                                                                                      success: () {
                                                                                                        context.pop();
                                                                                                        context.pop();
                                                                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                                                                          const SnackBar(
                                                                                                            backgroundColor: AppColors.green,
                                                                                                            content: Text('Reservation accepted successfully'),
                                                                                                          ),
                                                                                                        );
                                                                                                        context.read<DataReservationBloc>().add(const DataReservationEvent.getReservationData());
                                                                                                      },
                                                                                                      error: (message) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                                            content: Text(message),
                                                                                                            backgroundColor: AppColors.red,
                                                                                                          )));
                                                                                                },
                                                                                                child: ElevatedButton(
                                                                                                    style: ElevatedButton.styleFrom(
                                                                                                      backgroundColor: AppColors.primary,
                                                                                                      shape: RoundedRectangleBorder(
                                                                                                        side: const BorderSide(color: AppColors.primary),
                                                                                                        borderRadius: BorderRadius.circular(8),
                                                                                                      ),
                                                                                                    ),
                                                                                                    onPressed: () {
                                                                                                      if (_formKey.currentState!.validate()) {
                                                                                                        context.read<AcceptReservationBloc>().add(AcceptReservationEvent.acceptReservation(reservationId: history.id.toString(), patientId: history.patient!.id.toString(), status: 'approved', message: messageController.text));
                                                                                                      }
                                                                                                    },
                                                                                                    child: Text(
                                                                                                      'Accept',
                                                                                                      style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
                                                                                                    )),
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              );
                                                                            },
                                                                            label: 'Accept'),
                                                                      if (history
                                                                              .status ==
                                                                          'pending')
                                                                        Button.filled(
                                                                            width:
                                                                                200,
                                                                            color: AppColors
                                                                                .orderIsRejected,
                                                                            onPressed:
                                                                                () {},
                                                                            label:
                                                                                'Reject')
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ];
                                            },
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
