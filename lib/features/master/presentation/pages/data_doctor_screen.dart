import 'dart:io';

import 'package:clinic_management_app/core/components/button_gradient.dart';
import 'package:clinic_management_app/core/components/components.dart';
import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/core/themes/colors.dart';
import 'package:clinic_management_app/features/master/data/models/request/add_doctor_request_model.dart';
import 'package:clinic_management_app/features/master/presentation/bloc/data_doctor/data_doctor_bloc.dart';
import 'package:clinic_management_app/features/master/presentation/widgets/build_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../core/components/button_loading.dart';
import '../../../../core/constants/variables.dart';
import '../../data/models/response/master_doctor_response_model.dart';
import '../bloc/add_and_edit_doctor/add_and_edit_doctor_bloc.dart';
import '../widgets/card_shimmer_loading.dart';

class DataDoctorScreen extends StatefulWidget {
  const DataDoctorScreen({super.key});

  @override
  State<DataDoctorScreen> createState() => _DataDoctorScreenState();
}

class _DataDoctorScreenState extends State<DataDoctorScreen> {
  final searchController = TextEditingController();
  MasterDoctor? selectedDoctor;
  late final TextEditingController doctorNameController;
  late final TextEditingController doctorEmailController;
  late final TextEditingController doctorPhoneController;
  late final TextEditingController doctorNikController;
  late final TextEditingController doctorSpecialistController;
  late final TextEditingController sipController;
  late final TextEditingController idIhsController;
  late final TextEditingController addressController;
  late final TextEditingController polyclinicController;
  late DateTime? scheduleTime;
  late DateTime? birthDate;

  final ImagePicker _picker = ImagePicker();
  File? _image;

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

    final String formattedDate = formatter.format(date);

    return formattedDate;
  }

  @override
  void initState() {
    doctorNameController = TextEditingController();
    doctorEmailController = TextEditingController();
    doctorPhoneController = TextEditingController();
    doctorNikController = TextEditingController();
    doctorSpecialistController = TextEditingController();
    sipController = TextEditingController();
    idIhsController = TextEditingController();
    addressController = TextEditingController();
    polyclinicController = TextEditingController();
    scheduleTime = DateTime.now();
    birthDate = DateTime.now();
    context.read<DataDoctorBloc>().add(const DataDoctorEvent.getDoctors());
    super.initState();
  }

  // Future<void> _pickImage(ImageSource source) async {
  //   try {
  //     final pickedFile = await _picker.pickImage(source: source);

  //     if (pickedFile != null) {
  //       setState(() {
  //         _image = File(pickedFile.path);
  //       });
  //     }
  //   } catch (e) {
  //     debugPrint('Error picking image: $e');
  //   }
  // }

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
          trailing: ButtonGradient.filled(
              width: context.deviceWidth * 0.15,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.white,
                    content: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            child: SizedBox(
                              width: context.deviceWidth / 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Text(
                                        'Tambah Dokter',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.0,
                                          color: AppColors.darkGrey,
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                  const SpaceHeight(20.0),
                                  const Text(
                                    'Nama Dokter',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0,
                                      color: AppColors.darkGrey,
                                    ),
                                  ),
                                  const SpaceHeight(8.0),
                                  CustomTextField(
                                    controller: doctorNameController,
                                    label: 'Masukkan Nama Dokter',
                                    showLabel: false,
                                  ),
                                  const SpaceHeight(20.0),
                                  const Text(
                                    'Email',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0,
                                      color: AppColors.darkGrey,
                                    ),
                                  ),
                                  const SpaceHeight(8.0),
                                  CustomTextField(
                                    controller: doctorEmailController,
                                    label: 'example@gmail.com',
                                    showLabel: false,
                                  ),
                                  const SpaceHeight(20.0),
                                  const Text(
                                    'Nomor Telepon',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0,
                                      color: AppColors.darkGrey,
                                    ),
                                  ),
                                  const SpaceHeight(8.0),
                                  CustomTextField(
                                    controller: doctorPhoneController,
                                    label: 'Masukkan Nomor Telepon Dokter',
                                    showLabel: false,
                                  ),
                                  const SpaceHeight(20.0),
                                  const Text(
                                    'NIK',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0,
                                      color: AppColors.darkGrey,
                                    ),
                                  ),
                                  const SpaceHeight(8.0),
                                  CustomTextField(
                                    controller: doctorNikController,
                                    label: 'Masukkan NIK Dokter',
                                    showLabel: false,
                                  ),
                                  const SpaceHeight(20.0),
                                  const Text(
                                    'Spesialis',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0,
                                      color: AppColors.darkGrey,
                                    ),
                                  ),
                                  const SpaceHeight(8.0),
                                  CustomTextField(
                                    controller: doctorSpecialistController,
                                    label: 'Masukkan Spesialis Dokter',
                                    showLabel: false,
                                  ),
                                  const SpaceHeight(20.0),
                                  const Text(
                                    'Poliklinik',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0,
                                      color: AppColors.darkGrey,
                                    ),
                                  ),
                                  const SpaceHeight(8.0),
                                  CustomTextField(
                                    controller: polyclinicController,
                                    label: 'Masukkan Poliklinik Dokter',
                                    showLabel: false,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SpaceWidth(50.0),
                          SingleChildScrollView(
                            child: SizedBox(
                              width: context.deviceWidth / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Foto Dokter',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0,
                                      color: AppColors.darkGrey,
                                    ),
                                  ),
                                  const SpaceHeight(8.0),
                                  Container(
                                      height: 71,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.darkGrey,
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6, right: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: AppColors.grey),
                                              child: _image == null
                                                  ? const Icon(Icons
                                                      .no_photography_outlined)
                                                  : Image.file(
                                                      _image!,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                            ElevatedButton(
                                                onPressed: () async {
                                                  final pickedFile =
                                                      await _picker.pickImage(
                                                          source: ImageSource
                                                              .gallery);
                                                  if (pickedFile != null) {
                                                    setState(() {
                                                      _image =
                                                          File(pickedFile.path);
                                                    });
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AppColors.primary,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Upload Gambar',
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ))
                                          ],
                                        ),
                                      )),
                                  const SpaceHeight(20.0),
                                  const Text(
                                    'SIP',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0,
                                      color: AppColors.darkGrey,
                                    ),
                                  ),
                                  const SpaceHeight(8.0),
                                  CustomTextField(
                                    controller: sipController,
                                    label: 'Masukkan SIP Dokter',
                                    showLabel: false,
                                  ),
                                  const SpaceHeight(20.0),
                                  const Text(
                                    'ID IHS',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0,
                                      color: AppColors.darkGrey,
                                    ),
                                  ),
                                  const SpaceHeight(8.0),
                                  CustomTextField(
                                    controller: idIhsController,
                                    label: 'Masukkan ID IHS Dokter',
                                    showLabel: false,
                                  ),
                                  const SpaceHeight(20.0),
                                  const Text(
                                    'Alamat',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0,
                                      color: AppColors.darkGrey,
                                    ),
                                  ),
                                  const SpaceHeight(8.0),
                                  CustomTextField(
                                    controller: addressController,
                                    label: 'Masukkan Alamat Dokter',
                                    showLabel: false,
                                    isDescription: true,
                                  ),
                                  const SpaceHeight(20.0),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Button.outlined(
                                          onPressed: () => context.pop(),
                                          label: 'Cancel',
                                        ),
                                      ),
                                      const SpaceWidth(10.0),
                                      Flexible(
                                          child: BlocConsumer<
                                              AddAndEditDoctorBloc,
                                              AddAndEditDoctorState>(
                                        listener: (context, state) {
                                          state.maybeWhen(
                                            success: () {
                                              context.pop();
                                              context
                                                  .read<DataDoctorBloc>()
                                                  .add(const DataDoctorEvent
                                                      .getDoctors());
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content:
                                                      Text('Doctor created!'),
                                                  backgroundColor:
                                                      AppColors.green,
                                                ),
                                              );
                                            },
                                            error: (message) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(message),
                                                  backgroundColor:
                                                      AppColors.red,
                                                ),
                                              );
                                            },
                                            orElse: () {},
                                          );
                                        },
                                        builder: (context, state) {
                                          return state.maybeWhen(
                                            orElse: () {
                                              return Button.filled(
                                                onPressed: () {
                                                  final requestData =
                                                      AddDoctorRequestModel(
                                                    doctorName:
                                                        doctorNameController
                                                            .text,
                                                    doctorEmail:
                                                        doctorEmailController
                                                            .text,
                                                    doctorPhone:
                                                        doctorPhoneController
                                                            .text,
                                                    doctorSpecialist:
                                                        doctorSpecialistController
                                                            .text,
                                                    sip: sipController.text,
                                                    idIhs: idIhsController.text,
                                                    address:
                                                        addressController.text,
                                                    photo: _image!,
                                                    polyclinic:
                                                        polyclinicController
                                                            .text,
                                                    nik: doctorNikController
                                                        .text,
                                                  );
                                                  context
                                                      .read<
                                                          AddAndEditDoctorBloc>()
                                                      .add(AddAndEditDoctorEvent
                                                          .addDoctor(
                                                              doctor:
                                                                  requestData));
                                                },
                                                label: 'Create',
                                              );
                                            },
                                            loading: () {
                                              return const ButtonLoading();
                                            },
                                          );
                                        },
                                      )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              label: 'Tambah Dokter'),
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
                                      child: CircleAvatar(
                                        radius: 60,
                                        backgroundImage: Image.network(
                                          '${Variables.imageBaseUrl}/${doctor.photo?.replaceAll('public/', '')}',
                                          fit: BoxFit.cover,
                                        ).image,
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
                                          doctor.doctorName ?? '',
                                          style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SpaceHeight(4.0),
                                        Text(
                                          doctor.doctorPhone ?? '',
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
