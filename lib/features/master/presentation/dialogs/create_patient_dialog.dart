import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/features/binderbyte/data/model/response/city_response_model.dart';
import 'package:clinic_management_app/features/binderbyte/data/model/response/district_response_model.dart';
import 'package:clinic_management_app/features/binderbyte/data/model/response/province_response_model.dart';
import 'package:clinic_management_app/features/binderbyte/presentation/bloc/get_province_binder/get_province_binder_bloc.dart';
import 'package:clinic_management_app/features/master/data/models/request/add_patient_request_model.dart';
import 'package:clinic_management_app/features/master/presentation/bloc/add_patient/add_patient_bloc.dart';
import 'package:clinic_management_app/features/master/presentation/pages/data_patient_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

import '../../../../core/components/buttons.dart';
import '../../../../core/components/custom_date_picker.dart';
import '../../../../core/components/custom_dropdown.dart';
import '../../../../core/components/custom_text_field.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/themes/colors.dart';
import '../../../binderbyte/data/model/response/sub_district_response_model.dart';
import '../../../binderbyte/presentation/bloc/get_city_binder/get_city_binder_bloc.dart';
import '../../../binderbyte/presentation/bloc/get_district_binder/get_district_binder_bloc.dart';
import '../../../binderbyte/presentation/bloc/get_sub_district_binder/get_sub_district_binder_bloc.dart';

class CreatePatientDialog extends StatefulWidget {
  const CreatePatientDialog({
    super.key,
  });

  @override
  State<CreatePatientDialog> createState() => _CreatePatientDialogState();
}

class _CreatePatientDialogState extends State<CreatePatientDialog> {
  final genders = ['Laki-laki', 'Perempuan'];
  final maritalStatus = [
    'Belum Kawin',
    'Kawin Belum Tercatat',
    'Kawin Tercatat',
    'Cerai Hidup',
    'Cerai Mati'
  ];

  String? selectedGender;
  // City? selectCity;
  CityBB? selectCity;
  // Province? selectProvince;
  ProvinceBB? selectProvince;
  // Wilayah? selectDistrict;
  DistrictBB? selectDistrict;
  // Wilayah? selectVillage;
  SubDistrictBB? selectVillage;
  String? selectMaritalStatus;
  int? isDeceased = 0;
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
    // context.read<ProvinceBloc>().add(const ProvinceEvent.getProvince());
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
                        return const Center(child: CircularProgressIndicator());
                      },
                      loaded: (provinces) {
                        return CustomDropdown(
                          value: selectProvince,
                          items: provinces,
                          label: 'Provinsi',
                          onChanged: (value) {
                            // context.read<CityBloc>().add(CityEvent.getCity(
                            //     int.parse(value!.code ?? '0')));
                            context.read<GetCityBinderBloc>().add(
                                GetCityBinderEvent.getCity(value!.id ?? '0'));
                            debugPrint('province id: ${value.id}');
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
                            // context.read<DistrictBloc>().add(
                            //     DistrictEvent.getDistrict(
                            //         int.parse(value!.id ?? '0')));
                            context.read<GetDistrictBinderBloc>().add(
                                GetDistrictBinderEvent.getDistrict(
                                    value!.id ?? '0'));
                            debugPrint('city id: ${value.id ?? '0'}');
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
                            // context.read<SubDistrictBloc>().add(
                            //     SubDistrictEvent.getSubDistrict(
                            //         int.parse(value!.code ?? '0')));
                            context.read<GetSubDistrictBinderBloc>().add(
                                  GetSubDistrictBinderEvent.getSubDistrict(
                                      value!.id ?? '0'),
                                );
                            debugPrint('district id: ${value.id ?? '0'}');
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
                        child: BlocListener<AddPatientBloc, AddPatientState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          orElse: () {},
                          success: () {
                            const ScaffoldMessenger(
                                child: SnackBar(
                              content: Text('Patient Created Successfully'),
                              backgroundColor: AppColors.green,
                            ));
                            context.pushReplacement(const DataPatientScreen());
                          },
                        );
                      },
                      child: BlocBuilder<AddPatientBloc, AddPatientState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () {
                              return Button.filled(
                                onPressed: () {
                                  final addPatientRequest =
                                      AddPatientRequestModel(
                                    nik: nikController.text,
                                    kk: kkController.text,
                                    name: patientNameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    gender: selectedGender,
                                    birthPlace: birthPlaceController.text,
                                    birthDate: formatDate(birthDate!),
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
                                        relationshipNameController.text,
                                    relationshipPhone:
                                        relationshipPhoneController.text,
                                    isDeceased: isDeceased,
                                  );
                                  context.read<AddPatientBloc>().add(
                                      AddPatientEvent.addPatient(
                                          addPatientRequest));
                                },
                                label: 'Create Patient',
                              );
                            },
                            loading: () {
                              return SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: const CircularProgressIndicator(
                                      color: AppColors.white,
                                    )),
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
