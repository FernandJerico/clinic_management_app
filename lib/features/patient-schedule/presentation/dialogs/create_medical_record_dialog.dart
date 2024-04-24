import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/core/extensions/int_ext.dart';
import 'package:clinic_management_app/features/master/data/models/response/service_medicine_response_model.dart';
import 'package:clinic_management_app/features/master/presentation/bloc/data_service_medicine/data_service_medicine_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/buttons.dart';
import '../../../../core/components/custom_date_picker.dart';
import '../../../../core/components/custom_dropdown.dart';
import '../../../../core/components/custom_text_field.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/themes/colors.dart';
import '../../../master/data/models/response/master_doctor_response_model.dart';
import '../../../master/data/models/response/master_patient_response_model.dart';
import '../../../master/presentation/widgets/medicine_card.dart';
import '../../../master/presentation/widgets/medicine_dropdown.dart';

class CreateMedicalRecordDialog extends StatefulWidget {
  final MasterDoctor doctor;
  final MasterPatient patient;
  final int patientScheduleId;
  final DateTime scheduleTime;
  final String complaint;
  const CreateMedicalRecordDialog({
    super.key,
    required this.doctor,
    required this.patient,
    required this.patientScheduleId,
    required this.scheduleTime,
    required this.complaint,
  });

  @override
  State<CreateMedicalRecordDialog> createState() =>
      _CreateMedicalRecordDialogState();
}

class _CreateMedicalRecordDialogState extends State<CreateMedicalRecordDialog> {
  final statuses = ['Dewasa', 'Anak - anak'];
  List<ServiceMedicine> medicineSelected = [];

  ServiceMedicine? selectedService;

  late final ValueNotifier<String?> statusNotifier;
  late final TextEditingController patientNameController;
  late final TextEditingController doctorNameController;
  late final TextEditingController nikController;
  late final TextEditingController complaintController;
  late final TextEditingController diagnosisController;
  late final TextEditingController medicalTreatmentController;
  late final TextEditingController doctorNoteController;
  late DateTime? handlingTime;
  int totalPrice = 0;

  late final List<ValueNotifier<int>> quantityNotifier;

  @override
  void initState() {
    statusNotifier = ValueNotifier(statuses.first);
    patientNameController = TextEditingController(text: widget.patient.name);
    doctorNameController =
        TextEditingController(text: widget.doctor.doctorName);
    nikController = TextEditingController(text: widget.patient.nik);
    complaintController = TextEditingController(text: widget.complaint);

    diagnosisController = TextEditingController(text: '');
    medicalTreatmentController = TextEditingController(text: '');
    doctorNoteController = TextEditingController(text: '');
    handlingTime = widget.scheduleTime;

    quantityNotifier = [];

    context
        .read<DataServiceMedicineBloc>()
        .add(const DataServiceMedicineEvent.getServiceMedicines());
    super.initState();
  }

  @override
  void dispose() {
    patientNameController.dispose();
    doctorNameController.dispose();
    statusNotifier.dispose();
    nikController.dispose();
    diagnosisController.dispose();
    medicalTreatmentController.dispose();
    doctorNoteController.dispose();
    super.dispose();
  }

  void calculateTotalPrice() {
    int total = 0;
    for (var i = 0; i < medicineSelected.length; i++) {
      final item = medicineSelected[i];
      final quantity = quantityNotifier[i].value;
      total += item.price! * quantity;
    }
    setState(() {
      totalPrice = total;
    });
  }

  void updateQuantity(int index, int value) {
    quantityNotifier[index].value = value;
    calculateTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
                    const Text(
                      'Detail Pasien',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        color: AppColors.darkGrey,
                      ),
                    ),
                    const SpaceHeight(24.0),
                    CustomTextField(
                      controller: nikController,
                      label: 'NIK',
                      showLabel: false,
                    ),
                    const SpaceHeight(24.0),
                    CustomTextField(
                      controller: patientNameController,
                      label: 'Nama Pasien',
                      showLabel: false,
                    ),
                    const SpaceHeight(24.0),
                    ValueListenableBuilder(
                      valueListenable: statusNotifier,
                      builder: (context, value, _) => CustomDropdown(
                        value: value,
                        items: statuses,
                        label: 'Status',
                        onChanged: (value) => statusNotifier.value = value!,
                        showLabel: false,
                      ),
                    ),
                    const SpaceHeight(24.0),
                    CustomDatePicker(
                      initialDate: handlingTime,
                      label: 'Waktu Penanganan',
                      showLabel: false,
                      onDateSelected: (selectedDate) =>
                          handlingTime = selectedDate,
                    ),
                    const SpaceHeight(24.0),
                    CustomTextField(
                      controller: doctorNameController,
                      label: 'Dokter Pemeriksa',
                      showLabel: false,
                    ),
                    const SpaceHeight(24.0),
                    CustomTextField(
                      controller: complaintController,
                      label: 'Keluhan',
                      showLabel: false,
                      isDescription: true,
                    ),
                    const SpaceHeight(24.0),
                    CustomTextField(
                      controller: diagnosisController,
                      label: 'Diagnosa',
                      showLabel: false,
                      isDescription: true,
                    ),
                    const SpaceHeight(24.0),
                    CustomTextField(
                      controller: medicalTreatmentController,
                      label: 'Tindakan Medis',
                      showLabel: false,
                      isDescription: true,
                    ),
                    const SpaceHeight(24.0),
                    CustomTextField(
                      controller: doctorNoteController,
                      label: 'Catatan Dokter',
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
                    'Item',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                      color: AppColors.darkGrey,
                    ),
                  ),
                  const SpaceHeight(20.0),
                  MedicineDropdown(
                    value: null,
                    items: const [],
                    label: 'Pilih Item',
                    onChanged: (value) {
                      medicineSelected.add(value!);
                      setState(() {});
                    },
                  ),
                  const SpaceHeight(20.0),
                  SizedBox(
                    height: 405.0,
                    child: medicineSelected.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Assets.images.medicine.image(width: 140.0),
                                const SpaceHeight(40.0),
                                const Text(
                                  'Add items',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.0,
                                  ),
                                ),
                                const SpaceHeight(20.0),
                                const Text(
                                  'add medications or disposable equipment',
                                  style: TextStyle(color: AppColors.darkGrey),
                                ),
                              ],
                            ),
                          )
                        : SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...medicineSelected
                                      .map((item) => MedicineCard(
                                            item: item,
                                            onRemoveTap: () => setState(() =>
                                                medicineSelected.remove(item)),
                                          )),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Total'),
                                      Text(
                                        50000.currencyFormatRp,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ]),
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
                          child: Button.filled(
                        onPressed: () {},
                        label: 'Create RM',
                      ))
                    ],
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
