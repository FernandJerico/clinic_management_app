import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/core/extensions/int_ext.dart';
import 'package:clinic_management_app/features/master/presentation/bloc/data_service_medicine/data_service_medicine_bloc.dart';
import 'package:clinic_management_app/features/master/presentation/dialogs/service_medicines_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/button_gradient.dart';
import '../../../../core/components/buttons.dart';
import '../../../../core/components/search_input.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/constants/variables.dart';
import '../../../../core/themes/colors.dart';
import '../bloc/service_medicines/service_medicines_bloc.dart';
import '../widgets/build_app_bar.dart';

class DataServiceScreen extends StatefulWidget {
  const DataServiceScreen({super.key});

  @override
  State<DataServiceScreen> createState() => _DataServiceScreenState();
}

class _DataServiceScreenState extends State<DataServiceScreen> {
  final searchController = TextEditingController();

  @override
  void initState() {
    context
        .read<DataServiceMedicineBloc>()
        .add(const DataServiceMedicineEvent.getServiceMedicines());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: BuildAppBar(
          keyboardType: TextInputType.text,
          withBackButton: true,
          trailing: ButtonGradient.filled(
              width: context.deviceWidth * 0.15,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => const ServiceMedicinesDialog(
                          type: 'add',
                        ));
              },
              label: 'Tambah Data'),
          title: 'Data Master Layanan & Obat',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          Padding(
            padding: EdgeInsets.only(right: context.deviceWidth / 2),
            child: SearchInput(
              keyboardType: TextInputType.text,
              controller: searchController,
              onChanged: (value) {
                if (value.isNotEmpty && value.length > 1) {
                  context.read<DataServiceMedicineBloc>().add(
                      DataServiceMedicineEvent.getServiceMedicineByName(value));
                } else {
                  context.read<DataServiceMedicineBloc>().add(
                      const DataServiceMedicineEvent.getServiceMedicines());
                }
              },
              hintText: 'Cari Data Item',
            ),
          ),
          const SpaceHeight(40.0),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.stroke),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              scrollDirection: Axis.horizontal,
              child: BlocBuilder<DataServiceMedicineBloc,
                  DataServiceMedicineState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    loaded: (serviceMedicines) {
                      return DataTable(
                        columnSpacing: context.deviceWidth * 0.08,
                        dataRowMinHeight: 30.0,
                        dataRowMaxHeight: 50.0,
                        columns: [
                          DataColumn(
                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Button.filled(
                                onPressed: () {},
                                label: 'Nama Item',
                                width: null,
                                color: AppColors.title,
                                textColor: AppColors.black.withOpacity(0.5),
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Button.filled(
                                onPressed: () {},
                                label: 'Kategori',
                                width: null,
                                color: AppColors.title,
                                textColor: AppColors.black.withOpacity(0.5),
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Button.filled(
                                onPressed: () {},
                                label: 'Harga',
                                width: null,
                                color: AppColors.title,
                                textColor: AppColors.black.withOpacity(0.5),
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Button.filled(
                                onPressed: () {},
                                label: 'Qty',
                                width: null,
                                color: AppColors.title,
                                textColor: AppColors.black.withOpacity(0.5),
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Button.filled(
                                onPressed: () {},
                                label: 'Photo',
                                width: null,
                                color: AppColors.title,
                                textColor: AppColors.black.withOpacity(0.5),
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Button.filled(
                                onPressed: () {},
                                label: 'Action',
                                width: null,
                                color: AppColors.title,
                                textColor: AppColors.black.withOpacity(0.5),
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ],
                        rows: serviceMedicines.isEmpty
                            ? [
                                const DataRow(
                                  cells: [
                                    DataCell(Row(
                                      children: [
                                        Icon(Icons.highlight_off),
                                        SpaceWidth(4.0),
                                        Text('Data tidak ditemukan..'),
                                      ],
                                    )),
                                    DataCell.empty,
                                    DataCell.empty,
                                    DataCell.empty,
                                    DataCell.empty,
                                    DataCell.empty,
                                  ],
                                ),
                              ]
                            : serviceMedicines
                                .map(
                                  (product) => DataRow(cells: [
                                    DataCell(Text(
                                      product.name ?? '-',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                    DataCell(Center(
                                        child: Text(product.category ?? '-'))),
                                    DataCell(Center(
                                        child: Text(
                                            product.price!.currencyFormatRp))),
                                    DataCell(Center(
                                        child: Text(
                                            '${product.quantity ?? '0'}'))),
                                    DataCell(Center(
                                      child: product.photo != null
                                          ? Image.network(
                                              '${Variables.imageBaseUrl}/${product.photo.replaceAll('public/', '')}',
                                              height: 40,
                                            )
                                          : const Icon(
                                              Icons.image_not_supported),
                                    )),
                                    DataCell(Center(
                                        child: PopupMenuButton(
                                      color: Colors.white,
                                      padding: const EdgeInsets.only(right: 20),
                                      offset: const Offset(-20, 0),
                                      icon: SvgPicture.asset(
                                          Assets.icons.action.path),
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                const Icon(Icons.edit),
                                                const SpaceWidth(8),
                                                Text(
                                                  'Edit',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            onTap: () => showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    ServiceMedicinesDialog(
                                                      type: 'edit',
                                                      service: product,
                                                    )),
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                const Icon(Icons
                                                    .delete_outline_outlined),
                                                const SpaceWidth(8),
                                                Text(
                                                  'Hapus',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Colors.white,
                                                    title: const Text(
                                                        'Hapus Item'),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          'Apakah anda yakin ingin menghapus data ini?',
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                        const SpaceHeight(16.0),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Button.outlined(
                                                              width: context
                                                                      .deviceWidth *
                                                                  0.15,
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              label: 'Batal',
                                                            ),
                                                            const SpaceWidth(8),
                                                            Button.filled(
                                                              width: context
                                                                      .deviceWidth *
                                                                  0.15,
                                                              onPressed: () {
                                                                context
                                                                    .read<
                                                                        ServiceMedicinesBloc>()
                                                                    .add(ServiceMedicinesEvent
                                                                        .deleteServiceMedicines(product
                                                                            .id!
                                                                            .toString()));
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  const SnackBar(
                                                                    content: Text(
                                                                        'Service Medicines deleted!'),
                                                                    backgroundColor:
                                                                        AppColors
                                                                            .green,
                                                                  ),
                                                                );
                                                                Navigator.pop(
                                                                    context);
                                                                context
                                                                    .read<
                                                                        DataServiceMedicineBloc>()
                                                                    .add(const DataServiceMedicineEvent
                                                                        .getServiceMedicines());
                                                              },
                                                              label:
                                                                  'Hapus Data',
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          )
                                        ];
                                      },
                                    ))),
                                  ]),
                                )
                                .toList(),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
