import 'package:clinic_management_app/features/patients/data/model/request/add_reservation_request_model.dart';
import 'package:clinic_management_app/features/patients/presentation/bloc/reservation/reservation_bloc.dart';
import 'package:clinic_management_app/features/patients/presentation/widgets/reservation_success_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

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
  final _dayAppointmentController = TextEditingController();
  String? _selectedGender;
  final List<String> _genders = ['Laki-Laki', 'Perempuan'];
  String? _selectedPolyclinic;
  final List<String> _polyclinics = ['Poli 1', 'Poli 2', 'Poli 3'];
  String? _selectedTimeArrival;
  final List<String> _timeArrival = [
    '08:00 - 09.00',
    '09:00 - 10.00',
    '10:00 - 11.00',
    '11:00 - 12.00',
    '13:00 - 14.00',
    '14:00 - 15.00',
    '15:00 - 16.00',
    '16:00 - 17.00',
  ];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                BuildTextFormField(
                  titleText: 'Nama Lengkap',
                  hintText: 'Masukkan Nama Lengkap Anda',
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama Lengkap wajib diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                BuildTextFormField(
                  titleText: 'Nomor Telepon',
                  hintText: 'Masukkan Nomor Telepon Anda',
                  controller: _phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nomor Telepon wajib diisi';
                    }
                    return null;
                  },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tanggal Lahir wajib diisi';
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
                    TextFormField(
                      controller: _dayAppointmentController,
                      onTap: () async {
                        DateTime? selectedDayAppointment = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2024),
                          lastDate: DateTime.now(),
                        );
                        if (selectedDayAppointment != null) {
                          setState(() {
                            _dayAppointmentController.text =
                                DateFormat('EEEE, d MMMM yyyy', 'id_ID')
                                    .format(selectedDayAppointment);
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
                        hintText: 'Hari Kedatangan Anda',
                        hintStyle: GoogleFonts.poppins(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tolong pilih hari kedatangan Anda';
                        }
                        return null;
                      },
                    ),
                    // DropdownButtonFormField<String>(
                    //   decoration: InputDecoration(
                    //     labelText: 'Hari Kedatangan',
                    //     labelStyle: GoogleFonts.poppins(
                    //       fontSize: 12,
                    //     ),
                    //     contentPadding: const EdgeInsets.symmetric(
                    //         vertical: 4, horizontal: 16),
                    //     hintStyle: GoogleFonts.poppins(fontSize: 12),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(4),
                    //     ),
                    //   ),
                    //   value: _selectedDayArrival,
                    //   items: _dayArrival.map((String option) {
                    //     return DropdownMenuItem<String>(
                    //       value: option,
                    //       child: Text(option),
                    //     );
                    //   }).toList(),
                    //   onChanged: (value) {
                    //     setState(() {
                    //       _selectedDayArrival = value;
                    //     });
                    //   },
                    //   validator: (value) {
                    //     if (value == null) {
                    //       return 'Tolong pilih hari kedatangan Anda';
                    //     }
                    //     return null;
                    //   },
                    // ),
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
                BlocConsumer<ReservationBloc, ReservationState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      orElse: () {},
                      success: () {
                        return showDialog(
                          context: context,
                          builder: (context) =>
                              const ReservationSuccessDialog(),
                        );
                      },
                      error: (message) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      },
                    );
                  },
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return Container(
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
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final createReservationPatient =
                                    CreateReservationRequestModel(
                                  userId: '3',
                                  fullname: _nameController.text,
                                  phone: _phoneController.text,
                                  gender: _selectedGender,
                                  birthDate:
                                      DateTime.parse(_dateController.text),
                                  polyclinic: _selectedPolyclinic,
                                  dayAppointment:
                                      _dayAppointmentController.text,
                                  timeAppointment: _selectedTimeArrival,
                                );
                                context.read<ReservationBloc>().add(
                                      ReservationEvent.createReservation(
                                          data: createReservationPatient),
                                    );
                              }
                            },
                            child: Text(
                              'Buat Reservasi',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        );
                      },
                      loading: () {
                        return Container(
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
                            child: const CircularProgressIndicator(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
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
  final String? Function(String?)? validator;
  const BuildTextFormField({
    super.key,
    required this.titleText,
    required this.hintText,
    required this.controller,
    required this.validator,
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
          validator: validator,
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
