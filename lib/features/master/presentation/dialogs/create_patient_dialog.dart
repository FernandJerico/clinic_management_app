import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../../../core/components/buttons.dart';
import '../../../../core/components/custom_date_picker.dart';
import '../../../../core/components/custom_dropdown.dart';
import '../../../../core/components/custom_text_field.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/themes/colors.dart';


class CreatePatientDialog extends StatefulWidget {
  const CreatePatientDialog({
    super.key,
  });

  @override
  State<CreatePatientDialog> createState() => _CreatePatientDialogState();
}

class _CreatePatientDialogState extends State<CreatePatientDialog> {
  final genders = ['Laki-laki', 'Perempuan'];
  final cities = ['City 1', 'City 2', 'City 3']; // Contoh data kota/kabupaten
  final provinces = [
    'Province 1',
    'Province 2',
    'Province 3'
  ]; // Contoh data provinsi
  final villages = ['Village 1', 'Village 2', 'Village 3']; // Contoh data desa
  final districts = ['District 1', 'District 2', 'District 3'];
  final marital_status = ['Menikah', 'Lajang', 'Cerai'];

  String? selectedGender;
  String? selectCity;
  String? selectProvince;
  String? selectVillage;
  String? selectDistrict;
  String? selectMaritalStatus;
  int? is_deceased = 0;
  DateTime? birthDate;

  late TextEditingController patientNameController;
  late TextEditingController nikController;
  late TextEditingController kkController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController birthPlaceController;
  late TextEditingController addressController;
  late TextEditingController cityCodeController;
  late TextEditingController provinceCodeController;
  late TextEditingController districtCodeController;
  late TextEditingController villageCodeController;
  late TextEditingController rtController;
  late TextEditingController rwController;
  late TextEditingController postalCodeController;
  late TextEditingController relationshipNameController;
  late TextEditingController relationshipPhoneController;

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    final String formattedDate = formatter.format(date);

    return formattedDate;
  }

  @override
  void initState() {
    super.initState();
    selectedGender = null;
    patientNameController = TextEditingController();
    nikController = TextEditingController();
    kkController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    birthPlaceController = TextEditingController();
    addressController = TextEditingController();
    cityCodeController = TextEditingController();
    provinceCodeController = TextEditingController();
    districtCodeController = TextEditingController();
    villageCodeController = TextEditingController();
    rtController = TextEditingController();
    rwController = TextEditingController();
    postalCodeController = TextEditingController();
    relationshipNameController = TextEditingController();
    relationshipPhoneController = TextEditingController();
  }

  @override
  void dispose() {
    patientNameController.dispose();
    nikController.dispose();
    kkController.dispose();
    phoneController.dispose();
    emailController.dispose();
    birthPlaceController.dispose();
    addressController.dispose();
    cityCodeController.dispose();
    provinceCodeController.dispose();
    districtCodeController.dispose();
    villageCodeController.dispose();
    rtController.dispose();
    rwController.dispose();
    postalCodeController.dispose();
    relationshipNameController.dispose();
    relationshipPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: SingleChildScrollView(
          child: SizedBox(
            width: context.deviceWidth / 2,
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
                  controller: kkController,
                  label: 'KK',
                  showLabel: false,
                ),
                const SpaceHeight(24.0),
                CustomTextField(
                  controller: patientNameController,
                  label: 'Nama Pasien',
                  showLabel: false,
                ),
                const SpaceHeight(24.0),
                CustomTextField(
                  controller: phoneController,
                  label: 'Nomor Handphone',
                  showLabel: false,
                ),
                const SpaceHeight(24.0),
                CustomTextField(
                  controller: emailController,
                  label: 'Email',
                  showLabel: false,
                ),
                const SpaceHeight(24.0),
                CustomDropdown(
                  value: selectedGender,
                  items: genders,
                  label: 'Jenis Kelamin',
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                  showLabel: false,
                ),
                const SpaceHeight(24.0),
                CustomTextField(
                  controller: birthPlaceController,
                  label: 'Tempat Lahir',
                  showLabel: false,
                ),
                const SpaceHeight(24.0),
                CustomDatePicker(
                  initialDate: birthDate,
                  label: 'Tanggal Lahir',
                  showLabel: false,
                  onDateSelected: (selectedDate) {
                    setState(() {
                      birthDate = selectedDate;
                    });
                  },
                ),
                const SpaceHeight(24.0),
                Row(
                  children: [
                    const Text('Status Kematian'),
                    const Spacer(),
                    Switch(
                      value: is_deceased == 1,
                      onChanged: (value) {
                        setState(() {
                          is_deceased = value ? 1 : 0;
                        });
                      },
                    ),
                  ],
                ),
                const SpaceHeight(24.0),
                CustomTextField(
                  controller: addressController,
                  label: 'Alamat Lengkap',
                  showLabel: false,
                ),
                const SpaceHeight(24.0),
                CustomDropdown(
                  value: selectCity,
                  items: cities,
                  label: 'Kota/Kabupaten',
                  onChanged: (value) {
                    setState(() {
                      selectCity = value;
                    });
                  },
                  showLabel: false,
                ),
                const SpaceHeight(24.0),
                CustomTextField(
                  controller: cityCodeController,
                  label: 'Kode Pos Kota/Kabupaten',
                  showLabel: false,
                ),
                const SpaceHeight(24.0),
                CustomDropdown(
                  value: selectProvince,
                  items: provinces,
                  label: 'Provinsi',
                  onChanged: (value) {
                    setState(() {
                      selectProvince = value;
                    });
                  },
                  showLabel: false,
                ),
                const SpaceHeight(24.0),
                CustomTextField(
                  controller: provinceCodeController,
                  label: 'Kode Pos Provinsi',
                  showLabel: false,
                ),
                const SpaceHeight(24.0),
                CustomDropdown(
                  value: selectDistrict,
                  items: districts,
                  label: 'Kecamatan',
                  onChanged: (value) {
                    setState(() {
                      selectDistrict = value;
                    });
                  },
                  showLabel: false,
                ),
                const SpaceHeight(24.0),
                CustomTextField(
                  controller: districtCodeController,
                  label: 'Kode Pos Kecamatan',
                  showLabel: false,
                ),
                const SpaceHeight(24.0),
                CustomDropdown(
                  value: selectVillage,
                  items: villages,
                  label: 'Desa/Kelurahan',
                  onChanged: (value) {
                    selectVillage = value;
                  },
                  showLabel: false,
                ),
                const SpaceHeight(24.0),
                CustomTextField(
                  controller: villageCodeController,
                  label: 'Kode Pos Desa/Kelurahan',
                  showLabel: false,
                ),
                const SpaceHeight(24.0),
                CustomTextField(
                  controller: rtController,
                  label: 'RT',
                  showLabel: false,
                ),
                const SpaceHeight(24.0),
                CustomTextField(
                  controller: rwController,
                  label: 'RW',
                  showLabel: false,
                ),
                const SpaceHeight(24.0),
                CustomTextField(
                  controller: postalCodeController,
                  label: 'Kode Pos',
                  showLabel: false,
                ),
                const SpaceHeight(24.0),
                CustomDropdown(
                  value: selectMaritalStatus,
                  items: marital_status,
                  label: 'Status Pernikahan',
                  onChanged: (value) {
                    selectMaritalStatus = value;
                  },
                  showLabel: false,
                ),
                const SpaceHeight(24.0),
                CustomTextField(
                  controller: relationshipNameController,
                  label: 'Nama Pasangan',
                  showLabel: false,
                ),
                const SpaceHeight(24.0),
                CustomTextField(
                  controller: relationshipPhoneController,
                  label: 'Nomor Handphone Pasangan',
                  showLabel: false,
                ),
                const SpaceHeight(24.0),
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
                      label: 'Create Patient',
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
