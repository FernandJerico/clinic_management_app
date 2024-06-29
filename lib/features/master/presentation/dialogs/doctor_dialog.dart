import 'dart:io';

import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/features/master/data/models/response/master_doctor_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/components/button_loading.dart';
import '../../../../core/components/buttons.dart';
import '../../../../core/components/custom_text_field.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/themes/colors.dart';
import '../../data/models/request/add_doctor_request_model.dart';
import '../../data/models/request/edit_doctor_request_model.dart';
import '../bloc/add_and_edit_doctor/add_and_edit_doctor_bloc.dart';
import '../bloc/data_doctor/data_doctor_bloc.dart';
import '../bloc/image_picker/image_picker_bloc.dart';

class DoctorDialog extends StatefulWidget {
  final String type;
  final MasterDoctor? doctor;
  const DoctorDialog({super.key, required this.type, this.doctor});

  @override
  State<DoctorDialog> createState() => _DoctorDialogState();
}

class _DoctorDialogState extends State<DoctorDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController doctorNameController;
  late final TextEditingController doctorEmailController;
  late final TextEditingController doctorPhoneController;
  late final TextEditingController doctorNikController;
  late final TextEditingController doctorSpecialistController;
  late final TextEditingController sipController;
  late final TextEditingController idIhsController;
  late final TextEditingController addressController;
  late final TextEditingController polyclinicController;

  String? _hintText = 'Pick an image';
  File? _image;

  @override
  void initState() {
    doctorNameController =
        TextEditingController(text: widget.doctor?.doctorName);
    doctorEmailController =
        TextEditingController(text: widget.doctor?.doctorEmail);
    doctorPhoneController =
        TextEditingController(text: widget.doctor?.doctorPhone);
    doctorNikController = TextEditingController(text: widget.doctor?.nik);
    doctorSpecialistController =
        TextEditingController(text: widget.doctor?.doctorSpecialist);
    sipController = TextEditingController(text: widget.doctor?.sip);
    idIhsController = TextEditingController(text: widget.doctor?.idIhs);
    addressController = TextEditingController(text: widget.doctor?.address);
    polyclinicController =
        TextEditingController(text: widget.doctor?.polyclinic);
    super.initState();
  }

  @override
  void dispose() {
    doctorNameController.dispose();
    doctorEmailController.dispose();
    doctorPhoneController.dispose();
    doctorNikController.dispose();
    doctorSpecialistController.dispose();
    sipController.dispose();
    idIhsController.dispose();
    addressController.dispose();
    polyclinicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Form(
          key: _formKey,
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
                      Row(
                        children: [
                          Text(
                            '${widget.type == 'add' ? 'Tambah' : 'Edit'} Dokter',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                              color: AppColors.darkGrey,
                            ),
                          ),
                          const Spacer(),
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
                        keyboardType: TextInputType.emailAddress,
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
                        keyboardType: TextInputType.number,
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
                        keyboardType: TextInputType.number,
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
                      BlocBuilder<ImagePickerBloc, ImagePickerState>(
                        builder: (context, state) {
                          state.maybeWhen(
                            picked: (image) {
                              _hintText = image.path.split('/').last;
                              _image = image;
                            },
                            initial: () {
                              _hintText = 'Pick an image';
                            },
                            orElse: () {},
                          );

                          return TextFormField(
                            onTap: () {
                              context
                                  .read<ImagePickerBloc>()
                                  .add(const ImagePickerEvent.pickImage());
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: AppColors.darkGrey,
                                ),
                              ),
                              hintText: _hintText,
                              suffixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(left: 6, right: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: AppColors.grey,
                                        ),
                                        child: _image == null
                                            ? const Icon(
                                                Icons.no_photography_outlined)
                                            : Image.file(
                                                _image!,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        context.read<ImagePickerBloc>().add(
                                            const ImagePickerEvent.pickImage());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                      child: Text(
                                        'Upload Gambar',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (_hintText == 'Pick an image' ||
                                  _hintText!.isEmpty) {
                                return 'Please pick an image';
                              }
                              return null;
                            },
                          );
                        },
                      ),
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
                              onPressed: () {
                                context.pop();
                                context.read<ImagePickerBloc>().add(
                                      const ImagePickerEvent.clearImage(),
                                    );
                              },
                              label: 'Cancel',
                            ),
                          ),
                          const SpaceWidth(10.0),
                          Flexible(
                              child: BlocConsumer<AddAndEditDoctorBloc,
                                      AddAndEditDoctorState>(
                                  listener: (context, state) {
                            state.maybeWhen(
                              success: () {
                                context.pop();
                                context
                                    .read<DataDoctorBloc>()
                                    .add(const DataDoctorEvent.getDoctors());
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Doctor created!'),
                                    backgroundColor: AppColors.green,
                                  ),
                                );
                              },
                              error: (message) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(message),
                                    backgroundColor: AppColors.red,
                                  ),
                                );
                              },
                              orElse: () {},
                            );
                          }, builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () {
                                return Button.filled(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (widget.type == 'add') {
                                        final requestData =
                                            AddDoctorRequestModel(
                                          doctorName: doctorNameController.text,
                                          doctorEmail:
                                              doctorEmailController.text,
                                          doctorPhone:
                                              doctorPhoneController.text,
                                          doctorSpecialist:
                                              doctorSpecialistController.text,
                                          sip: sipController.text,
                                          idIhs: idIhsController.text,
                                          address: addressController.text,
                                          photo: _image!,
                                          polyclinic: polyclinicController.text,
                                          nik: doctorNikController.text,
                                        );
                                        context
                                            .read<AddAndEditDoctorBloc>()
                                            .add(
                                                AddAndEditDoctorEvent.addDoctor(
                                                    doctor: requestData));
                                      } else if (widget.type == 'edit') {
                                        if (_image == null) {
                                          // Edit without changing photo
                                          context
                                              .read<AddAndEditDoctorBloc>()
                                              .add(
                                                AddAndEditDoctorEvent
                                                    .editDoctor(
                                                  doctorId: widget.doctor!.id
                                                      .toString(),
                                                  doctor:
                                                      EditDoctorRequestModel(
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
                                                    polyclinic:
                                                        polyclinicController
                                                            .text,
                                                    nik: doctorNikController
                                                        .text,
                                                  ),
                                                ),
                                              );
                                        } else {
                                          // Edit with changing photo
                                          context
                                              .read<AddAndEditDoctorBloc>()
                                              .add(
                                                AddAndEditDoctorEvent
                                                    .editDoctor(
                                                  doctorId: widget.doctor!.id
                                                      .toString(),
                                                  doctor:
                                                      EditDoctorRequestModel(
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
                                                  ),
                                                ),
                                              );
                                        }
                                      }
                                    }
                                  },
                                  label:
                                      widget.type == 'add' ? 'Create' : 'Edit',
                                );
                              },
                              loading: () {
                                return const ButtonLoading();
                              },
                            );
                          })),
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
  }
}
