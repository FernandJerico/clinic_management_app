// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:clinic_management_app/features/master/data/models/request/add_reservation_request_model.dart';
import 'package:clinic_management_app/features/master/presentation/dialogs/success_reservation_dialog.dart';
import 'package:clinic_management_app/features/patient-schedule/presentation/bloc/patient_schedule/patient_schedule_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:clinic_management_app/core/extensions/build_context_ext.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/button_loading.dart';
import '../../../../core/components/buttons.dart';
import '../../../../core/components/custom_date_picker.dart';
import '../../../../core/components/custom_text_field.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/themes/colors.dart';
import '../../data/models/response/master_doctor_response_model.dart';
import '../../data/models/response/master_patient_response_model.dart';
import '../bloc/add_reservation/add_reservation_bloc.dart';
import '../bloc/data_doctor/data_doctor_bloc.dart';
import '../widgets/doctor_dropdown.dart';

class CreateReservationPatientDialog extends StatefulWidget {
  final MasterPatient? patient;
  const CreateReservationPatientDialog({
    Key? key,
    this.patient,
  }) : super(key: key);

  @override
  State<CreateReservationPatientDialog> createState() =>
      _CreateReservationPatientDialogState();
}

class _CreateReservationPatientDialogState
    extends State<CreateReservationPatientDialog> {
  final _formKey = GlobalKey<FormState>();
  MasterDoctor? selectedDoctor;

  late final TextEditingController patientNameController;
  late final TextEditingController nikController;
  late final TextEditingController complaintController;
  late final TextEditingController birthDateController;
  late DateTime? scheduleTime;
  late DateTime? birthDate;

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

    final String formattedDate = formatter.format(date);

    return formattedDate;
  }

  @override
  void initState() {
    patientNameController = TextEditingController(text: widget.patient?.name);
    nikController = TextEditingController(text: widget.patient?.nik);
    complaintController = TextEditingController();
    scheduleTime = DateTime.now();
    birthDate = widget.patient?.birthDate;
    birthDateController = TextEditingController();

    context.read<DataDoctorBloc>().add(const DataDoctorEvent.getDoctors());
    super.initState();
  }

  @override
  void dispose() {
    patientNameController.dispose();
    birthDateController.dispose();
    nikController.dispose();
    complaintController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final queueNumber = context.watch<PatientScheduleBloc>().state.whenOrNull(
          loaded: (patientSchedules) =>
              patientSchedules
                  .where((element) =>
                      DateFormat('yyyy-MM-dd').format(element.scheduleTime!) ==
                      DateFormat('yyyy-MM-dd').format(DateTime.now()))
                  .length +
              1,
        );
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
                      const Row(
                        children: [
                          Text(
                            'Detail Pasien',
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
                        'Nama Pasien',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: AppColors.darkGrey,
                        ),
                      ),
                      const SpaceHeight(8.0),
                      CustomTextField(
                        controller: patientNameController,
                        label: 'Nama Pasien',
                        showLabel: false,
                      ),
                      const SpaceHeight(20.0),
                      const Text(
                        'Tanggal Lahir',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: AppColors.darkGrey,
                        ),
                      ),
                      const SpaceHeight(8.0),
                      CustomDatePicker(
                        initialDate: birthDate,
                        label: 'Tanggal Lahir',
                        showLabel: false,
                        isDisabled: true,
                        onDateSelected: (selectedDate) =>
                            birthDate = selectedDate,
                      ),
                      const SpaceHeight(20.0),
                      const Text(
                        'Tanggal Pemeriksaan',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: AppColors.darkGrey,
                        ),
                      ),
                      const SpaceHeight(8.0),
                      CustomDatePicker(
                        initialDate: scheduleTime,
                        label: 'Schedule',
                        showLabel: false,
                        onDateSelected: (selectedDate) =>
                            scheduleTime = selectedDate,
                      ),
                      const SpaceHeight(20.0),
                      const Text(
                        'Keluhan',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: AppColors.darkGrey,
                        ),
                      ),
                      const SpaceHeight(8.0),
                      CustomTextField(
                        controller: complaintController,
                        label: 'Keluhan',
                        showLabel: false,
                        isDescription: true,
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
                        'Pilih Dokter',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: AppColors.darkGrey,
                        ),
                      ),
                      const SpaceHeight(24.0),
                      BlocBuilder<DataDoctorBloc, DataDoctorState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () {
                              return DoctorDropdown(
                                value: selectedDoctor,
                                items: const [],
                                label: 'Pilih Dokter',
                                onChanged: (value) {},
                              );
                            },
                            loaded: (doctors) {
                              return DoctorDropdown(
                                value: selectedDoctor,
                                items: doctors,
                                label: 'Pilih Dokter',
                                onChanged: (value) {
                                  setState(() {
                                    selectedDoctor = value;
                                  });
                                },
                              );
                            },
                          );
                        },
                      ),
                      const SpaceHeight(20.0),
                      SizedBox(
                        height: 350.0,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Assets.images.doctorPlaceholder
                                  .image(width: 140.0),
                              const SpaceHeight(20.0),
                              const Text(
                                'Add Doctor to Patient',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.0,
                                ),
                              ),
                              const SpaceHeight(10.0),
                              const Text(
                                'Search and add doctor to this patient.',
                                style: TextStyle(color: AppColors.darkGrey),
                              ),
                            ],
                          ),
                        ),
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
                              child: BlocConsumer<AddReservationBloc,
                                  AddReservationState>(
                            listener: (context, state) {
                              state.maybeWhen(
                                success: () {
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        SuccessReservationDialog(
                                      queueNumber: queueNumber ?? 1,
                                      patientName: widget.patient?.name,
                                      doctorName: selectedDoctor?.doctorName,
                                      jam: DateFormat('HH:mm')
                                          .format(scheduleTime!),
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
                            },
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () {
                                  return Button.filled(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        final requestData =
                                            AddReservationRequestModel(
                                          patientId: widget.patient?.id,
                                          doctorId: selectedDoctor?.id,
                                          scheduleTime: scheduleTime!,
                                          complaint: complaintController.text,
                                          status: 'waiting',
                                          totalPrice: 0,
                                          queueNumber: queueNumber ?? 1,
                                        );
                                        debugPrint(
                                            requestData.toJson().toString());
                                        context.read<AddReservationBloc>().add(
                                            AddReservationEvent.addReservation(
                                                data: requestData));
                                      }
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
  }
}
