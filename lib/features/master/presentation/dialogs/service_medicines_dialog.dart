import 'dart:io';

import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/features/master/data/models/request/service_medicines_request_model.dart';
import 'package:clinic_management_app/features/master/presentation/bloc/data_service_medicine/data_service_medicine_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/components/button_loading.dart';
import '../../../../core/components/buttons.dart';
import '../../../../core/components/custom_text_field.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/themes/colors.dart';
import '../../data/models/response/service_medicine_response_model.dart';
import '../bloc/service_medicines/service_medicines_bloc.dart';

class ServiceMedicinesDialog extends StatefulWidget {
  final String type;
  final ServiceMedicine? service;
  const ServiceMedicinesDialog({super.key, required this.type, this.service});

  @override
  State<ServiceMedicinesDialog> createState() => _ServiceMedicinesDialogState();
}

class _ServiceMedicinesDialogState extends State<ServiceMedicinesDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController priceController;
  late final TextEditingController quantityController;

  final ImagePicker _picker = ImagePicker();
  File? _image;

  String? _selectedCategory;
  final List<String> _categories = [
    'medicine',
    'consultation',
    'treatment',
  ];

  @override
  void initState() {
    nameController = TextEditingController(text: widget.service?.name);
    priceController =
        TextEditingController(text: widget.service?.price.toString());
    quantityController =
        TextEditingController(text: widget.service?.quantity.toString());
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    quantityController.dispose();
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
          child: SingleChildScrollView(
            child: SizedBox(
              width: context.deviceWidth / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        'Tambah Service & Obat',
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
                    'Nama Service & Obat',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                      color: AppColors.darkGrey,
                    ),
                  ),
                  const SpaceHeight(8.0),
                  CustomTextField(
                    controller: nameController,
                    label: 'Masukkan Nama',
                    showLabel: false,
                  ),
                  const SpaceHeight(20.0),
                  const Text(
                    'Kategori',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                      color: AppColors.darkGrey,
                    ),
                  ),
                  const SpaceHeight(8.0),
                  DropdownButtonFormField<String>(
                    dropdownColor: Colors.white,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: 'Kategori',
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 12,
                      ),
                      hintStyle: GoogleFonts.poppins(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    value: widget.service?.category ?? _selectedCategory,
                    items: _categories.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Tolong pilih kategori';
                      }
                      return null;
                    },
                  ),
                  const SpaceHeight(20.0),
                  const Text(
                    'Harga',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                      color: AppColors.darkGrey,
                    ),
                  ),
                  const SpaceHeight(8.0),
                  CustomTextField(
                    controller: priceController,
                    label: 'Masukkan Harga',
                    showLabel: false,
                    keyboardType: TextInputType.number,
                  ),
                  const SpaceHeight(20.0),
                  const Text(
                    'Jumlah',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                      color: AppColors.darkGrey,
                    ),
                  ),
                  const SpaceHeight(8.0),
                  CustomTextField(
                    controller: quantityController,
                    label: 'Masukkan Jumlah',
                    showLabel: false,
                    keyboardType: TextInputType.number,
                  ),
                  const SpaceHeight(20.0),
                  const Text(
                    'Foto Item',
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
                        padding: const EdgeInsets.only(left: 6, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: AppColors.grey),
                              child: _image == null
                                  ? const Icon(Icons.no_photography_outlined)
                                  : Image.file(
                                      _image!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  final pickedFile = await _picker.pickImage(
                                      source: ImageSource.gallery);
                                  if (pickedFile != null) {
                                    setState(() {
                                      _image = File(pickedFile.path);
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                child: Text(
                                  'Upload Gambar',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ))
                          ],
                        ),
                      )),
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
                          child: BlocConsumer<ServiceMedicinesBloc,
                              ServiceMedicinesState>(
                        listener: (context, state) {
                          state.maybeWhen(
                            success: () {
                              context.pop();
                              context.read<DataServiceMedicineBloc>().add(
                                  const DataServiceMedicineEvent
                                      .getServiceMedicines());
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Service Medicines created!'),
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
                        },
                        builder: (context, state) {
                          return state.maybeWhen(
                              orElse: () {
                                return Button.filled(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (widget.type == 'add') {
                                        final requestData =
                                            ServiceMedicinesRequestModel(
                                          name: nameController.text,
                                          category: _selectedCategory,
                                          price: priceController.text,
                                          quantity: quantityController.text,
                                          photo: _image!,
                                        );
                                        context
                                            .read<ServiceMedicinesBloc>()
                                            .add(
                                              ServiceMedicinesEvent
                                                  .addServiceMedicines(
                                                      requestData),
                                            );
                                      } else if (widget.type == 'edit') {
                                        final requestData =
                                            ServiceMedicinesRequestModel(
                                          name: nameController.text,
                                          category: _selectedCategory,
                                          price: priceController.text,
                                          quantity: quantityController.text,
                                          photo: _image,
                                        );
                                        context
                                            .read<ServiceMedicinesBloc>()
                                            .add(
                                              ServiceMedicinesEvent
                                                  .editServiceMedicines(
                                                      serviceId: widget
                                                          .service!.id!
                                                          .toString(),
                                                      data: requestData),
                                            );
                                      }
                                    }
                                  },
                                  label: 'Create',
                                );
                              },
                              loading: () {
                                return const ButtonLoading();
                              },
                              error: (message) => ScaffoldMessenger(
                                      child: SnackBar(
                                    content: Text(message),
                                    backgroundColor: AppColors.red,
                                  )));
                        },
                      )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
