import 'dart:io';

import 'package:clinic_management_app/core/assets/assets.gen.dart';
import 'package:clinic_management_app/core/components/button_gradient.dart';
import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/features/master/presentation/bloc/complete_reservation/complete_reservation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../../core/components/buttons.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/constants/variables.dart';
import '../../../../core/themes/colors.dart';
import '../bloc/accept_reservation/accept_reservation_bloc.dart';
import '../bloc/data_reservation/data_reservation_bloc.dart';
import '../bloc/image_picker/image_picker_bloc.dart';
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
  final imageController = TextEditingController();

  String? _hintText = 'Pick an image';
  File? pickedImage;

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
                                  decoration: BoxDecoration(
                                    color: history.status == 'pending'
                                        ? AppColors.orderIsWaiting
                                        : history.status == 'approved'
                                            ? AppColors.orderIsCompleted
                                            : history.status == 'completed'
                                                ? Colors.blue
                                                : AppColors.orderIsRejected,
                                    borderRadius: const BorderRadius.only(
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
                                                      : history.status ==
                                                              'completed'
                                                          ? Colors.blue
                                                              .withOpacity(0.25)
                                                          : AppColors
                                                              .orderIsRejected
                                                              .withOpacity(
                                                                  0.25),
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
                                                        : history.status ==
                                                                'completed'
                                                            ? Colors.blue
                                                            : AppColors
                                                                .orderIsRejected,
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Status: ${history.status == 'pending' ? 'Menunggu Persetujuan' : history.status == 'approved' ? 'Reservasi Disetujui' : history.status == 'completed' ? 'Reservasi Selesai' : 'Reservasi Ditolak'}',
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
                                                        : history.status ==
                                                                'completed'
                                                            ? Colors.blue
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
                                                if (history.status ==
                                                    'approved')
                                                  PopupMenuItem(
                                                    height: 36,
                                                    child: Text(
                                                      'Selesaikan Reservasi',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    onTap: () {
                                                      showDialog(
                                                        barrierDismissible:
                                                            false,
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
                                                                    0.5,
                                                                height: context
                                                                        .deviceHeight *
                                                                    0.9,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        16.0),
                                                                child: Column(
                                                                  children: [
                                                                    Text(
                                                                      'Selesaikan Reservasi',
                                                                      style: GoogleFonts.poppins(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              AppColors.primary),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            20),
                                                                    BlocProvider(
                                                                      create: (context) =>
                                                                          ImagePickerBloc(),
                                                                      child: Form(
                                                                          key: _formKey,
                                                                          child: Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                'Upload Bukti Pembayaran Reservasi',
                                                                                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.darkGrey),
                                                                              ),
                                                                              const SizedBox(height: 8),
                                                                              BlocBuilder<ImagePickerBloc, ImagePickerState>(
                                                                                builder: (context, state) {
                                                                                  state.maybeWhen(
                                                                                    picked: (image) {
                                                                                      _hintText = image.path.split('/').last;
                                                                                    },
                                                                                    initial: () {
                                                                                      _hintText = 'Pick an image';
                                                                                    },
                                                                                    orElse: () {},
                                                                                  );
                                                                                  return TextFormField(
                                                                                    onTap: () {
                                                                                      context.read<ImagePickerBloc>().add(const ImagePickerEvent.pickImage());
                                                                                    },
                                                                                    readOnly: true,
                                                                                    decoration: InputDecoration(
                                                                                      prefixIcon: const Icon(
                                                                                        Icons.image,
                                                                                        color: Colors.blue,
                                                                                      ),
                                                                                      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                                                                      hintText: _hintText,
                                                                                      border: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(4),
                                                                                      ),
                                                                                    ),
                                                                                    validator: (value) {
                                                                                      if (_hintText == 'Pick an image' || _hintText!.isEmpty) {
                                                                                        return 'Please pick an image';
                                                                                      }
                                                                                      return null;
                                                                                    },
                                                                                  );
                                                                                },
                                                                              ),
                                                                              const SizedBox(height: 16),
                                                                              BlocBuilder<ImagePickerBloc, ImagePickerState>(
                                                                                builder: (context, state) {
                                                                                  return state.maybeWhen(
                                                                                    orElse: () => Container(
                                                                                      height: MediaQuery.of(context).size.height * 0.55,
                                                                                      width: MediaQuery.of(context).size.width * 0.25,
                                                                                      decoration: const BoxDecoration(color: Colors.grey),
                                                                                      child: Center(
                                                                                        child: Text(
                                                                                          'No image selected',
                                                                                          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    picked: (image) {
                                                                                      pickedImage = image;
                                                                                      return Container(
                                                                                        height: MediaQuery.of(context).size.height * 0.55,
                                                                                        width: MediaQuery.of(context).size.width * 0.25,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Colors.blue,
                                                                                          image: DecorationImage(
                                                                                            image: FileImage(image),
                                                                                            fit: BoxFit.cover,
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    error: (message) => Text(message),
                                                                                  );
                                                                                },
                                                                              ),
                                                                              const SizedBox(height: 16),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                children: [
                                                                                  ButtonGradient.filled(
                                                                                      width: 200,
                                                                                      onPressed: () {
                                                                                        context.read<ImagePickerBloc>().add(const ImagePickerEvent.clearImage());
                                                                                        context.pop();
                                                                                      },
                                                                                      label: 'Close'),
                                                                                  BlocConsumer<CompleteReservationBloc, CompleteReservationState>(
                                                                                    listener: (context, state) {
                                                                                      state.maybeWhen(
                                                                                        orElse: () {},
                                                                                        success: () {
                                                                                          context.pop();
                                                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                                                            const SnackBar(
                                                                                              backgroundColor: AppColors.green,
                                                                                              content: Text('Reservation completed successfully'),
                                                                                            ),
                                                                                          );
                                                                                          context.read<DataReservationBloc>().add(const DataReservationEvent.getReservationData());
                                                                                        },
                                                                                        error: (message) {
                                                                                          debugPrint(message);
                                                                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                            content: Text(message),
                                                                                            backgroundColor: AppColors.red,
                                                                                          ));
                                                                                        },
                                                                                      );
                                                                                    },
                                                                                    builder: (context, state) {
                                                                                      return state.maybeWhen(
                                                                                        orElse: () {
                                                                                          return ButtonGradient.filled(
                                                                                              width: 200,
                                                                                              onPressed: () {
                                                                                                if (_formKey.currentState!.validate()) {
                                                                                                  debugPrint('reservationId : ${history.id.toString()}');
                                                                                                  context.read<CompleteReservationBloc>().add(CompleteReservationEvent.completeReservation(reservationId: history.id.toString(), status: 'completed', historyImage: pickedImage!));
                                                                                                }
                                                                                              },
                                                                                              label: 'Selesaikan');
                                                                                        },
                                                                                        loading: () => ButtonGradient.loading(
                                                                                          width: 200,
                                                                                          onPressed: () {},
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            ],
                                                                          )),
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
                                                                  0.85,
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
                                                                      Column(
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                context.deviceHeight * 0.34,
                                                                            width:
                                                                                context.deviceWidth * 0.38,
                                                                            decoration:
                                                                                BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), boxShadow: [
                                                                              BoxShadow(
                                                                                color: AppColors.black.withOpacity(0.25),
                                                                                spreadRadius: 0,
                                                                                blurRadius: 2,
                                                                                offset: const Offset(0, 1),
                                                                              ),
                                                                            ]),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                                                          const SizedBox(
                                                                              height: 20),
                                                                          Container(
                                                                            height:
                                                                                context.deviceHeight * 0.34,
                                                                            width:
                                                                                context.deviceWidth * 0.38,
                                                                            decoration:
                                                                                BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), boxShadow: [
                                                                              BoxShadow(
                                                                                color: AppColors.black.withOpacity(0.25),
                                                                                spreadRadius: 0,
                                                                                blurRadius: 2,
                                                                                offset: const Offset(0, 1),
                                                                              ),
                                                                            ]),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                                                                                  : history.status == 'completed'
                                                                                                      ? Colors.blue.withOpacity(0.25)
                                                                                                      : AppColors.orderIsRejected.withOpacity(0.25),
                                                                                          borderRadius: BorderRadius.circular(4),
                                                                                          border: Border.all(
                                                                                            color: history.status == 'pending'
                                                                                                ? AppColors.orderIsWaiting
                                                                                                : history.status == 'approved'
                                                                                                    ? AppColors.orderIsCompleted
                                                                                                    : history.status == 'completed'
                                                                                                        ? Colors.blue
                                                                                                        : AppColors.orderIsRejected,
                                                                                          ),
                                                                                        ),
                                                                                        alignment: Alignment.center,
                                                                                        child: Text(
                                                                                          'Status: ${history.status == 'pending' ? 'Menunggu Persetujuan' : history.status == 'approved' ? 'Reservasi Disetujui' : history.status == 'completed' ? 'Reservasi Selesai' : 'Reservasi Ditolak'}',
                                                                                          textAlign: TextAlign.center,
                                                                                          style: GoogleFonts.poppins(
                                                                                            fontSize: 14,
                                                                                            color: history.status == 'pending'
                                                                                                ? AppColors.orderIsWaiting
                                                                                                : history.status == 'approved'
                                                                                                    ? AppColors.orderIsCompleted
                                                                                                    : history.status == 'completed'
                                                                                                        ? Colors.blue
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
                                                                      Container(
                                                                        height: context.deviceHeight *
                                                                            0.705,
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
                                                                                'Bukti Pembayaran Reservasi',
                                                                                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
                                                                              ),
                                                                              const Divider(),
                                                                              const SizedBox(height: 8),
                                                                              Center(
                                                                                child: history.historyImage == null
                                                                                    ? Container(
                                                                                        height: context.deviceHeight * 0.6,
                                                                                        width: context.deviceWidth * 0.3,
                                                                                        color: Colors.grey,
                                                                                        child: Center(
                                                                                          child: Text(
                                                                                            'Belum ada bukti pembayaran',
                                                                                            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    : Container(
                                                                                        height: context.deviceHeight * 0.6,
                                                                                        width: context.deviceWidth * 0.3,
                                                                                        color: Colors.grey,
                                                                                        child: Image.network(
                                                                                          '${Variables.imageBaseUrl}/reservation-history-image/${history.historyImage}',
                                                                                          fit: BoxFit.cover,
                                                                                        ),
                                                                                      ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
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
                                                                                                      error: (message) {
                                                                                                        debugPrint(message);
                                                                                                        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                                          content: Text(message),
                                                                                                          backgroundColor: AppColors.red,
                                                                                                        ));
                                                                                                      });
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
