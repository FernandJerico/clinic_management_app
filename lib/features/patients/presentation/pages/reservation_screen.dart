import 'package:clinic_management_app/core/assets/assets.gen.dart';
import 'package:clinic_management_app/core/components/button_gradient.dart';
import 'package:clinic_management_app/core/components/custom_dropdown.dart';
import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/features/patients/data/model/request/add_reservation_request_model.dart';
import 'package:clinic_management_app/features/patients/presentation/bloc/reservation/reservation_bloc.dart';
import 'package:clinic_management_app/features/patients/presentation/pages/add_patient_screen.dart';
import 'package:clinic_management_app/features/patients/presentation/widgets/success_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../../core/themes/colors.dart';
import '../../../auth/data/datasources/auth_local_datasources.dart';
import '../../../master/data/models/response/doctor_schedule_response_model.dart';
import '../../../master/presentation/bloc/data_doctor/data_doctor_bloc.dart';
import '../../../navbar/presentation/pages/navbar_screen.dart';
import '../bloc/get_doctor_schedules/get_doctor_schedules_bloc.dart';
import '../bloc/get_patient/get_patient_bloc.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _dayAppointmentController = TextEditingController();
  final _bpjsController = TextEditingController();
  final _complaintController = TextEditingController();

  String? _selectedGuarantor;
  final List<String> _guarantors = [
    'Pribadi',
    'BPJS Kesehatan',
  ];

  int? _selectedPatient;

  int? _selectedDoctor;

  String? _selectedTimeArrival;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null);
    context.read<GetPatientBloc>().add(const GetPatientEvent.getPatient());
    context.read<DataDoctorBloc>().add(const DataDoctorEvent.getDoctors());
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _dayAppointmentController.dispose();
    _bpjsController.dispose();
    _complaintController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocBuilder<GetPatientBloc, GetPatientState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Center(child: CircularProgressIndicator());
                },
                loaded: (patients) {
                  if (patients.isEmpty) {
                    return InkWell(
                      onTap: () {
                        context.push(const AddPatientScreen());
                      },
                      child: Center(
                        child: Container(
                          width: double.infinity,
                          height: context.deviceHeight * 0.2,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 3,
                                    color: AppColors.grey,
                                    offset: Offset(0, 1),
                                    spreadRadius: 2),
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                  Assets.images.dashboard.newPatient.path),
                              const SizedBox(height: 16),
                              Text(
                                'Tambah Pasien Untuk\nMelanjutkan Reservasi',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  // return Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     InkWell(
                  //       onTap: () {
                  //         context.push(const AddPatientScreen());
                  //       },
                  //       child: Container(
                  //         width: context.deviceWidth * 0.425,
                  //         height: context.deviceHeight * 0.2,
                  //         padding: const EdgeInsets.all(8),
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(4),
                  //             color: Colors.white,
                  //             boxShadow: const [
                  //               BoxShadow(
                  //                   blurRadius: 2,
                  //                   color: AppColors.grey,
                  //                   offset: Offset(0, 2),
                  //                   spreadRadius: 2),
                  //             ]),
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Image.asset(
                  //                 Assets.images.dashboard.newPatient.path),
                  //             const SizedBox(height: 16),
                  //             Text(
                  //               'Tambah Pasien Baru',
                  //               textAlign: TextAlign.center,
                  //               style: GoogleFonts.poppins(
                  //                 fontSize: 14,
                  //                 fontWeight: FontWeight.bold,
                  //                 color: AppColors.primary,
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     InkWell(
                  //       onTap: () {},
                  //       child: Container(
                  //         width: context.deviceWidth * 0.425,
                  //         height: context.deviceHeight * 0.2,
                  //         padding: const EdgeInsets.all(8),
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(4),
                  //             color: Colors.white,
                  //             boxShadow: const [
                  //               BoxShadow(
                  //                   blurRadius: 2,
                  //                   color: AppColors.grey,
                  //                   offset: Offset(0, 2),
                  //                   spreadRadius: 2),
                  //             ]),
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Image.asset(
                  //                 Assets.images.dashboard.newPatient.path),
                  //             const SizedBox(height: 8),
                  //             Text(
                  //               'Nama',
                  //               style: GoogleFonts.poppins(
                  //                   fontSize: 14,
                  //                   fontWeight: FontWeight.bold,
                  //                   color: AppColors.primary),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // );
                  return formReservation(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Form formReservation(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          BlocBuilder<GetPatientBloc, GetPatientState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return CustomDropdown(
                    value: _selectedPatient,
                    items: const [],
                    label: 'Nama Lengkap',
                    onChanged: (value) {},
                  );
                },
                loaded: (patients) {
                  if (patients.isEmpty) {
                    return Column(
                      children: [
                        Text(
                          'Belum ada pasien yang terdaftar',
                          style: GoogleFonts.poppins(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        ButtonGradient.filled(
                            onPressed: () {
                              context.push(const AddPatientScreen());
                            },
                            label: 'Tambah Data')
                      ],
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama Lengkap',
                        style: GoogleFonts.poppins(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<int>(
                        dropdownColor: Colors.white,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: 'Nama Lengkap',
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
                        value: _selectedPatient,
                        items: patients.map((patient) {
                          return DropdownMenuItem<int>(
                            value: patient.id,
                            child: Text(patient.name ?? ''),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedPatient = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Tolong pilih nama pasien Anda';
                          }
                          return null;
                        },
                      ),
                    ],
                  );
                },
              );
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
          BlocBuilder<DataDoctorBloc, DataDoctorState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return CustomDropdown(
                    value: _selectedPatient,
                    items: const [],
                    label: 'Dokter',
                    onChanged: (value) {},
                  );
                },
                loaded: (doctors) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dokter',
                        style: GoogleFonts.poppins(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<int>(
                        isExpanded: true,
                        dropdownColor: Colors.white,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: 'Dokter',
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
                        value: _selectedDoctor,
                        items: doctors.map((doctor) {
                          return DropdownMenuItem<int>(
                            value: doctor.id,
                            child: Text(
                                '${doctor.doctorName} (Poli ${doctor.polyclinic})'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedDoctor = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Tolong pilih dokter yang Anda tuju';
                          }
                          return null;
                        },
                      ),
                    ],
                  );
                },
              );
            },
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
                  DateTime initialDate = DateTime.now();
                  if (initialDate.weekday == DateTime.sunday) {
                    // Jika hari ini adalah Minggu, pilih tanggal besok sebagai initialDate
                    initialDate = initialDate.add(const Duration(days: 1));
                  }
                  DateTime? selectedDayAppointment = await showDatePicker(
                    context: context,
                    initialDate: initialDate,
                    firstDate: initialDate,
                    lastDate: initialDate.add(const Duration(days: 7)),
                    selectableDayPredicate: (DateTime date) {
                      // Disable Sundays
                      return date.weekday != DateTime.sunday;
                    },
                  );
                  if (selectedDayAppointment != null) {
                    setState(() {
                      _dayAppointmentController.text =
                          DateFormat('EEEE, dd-MM-yyyy', 'id_ID')
                              .format(selectedDayAppointment);
                    });
                  }
                  if (context.mounted) {
                    context.read<GetDoctorSchedulesBloc>().add(
                          GetDoctorSchedulesEvent.getDoctorSchedules(
                              doctorId: _selectedDoctor.toString(),
                              day: DateFormat('EEEE', 'id_ID')
                                  .format(selectedDayAppointment!)),
                        );
                  }
                  debugPrint('value: $_selectedDoctor');
                  debugPrint(
                      'value: ${DateFormat('EEEE', 'id_ID').format(selectedDayAppointment!)}');
                },
                readOnly: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.calendar_today,
                    color: AppColors.primary,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
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
            ],
          ),
          const SizedBox(height: 10),
          BlocBuilder<GetDoctorSchedulesBloc, GetDoctorSchedulesState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return CustomDropdown(
                    value: _selectedTimeArrival,
                    items: const [],
                    label: 'Waktu Kedatangan',
                    onChanged: (value) {},
                  );
                },
                loaded: (doctorSchedules) {
                  // Mendapatkan waktu sekarang
                  DateTime now = DateTime.now();

                  // Mendapatkan hari yang dipilih dari controller
                  DateTime selectedDay;
                  try {
                    selectedDay = DateFormat('EEEE, dd-MM-yyyy', 'id_ID')
                        .parse(_dayAppointmentController.text);
                  } catch (e) {
                    selectedDay = now; // Default ke hari ini jika parsing gagal
                  }

                  // Filter jadwal berdasarkan waktu sekarang jika hari yang dipilih adalah hari ini
                  final filteredSchedules = selectedDay.isSameDate(now)
                      ? doctorSchedules.where((schedule) {
                          DateTime scheduleTime =
                              DateFormat('HH:mm').parse(schedule.time!);
                          return scheduleTime.isAfter(DateFormat('HH:mm')
                              .parse(DateFormat('HH:mm').format(now)));
                        }).toList()
                      : doctorSchedules;

                  // Jika tidak ada jadwal yang tersedia, tambahkan item "Tidak ada jadwal lagi"
                  bool noScheduleAvailable = filteredSchedules.isEmpty;
                  if (noScheduleAvailable) {
                    filteredSchedules.add(
                      DoctorSchedule(
                        time: 'Tidak ada jadwal lagi',
                        // tambahkan properti lain sesuai dengan kelas DoctorSchedule
                      ),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Waktu Kedatangan',
                        style: GoogleFonts.poppins(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        dropdownColor: Colors.white,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
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
                        items: filteredSchedules.map((schedule) {
                          bool isNotSelectable = noScheduleAvailable &&
                              schedule.time == 'Tidak Terdapat Jadwal';
                          return DropdownMenuItem<String>(
                            value: isNotSelectable ? null : schedule.time,
                            enabled: !isNotSelectable,
                            child: Text(schedule.time ?? ''),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null &&
                              value != 'Tidak Terdapat Jadwal') {
                            setState(() {
                              _selectedTimeArrival = value;
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null ||
                              value == 'Tidak Terdapat Jadwali') {
                            return 'Tolong pilih waktu kedatangan Anda';
                          }
                          return null;
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jaminan Kesehatan',
                style: GoogleFonts.poppins(
                    fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: 'Jaminan Kesehatan',
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 12,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  hintStyle: GoogleFonts.poppins(fontSize: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                value: _selectedGuarantor,
                items: _guarantors.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGuarantor = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Tolong pilih jaminan kesehatan Anda';
                  }
                  return null;
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          BuildTextFormField(
            titleText: 'Nomor Jaminan Kesehatan (Jika Ada)',
            hintText: 'Masukkan Nomor Jaminan Kesehatan Anda',
            controller: _bpjsController,
          ),
          const SizedBox(height: 10),
          BuildTextFormField(
            titleText: 'Keluhan Anda',
            hintText: 'Masukkan Keluhan Anda',
            controller: _complaintController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Keluhan wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 28),
          BlocConsumer<ReservationBloc, ReservationState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                success: () {
                  return showDialog(
                    context: context,
                    builder: (context) => SuccessDialog(
                      message: 'Reservasi Berhasil!',
                      buttonText: 'Kembali',
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const NavbarScreen(initialSelectedItem: 2),
                          ),
                          (route) => false,
                        );
                      },
                    ),
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
                      onPressed: () async {
                        final userId =
                            await AuthLocalDatasources().getAuthData();
                        if (_formKey.currentState!.validate()) {
                          final createReservationPatient =
                              CreateReservationRequestModel(
                            userId: userId!.user!.id.toString(),
                            patientId: _selectedPatient.toString(),
                            phone: _phoneController.text,
                            doctorId: _selectedDoctor.toString(),
                            dayAppointment: _dayAppointmentController.text,
                            timeAppointment: _selectedTimeArrival,
                            guarantor: _selectedGuarantor,
                            bpjsNumber: _bpjsController.text.isEmpty
                                ? null
                                : _bpjsController.text,
                            complaint: _complaintController.text,
                          );
                          if (context.mounted) {
                            context.read<ReservationBloc>().add(
                                  ReservationEvent.createReservation(
                                      data: createReservationPatient),
                                );
                          }
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
                  return ButtonGradient.loading(
                    height: 48,
                    label: '',
                    onPressed: () {},
                  );
                },
              );
            },
          ),
        ],
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
    this.validator,
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
