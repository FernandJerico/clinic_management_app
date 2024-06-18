import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/features/navbar/presentation/pages/navbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/components/button_gradient.dart';
import '../../../../core/components/custom_dropdown.dart';
import '../../../../core/components/custom_text_field.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/themes/colors.dart';
import '../../../auth/data/datasources/auth_local_datasources.dart';
import '../../../binderbyte/data/model/response/city_response_model.dart';
import '../../../binderbyte/data/model/response/district_response_model.dart';
import '../../../binderbyte/data/model/response/province_response_model.dart';
import '../../../binderbyte/data/model/response/sub_district_response_model.dart';
import '../../../binderbyte/presentation/bloc/get_city_binder/get_city_binder_bloc.dart';
import '../../../binderbyte/presentation/bloc/get_district_binder/get_district_binder_bloc.dart';
import '../../../binderbyte/presentation/bloc/get_province_binder/get_province_binder_bloc.dart';
import '../../../binderbyte/presentation/bloc/get_sub_district_binder/get_sub_district_binder_bloc.dart';
import '../../../master/data/models/request/add_patient_request_model.dart';
import '../../../master/presentation/bloc/add_patient/add_patient_bloc.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({super.key});

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final _formKey = GlobalKey<FormState>();
  final genders = ['Laki-laki', 'Perempuan'];
  final maritalStatus = [
    'Belum Kawin',
    'Kawin Belum Tercatat',
    'Kawin Tercatat',
    'Cerai Hidup',
    'Cerai Mati'
  ];

  String? selectedGender;
  CityBB? selectCity;
  ProvinceBB? selectProvince;
  DistrictBB? selectDistrict;
  SubDistrictBB? selectVillage;
  String? selectMaritalStatus;
  int? isDeceased = 0;

  late TextEditingController patientNameController;
  late TextEditingController nikController;
  late TextEditingController kkController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController dateController;
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
    context
        .read<GetProvinceBinderBloc>()
        .add(const GetProvinceBinderEvent.getProvince());
    super.initState();
    selectedGender = null;
    patientNameController = TextEditingController();
    nikController = TextEditingController();
    kkController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    dateController = TextEditingController();
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
    super.initState();
  }

  @override
  void dispose() {
    patientNameController.dispose();
    nikController.dispose();
    kkController.dispose();
    phoneController.dispose();
    emailController.dispose();
    dateController.dispose();
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
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'Tambah Data Pasien',
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
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Column(
                children: [
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
                  TextFormField(
                    controller: dateController,
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1960),
                        lastDate: DateTime.now(),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          dateController.text = formatDate(selectedDate);
                        });
                      }
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.calendar_today,
                        color: AppColors.primary,
                      ),
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
                  const SpaceHeight(24.0),
                  Row(
                    children: [
                      const Text('Status Kematian'),
                      const Spacer(),
                      Switch(
                        value: isDeceased == 1,
                        onChanged: (value) {
                          setState(() {
                            isDeceased = value ? 1 : 0;
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
                  BlocBuilder<GetProvinceBinderBloc, GetProvinceBinderState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                        loaded: (provinces) {
                          return CustomDropdown(
                            value: selectProvince,
                            items: provinces,
                            label: 'Provinsi',
                            onChanged: (value) {
                              context.read<GetCityBinderBloc>().add(
                                  GetCityBinderEvent.getCity(value!.id ?? '0'));
                              setState(() {
                                selectProvince = value;
                              });
                            },
                            showLabel: false,
                          );
                        },
                      );
                    },
                  ),
                  const SpaceHeight(24.0),
                  BlocBuilder<GetCityBinderBloc, GetCityBinderState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return CustomDropdown(
                            value: selectCity,
                            items: const [],
                            label: 'Kota/Kabupaten',
                            onChanged: (value) {},
                            showLabel: false,
                          );
                        },
                        loaded: (cities) {
                          return CustomDropdown(
                            value: selectCity,
                            items: cities,
                            label: 'Kota/Kabupaten',
                            onChanged: (value) {
                              context.read<GetDistrictBinderBloc>().add(
                                  GetDistrictBinderEvent.getDistrict(
                                      value!.id ?? '0'));
                              setState(() {
                                selectCity = value;
                              });
                            },
                            showLabel: false,
                          );
                        },
                      );
                    },
                  ),
                  const SpaceHeight(24.0),
                  BlocBuilder<GetDistrictBinderBloc, GetDistrictBinderState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return CustomDropdown(
                            value: selectDistrict,
                            items: const [],
                            label: 'Kecamatan',
                            onChanged: (value) {},
                            showLabel: false,
                          );
                        },
                        loaded: (districts) {
                          return CustomDropdown(
                            value: selectDistrict,
                            items: districts,
                            label: 'Kecamatan',
                            onChanged: (value) {
                              context.read<GetSubDistrictBinderBloc>().add(
                                    GetSubDistrictBinderEvent.getSubDistrict(
                                        value!.id ?? '0'),
                                  );
                              setState(() {
                                selectDistrict = value;
                              });
                            },
                            showLabel: false,
                          );
                        },
                      );
                    },
                  ),
                  const SpaceHeight(24.0),
                  BlocBuilder<GetSubDistrictBinderBloc,
                      GetSubDistrictBinderState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return CustomDropdown(
                            value: selectVillage,
                            items: const [],
                            label: 'Desa/Kelurahan',
                            onChanged: (value) {},
                            showLabel: false,
                          );
                        },
                        loaded: (subDistricts) {
                          return CustomDropdown(
                            value: selectVillage,
                            items: subDistricts,
                            label: 'Desa/Kelurahan',
                            onChanged: (value) {
                              selectVillage = value;
                            },
                            showLabel: false,
                          );
                        },
                      );
                    },
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
                    items: maritalStatus,
                    label: 'Status Pernikahan',
                    onChanged: (value) {
                      selectMaritalStatus = value;
                    },
                    showLabel: false,
                  ),
                  const SpaceHeight(24.0),
                  CustomTextField(
                    controller: relationshipNameController,
                    label: 'Nama Pasangan (Opsional)',
                    showLabel: false,
                  ),
                  const SpaceHeight(24.0),
                  CustomTextField(
                    controller: relationshipPhoneController,
                    label: 'Nomor Handphone Pasangan (Opsional)',
                    showLabel: false,
                  ),
                  const SpaceHeight(24.0),
                  BlocListener<AddPatientBloc, AddPatientState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () {},
                        success: () {
                          const ScaffoldMessenger(
                              child: SnackBar(
                            content: Text('Patient Created Successfully'),
                            backgroundColor: AppColors.green,
                          ));
                          context.pushAndRemoveUntil(
                            const NavbarScreen(initialSelectedItem: 1),
                            (route) => false,
                          );
                        },
                      );
                    },
                    child: BlocBuilder<AddPatientBloc, AddPatientState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () {
                            return ButtonGradient.filled(
                              onPressed: () async {
                                final userId =
                                    await AuthLocalDatasources().getAuthData();
                                if (_formKey.currentState!.validate()) {
                                  final addPatientRequest =
                                      AddPatientRequestModel(
                                    nik: nikController.text,
                                    kk: kkController.text,
                                    name: patientNameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    gender: selectedGender,
                                    birthPlace: birthPlaceController.text,
                                    birthDate: dateController.text,
                                    addressLine: addressController.text,
                                    province: selectProvince!.name,
                                    provinceCode: selectProvince!.id,
                                    city: selectCity!.name,
                                    cityCode: selectCity!.id,
                                    district: selectDistrict!.name,
                                    districtCode: selectDistrict!.id,
                                    village: selectVillage!.name,
                                    villageCode: selectVillage!.id,
                                    rt: rtController.text,
                                    rw: rwController.text,
                                    postalCode: postalCodeController.text,
                                    maritalStatus: selectMaritalStatus,
                                    relationshipName:
                                        relationshipNameController.text.isEmpty
                                            ? '-'
                                            : relationshipNameController.text,
                                    relationshipPhone:
                                        relationshipPhoneController.text.isEmpty
                                            ? '-'
                                            : relationshipPhoneController.text,
                                    isDeceased: isDeceased,
                                    userId: userId!.user!.id!,
                                    status: 0,
                                  );
                                  debugPrint(
                                      addPatientRequest.toJson().toString());
                                  if (context.mounted) {
                                    context.read<AddPatientBloc>().add(
                                        AddPatientEvent.addPatient(
                                            addPatientRequest));
                                  }
                                }
                              },
                              label: 'Create Patient',
                            );
                          },
                          loading: () {
                            return ButtonGradient.loading(
                              onPressed: () {},
                            );
                          },
                          error: (message) {
                            return ScaffoldMessenger(
                                child: SnackBar(
                              content: Text(message),
                              backgroundColor: AppColors.red,
                            ));
                          },
                        );
                      },
                    ),
                  ),
                  const SpaceHeight(24.0),
                ],
              ),
            )),
      ),
    );
  }
}
