import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/features/patients/data/model/response/history_reservation_response_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/themes/colors.dart';

class DetailHistoryScreen extends StatefulWidget {
  final HistoryReservation history;
  const DetailHistoryScreen({super.key, required this.history});

  @override
  State<DetailHistoryScreen> createState() => _DetailHistoryScreenState();
}

class _DetailHistoryScreenState extends State<DetailHistoryScreen> {
  String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'Detail Reservasi',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Data Pasien',
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black)),
              const SizedBox(height: 10),
              Container(
                height: context.deviceHeight * 0.14,
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
                        color: widget.history.patient!.status == 0
                            ? AppColors.orderIsWaiting
                            : widget.history.patient!.status == 1
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.history.patient!.name ?? '',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 0),
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: widget.history.patient!.status == 0
                                        ? AppColors.orderIsWaiting
                                            .withOpacity(0.25)
                                        : widget.history.patient!.status == 1
                                            ? AppColors.orderIsCompleted
                                                .withOpacity(0.25)
                                            : AppColors.orderIsRejected
                                                .withOpacity(0.25),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: widget.history.patient!.status == 0
                                          ? AppColors.orderIsWaiting
                                          : widget.history.patient!.status == 1
                                              ? AppColors.orderIsCompleted
                                              : AppColors.orderIsRejected,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    widget.history.patient!.status == 0
                                        ? 'Pasien Baru'
                                        : widget.history.patient!.status == 1
                                            ? 'Pasien Terdaftar'
                                            : 'Rejected',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      color: widget.history.patient!.status == 0
                                          ? AppColors.orderIsWaiting
                                          : widget.history.patient!.status == 1
                                              ? AppColors.orderIsCompleted
                                              : AppColors.orderIsRejected,
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
                                  widget.history.patient!.gender ?? '',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '${DateFormat('dd MMMM yyyy').format(widget.history.patient!.birthDate ?? DateTime.now())} (${DateTime.now().year - widget.history.patient!.birthDate!.year} Tahun)',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12, color: AppColors.black),
                                ),
                              ],
                            ),
                            Text(
                              widget.history.patient!.email ?? '',
                              style: GoogleFonts.poppins(
                                  fontSize: 12, color: AppColors.black),
                            ),
                            Text(
                              widget.history.patient!.phone ?? '',
                              style: GoogleFonts.poppins(
                                  fontSize: 12, color: AppColors.black),
                            ),
                            Text(
                              'NIK ${widget.history.patient!.nik}',
                              style: GoogleFonts.poppins(
                                  fontSize: 12, color: AppColors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text('Data Reservasi',
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black)),
              const SizedBox(height: 10),
              Container(
                height: context.deviceHeight * 0.21,
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
                        color: widget.history.status == 'pending'
                            ? AppColors.orderIsWaiting
                            : widget.history.status == 'approved'
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 0),
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: widget.history.status == 'pending'
                                        ? AppColors.orderIsWaiting
                                            .withOpacity(0.25)
                                        : widget.history.status == 'approved'
                                            ? AppColors.orderIsCompleted
                                                .withOpacity(0.25)
                                            : AppColors.orderIsRejected
                                                .withOpacity(0.25),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: widget.history.status == 'pending'
                                          ? AppColors.orderIsWaiting
                                          : widget.history.status == 'approved'
                                              ? AppColors.orderIsCompleted
                                              : AppColors.orderIsRejected,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Status: ${widget.history.status == 'pending' ? 'Menunggu Persetujuan' : widget.history.status == 'approved' ? 'Reservasi Disetujui' : 'Reservasi Ditolak'}',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: widget.history.status == 'pending'
                                          ? AppColors.orderIsWaiting
                                          : widget.history.status == 'approved'
                                              ? AppColors.orderIsCompleted
                                              : AppColors.orderIsRejected,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Dokter: ${widget.history.doctor!.doctorName}',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black),
                            ),
                            Text(
                              'Spesialis: ${widget.history.doctor!.doctorSpecialist}',
                              style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Hari: ${DateFormat('EEEE, dd-MM-yyyy', 'id_ID').format(widget.history.dayAppointment!)}',
                              style: GoogleFonts.poppins(
                                  fontSize: 13, color: AppColors.black),
                            ),
                            Text(
                              'Jam: ${widget.history.timeAppointment} WIB',
                              style: GoogleFonts.poppins(
                                  fontSize: 13, color: AppColors.black),
                            ),
                            Text(
                              'Penjamin Kesehatan: ${widget.history.guarantor}',
                              style: GoogleFonts.poppins(
                                  fontSize: 13, color: AppColors.black),
                            ),
                            Text(
                              'Nomor BPJS: ${widget.history.bpjsNumber}',
                              style: GoogleFonts.poppins(
                                  fontSize: 13, color: AppColors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text('Pesan dari Klinik',
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(8),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Note:',
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.history.note == null
                          ? 'Tidak ada pesan dari klinik'
                          : widget.history.note!,
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
