// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/features/patients/data/model/response/history_reservation_response_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/variables.dart';
import '../../../../core/themes/colors.dart';
import 'package:http/http.dart' as http;

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

  Future<void> _requestPermission() async {
    if (await Permission.storage.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    } else {
      // You can request the permission again and handle the case when the user denies it.
      await Permission.storage.request();
    }
  }

  Future<void> _saveImageFromUrl(String imageUrl, String fileName) async {
    await _requestPermission();

    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.bodyBytes),
          quality: 100,
          name: fileName,
        );

        if (result['isSuccess']) {
          ResponsiveWidget.isLargeScreen(context)
              ? AnimatedSnackBar.material('Gambar berhasil disimpan di galeri',
                      type: AnimatedSnackBarType.success,
                      duration: const Duration(seconds: 3),
                      desktopSnackBarPosition: DesktopSnackBarPosition.topLeft)
                  .show(context)
              : AnimatedSnackBar.material(
                  'Gambar berhasil disimpan di galeri',
                  type: AnimatedSnackBarType.success,
                  duration: const Duration(seconds: 3),
                ).show(context);
        } else {
          ResponsiveWidget.isLargeScreen(context)
              ? AnimatedSnackBar.material('Gambar gagal disimpan',
                      type: AnimatedSnackBarType.error,
                      duration: const Duration(seconds: 3),
                      desktopSnackBarPosition: DesktopSnackBarPosition.topLeft)
                  .show(context)
              : AnimatedSnackBar.material(
                  'Gambar gagal disimpan',
                  type: AnimatedSnackBarType.error,
                  duration: const Duration(seconds: 3),
                ).show(context);
        }
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      debugPrint(e.toString());
      ResponsiveWidget.isLargeScreen(context)
          ? AnimatedSnackBar.material('Terjadi kesalahan saat menyimpan gambar',
                  type: AnimatedSnackBarType.error,
                  duration: const Duration(seconds: 3),
                  desktopSnackBarPosition: DesktopSnackBarPosition.topLeft)
              .show(context)
          : AnimatedSnackBar.material(
              'Terjadi kesalahan saat menyimpan gambar',
              type: AnimatedSnackBarType.success,
              duration: const Duration(seconds: 3),
            ).show(context);
    }
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
                height: context.deviceHeight * 0.15,
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
                height: context.deviceHeight * 0.275,
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
                        color: widget.history.status == 'pending'
                            ? AppColors.orderIsWaiting
                            : widget.history.status == 'approved'
                                ? AppColors.orderIsCompleted
                                : widget.history.status == 'completed'
                                    ? Colors.blue
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
                                            : widget.history.status ==
                                                    'completed'
                                                ? Colors.blue.withOpacity(0.25)
                                                : AppColors.orderIsRejected
                                                    .withOpacity(0.25),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: widget.history.status == 'pending'
                                          ? AppColors.orderIsWaiting
                                          : widget.history.status == 'approved'
                                              ? AppColors.orderIsCompleted
                                              : widget.history.status ==
                                                      'completed'
                                                  ? Colors.blue
                                                  : AppColors.orderIsRejected,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Status: ${widget.history.status == 'pending' ? 'Menunggu Persetujuan' : widget.history.status == 'approved' ? 'Reservasi Disetujui' : widget.history.status == 'completed' ? 'Reservasi Selesai' : 'Reservasi Ditolak'}',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: widget.history.status == 'pending'
                                          ? AppColors.orderIsWaiting
                                          : widget.history.status == 'approved'
                                              ? AppColors.orderIsCompleted
                                              : widget.history.status ==
                                                      'completed'
                                                  ? Colors.blue
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
                            Text(
                              'Keluhan: ${widget.history.complaint}',
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
              const SizedBox(height: 10),
              Text('Bukti Pembayaran',
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
                child: widget.history.historyImage == null
                    ? const Center(
                        child: Text(
                          'Tidak ada bukti pembayaran',
                          style:
                              TextStyle(fontSize: 14, color: AppColors.black),
                        ),
                      )
                    : Column(
                        children: [
                          Image.network(
                            '${Variables.imageBaseUrl}/reservation-history-image/${widget.history.historyImage}',
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                            ),
                            onPressed: () {
                              _saveImageFromUrl(
                                '${Variables.imageBaseUrl}/reservation-history-image/${widget.history.historyImage}',
                                'Bukti_Pembayaran_${widget.history.patient!.name}_${widget.history.dayAppointment}_${widget.history.timeAppointment}',
                              );
                            },
                            child: Text(
                              'Simpan Gambar ke Galeri',
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
