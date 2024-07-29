// ignore_for_file: use_build_context_synchronously

import 'dart:ui' as ui;

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/core/extensions/int_ext.dart';
import 'package:clinic_management_app/features/history/data/models/response/history_transaction_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/buttons.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/themes/colors.dart';
import '../../../master/presentation/widgets/build_app_bar.dart';
import '../../../patient-schedule/presentation/bloc/get_service_order/get_service_order_bloc.dart';
import '../../../setting/data/datasource/cwb_print.dart';
import '../bloc/history_transaction/history_transaction_bloc.dart';

class HistoryTransactionScreen extends StatefulWidget {
  const HistoryTransactionScreen({super.key});

  @override
  State<HistoryTransactionScreen> createState() =>
      _HistoryTransactionScreenState();
}

class _HistoryTransactionScreenState extends State<HistoryTransactionScreen> {
  final searchController = TextEditingController();

  final GlobalKey _globalKey = GlobalKey();

  Future<void> _requestPermission() async {
    if (await Permission.storage.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    } else {
      // You can request the permission again and handle the case when the user denies it.
      await Permission.storage.request();
    }
  }

  Future<void> _capturePng(String patientName, String time) async {
    await _requestPermission();

    try {
      // Add a small delay to ensure rendering is complete
      await Future.delayed(const Duration(milliseconds: 100));

      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(pngBytes),
        quality: 100,
        name: '$patientName - $time',
      );

      if (result['isSuccess']) {
        AnimatedSnackBar.material('Gambar berhasil disimpan di galeri',
                type: AnimatedSnackBarType.success,
                duration: const Duration(seconds: 3),
                desktopSnackBarPosition: DesktopSnackBarPosition.topLeft)
            .show(context);
      } else {
        AnimatedSnackBar.material('Gambar gagal disimpan',
                type: AnimatedSnackBarType.error,
                duration: const Duration(seconds: 3),
                desktopSnackBarPosition: DesktopSnackBarPosition.topLeft)
            .show(context);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    context
        .read<HistoryTransactionBloc>()
        .add(const HistoryTransactionEvent.getHistoryTransaction());
    initializeDateFormatting('id_ID', null);
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: BuildAppBar(
          title: 'Riwayat Transaksi',
          searchController: searchController,
          withSearchInput: true,
          searchHint: 'Cari Riwayat Berdasarkan Nama',
          keyboardType: TextInputType.name,
          searchChanged: (value) {
            if (value.isNotEmpty) {
              context.read<HistoryTransactionBloc>().add(
                  HistoryTransactionEvent.getHistoryTransactionByName(
                      searchController.text));
            } else {
              context
                  .read<HistoryTransactionBloc>()
                  .add(const HistoryTransactionEvent.getHistoryTransaction());
            }
          },
        ),
      ),
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: AppColors.primary,
        onRefresh: () async {
          searchController.clear();
          Future.delayed(const Duration(seconds: 1), () {
            context
                .read<HistoryTransactionBloc>()
                .add(const HistoryTransactionEvent.getHistoryTransaction());
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 72),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nama Pasien',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Metode Bayar',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Nominal',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Tanggal Transaksi',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Layanan & Obat',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Status',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SpaceHeight(32),
            BlocConsumer<HistoryTransactionBloc, HistoryTransactionState>(
              listener: (context, state) {
                state.maybeWhen(
                  loaded: (historyTransaction) {
                    if (historyTransaction.isNotEmpty) {
                      for (final transaction in historyTransaction) {
                        final scheduleId = transaction.patientSchedule?.id;
                        if (scheduleId != null) {
                          context.read<GetServiceOrderBloc>().add(
                              GetServiceOrderEvent.getServiceOrder(scheduleId));
                        }
                      }
                    }
                  },
                  orElse: () {},
                );
              },
              builder: (context, historyState) {
                return historyState.maybeWhen(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  loaded: (historyTransaction) {
                    if (historyTransaction.isEmpty) {
                      return const Center(
                          child: Text('Tidak ada riwayat transaksi'));
                    }
                    return Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SpaceHeight(12),
                        itemCount: historyTransaction.length,
                        itemBuilder: (context, index) {
                          final transaction = historyTransaction[index];
                          final scheduleId = transaction.patientSchedule?.id;

                          return InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return dialogProofPayment(
                                      transaction, context, scheduleId!);
                                },
                              );
                            },
                            child: Container(
                              height: context.deviceHeight * 0.085,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.stroke),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: context.deviceHeight * 0.85,
                                    width: 16,
                                    decoration: const BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        bottomLeft: Radius.circular(12),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12),
                                          child: Text(
                                            '${transaction.patient?.name}',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Text(
                                          '${transaction.paymentMethod}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          transaction
                                              .totalPrice!.currencyFormatRp,
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          DateFormat('d MMMM yyyy').format(
                                              transaction.transactionTime!),
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        if (scheduleId != null)
                                          _buildServiceOrder(
                                              context, scheduleId),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 24),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 6),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.5),
                                            color: transaction.totalPrice == 0
                                                ? AppColors.red.withOpacity(0.1)
                                                : AppColors.primary
                                                    .withOpacity(0.1),
                                          ),
                                          child: Text(
                                            transaction.totalPrice == 0
                                                ? 'Belum Bayar'
                                                : 'Sudah Bayar',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    transaction.totalPrice == 0
                                                        ? AppColors.red
                                                        : AppColors.primary),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  error: (message) => Center(child: Text(message)),
                  orElse: () =>
                      const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ]),
        ),
      ),
    );
  }

  AlertDialog dialogProofPayment(HistoryTransaction transaction,
      BuildContext context, int patientScheduleId) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
        child: Column(
          children: [
            RepaintBoundary(
              key: _globalKey,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          Assets.images.klinikFujiLogo.path,
                          width: 75.0,
                          height: 75.0,
                        ),
                      ),
                      const SpaceHeight(8.0),
                      const Center(
                        child: Text(
                          'Klinik Pratama Fuji',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SpaceHeight(4.0),
                      const Center(
                        child: Text(
                          'Jl. Evakuasi No.60, RT.01/RW.04,\nKalitanjung Timur,Harjamukti, Kota Cirebon',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SpaceHeight(12.0),
                      const Center(
                        child: Text(
                          'Riwayat Pembayaran Konsultasi Pasien',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SpaceHeight(20.0),
                      const Text('Nama Pasien'),
                      const SpaceHeight(5.0),
                      Text(
                        transaction.patient!.name ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Divider(),
                      const SpaceHeight(10.0),
                      const Text('Layanan & Obat'),
                      const SpaceHeight(5.0),
                      BlocBuilder<GetServiceOrderBloc, GetServiceOrderState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () {
                              return const CircularProgressIndicator();
                            },
                            loaded: (serviceOrder) {
                              //menampilkan nama layanan dan obat beserta harga
                              final serviceName =
                                  serviceOrder[patientScheduleId]!
                                      .map((e) => '${e.name}')
                                      .join('\n');
                              final servicePrice =
                                  serviceOrder[patientScheduleId]!
                                      .map((e) => e.price!.currencyFormatRp)
                                      .join('\n');
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    serviceName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    servicePrice,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      const Divider(),
                      const SpaceHeight(10.0),
                      const Text('Metode Bayar'),
                      const SpaceHeight(5.0),
                      Text(
                        transaction.paymentMethod ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Divider(),
                      const SpaceHeight(10.0),
                      const Text('Total Tagihan'),
                      const SpaceHeight(5.0),
                      Text(
                        transaction.totalPrice!.currencyFormatRp,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      // const SpaceHeight(10.0),
                      const Divider(),
                      const SpaceHeight(10.0),
                      const Text('Nominal Bayar'),
                      const SpaceHeight(5.0),
                      Text(
                        transaction.totalPrice!.currencyFormatRp,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      // const SpaceHeight(10.0),
                      const Divider(),
                      const SpaceHeight(10.0),
                      const Text('Waktu Pembayaran'),
                      const SpaceHeight(5.0),
                      Text(
                        DateFormat('EEEE, dd-MM-yyyy, HH:mm', 'id_ID')
                            .format(transaction.transactionTime!.toLocal()),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SpaceHeight(32.0),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: Button.outlined(
                    onPressed: () {
                      context.pop();
                    },
                    label: 'Kembali',
                  ),
                ),
                const SpaceWidth(8.0),
                Flexible(
                  child: Button.filled(
                    onPressed: () {
                      context.read<GetServiceOrderBloc>().state.maybeWhen(
                          loaded: (serviceOrder) async {
                            final printValue =
                                await CwbPrint.instance.printOrder(
                              transaction,
                              serviceOrder[patientScheduleId]!,
                            );
                            await PrintBluetoothThermal.writeBytes(printValue);
                          },
                          orElse: () {},
                          error: (message) =>
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(message),
                                  backgroundColor: Colors.red,
                                ),
                              ));
                    },
                    label: 'Print',
                  ),
                ),
                const SpaceWidth(8.0),
                Flexible(
                  child: Button.outlined(
                    onPressed: () {
                      _capturePng(
                          transaction.patient!.name!,
                          DateFormat('dd-MM-yyyy', 'id_ID')
                              .format(transaction.transactionTime!));
                    },
                    label: 'Simpan',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildServiceOrder(BuildContext context, int scheduleId) {
  return BlocBuilder<GetServiceOrderBloc, GetServiceOrderState>(
    builder: (context, state) {
      return state.maybeWhen(
        loading: () => Shimmer.fromColors(
          baseColor: AppColors.darkGrey,
          highlightColor: AppColors.grey.withOpacity(0.6),
          child: Container(
            width: 100,
            height: 20,
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        loaded: (serviceOrders) {
          final orders = serviceOrders[scheduleId];
          if (orders == null) {
            return Shimmer.fromColors(
              baseColor: AppColors.darkGrey,
              highlightColor: AppColors.grey.withOpacity(0.6),
              child: Container(
                width: 100,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            );
          }
          return SizedBox(
            width: context.deviceWidth * 0.08,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final data = orders[index];
                return Text(
                  data.name!,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                );
              },
            ),
          );
        },
        error: (message) => Center(child: Text(message)),
        orElse: () => Shimmer.fromColors(
          baseColor: AppColors.darkGrey,
          highlightColor: AppColors.grey.withOpacity(0.6),
          child: Container(
            width: 100,
            height: 20,
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      );
    },
  );
}

class HistoryShimmerLoading extends StatelessWidget {
  const HistoryShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const SpaceHeight(12),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Container(
            height: context.deviceHeight * 0.085,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.stroke),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Shimmer.fromColors(
                    baseColor: AppColors.darkGrey,
                    highlightColor: AppColors.grey.withOpacity(0.6),
                    child: Container(
                      width: 130,
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppColors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: AppColors.darkGrey,
                  highlightColor: AppColors.grey.withOpacity(0.6),
                  child: Container(
                    width: 100,
                    height: 20,
                    decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: AppColors.darkGrey,
                  highlightColor: AppColors.grey.withOpacity(0.6),
                  child: Container(
                    width: 100,
                    height: 20,
                    decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: AppColors.darkGrey,
                  highlightColor: AppColors.grey.withOpacity(0.6),
                  child: Container(
                    width: 100,
                    height: 20,
                    decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: AppColors.darkGrey,
                  highlightColor: AppColors.grey.withOpacity(0.6),
                  child: Container(
                    width: 120,
                    height: 20,
                    decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 32),
                  child: Shimmer.fromColors(
                    baseColor: AppColors.darkGrey,
                    highlightColor: AppColors.grey.withOpacity(0.6),
                    child: Container(
                      width: 100,
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppColors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
