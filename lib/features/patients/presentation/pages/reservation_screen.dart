import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/themes/colors.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateController = TextEditingController();
  String? _selectedGender;
  final List<String> _genders = ['Laki-Laki', 'Perempuan'];
  String? _selectedPolyclinic;
  final List<String> _polyclinics = ['Poli 1', 'Poli 2', 'Poli 3'];
  String? _selectedDayArrival;
  final List<String> _dayArrival = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu'
  ];
  String? _selectedTimeArrival;
  final List<String> _timeArrival = [
    '08:00',
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              BuildTextFormField(
                titleText: 'Nama Lengkap',
                hintText: 'Masukkan Nama Lengkap Anda',
                controller: _nameController,
              ),
              const SizedBox(height: 10),
              BuildTextFormField(
                titleText: 'Nomor Telepon',
                hintText: 'Masukkan Nomor Telepon Anda',
                controller: _phoneController,
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jenis Kelamin',
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Jenis Kelamin',
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 12,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      hintStyle: GoogleFonts.poppins(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    value: _selectedGender,
                    items: _genders.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Tolong pilih jenis kelamin Anda';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tanggal Lahir',
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _dateController,
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1960),
                        lastDate: DateTime.now(),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          _dateController.text =
                              "${selectedDate.toLocal()}".split(' ')[0];
                        });
                      }
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.calendar_today,
                        color: AppColors.primary,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      hintText: 'Masukkan Tanggal Lahir Anda',
                      hintStyle: GoogleFonts.poppins(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Poliklinik',
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Poliklinik',
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 12,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      hintStyle: GoogleFonts.poppins(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    value: _selectedPolyclinic,
                    items: _polyclinics.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedPolyclinic = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Tolong pilih poliklinik yang Anda tuju';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hari Kedatangan',
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Hari Kedatangan',
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 12,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      hintStyle: GoogleFonts.poppins(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    value: _selectedDayArrival,
                    items: _dayArrival.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDayArrival = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Tolong pilih hari kedatangan Anda';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Waktu Kedatangan',
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Waktu Kedatangan',
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 12,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      hintStyle: GoogleFonts.poppins(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    value: _selectedTimeArrival,
                    items: _timeArrival.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedTimeArrival = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Tolong pilih jam kedatangan Anda';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF2B8D77), Color(0xFF00BC00)],
                  ),
                ),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent),
                    onPressed: () {},
                    child: Text(
                      'Buat Reservasi',
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BuildTextFormField extends StatelessWidget {
  final String titleText;
  final String hintText;
  final TextEditingController controller;
  const BuildTextFormField({
    super.key,
    required this.titleText,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText,
          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(fontSize: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    );
  }
}
