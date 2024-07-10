import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/core/extensions/int_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/buttons.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/themes/colors.dart';
import '../../../master/presentation/widgets/build_app_bar.dart';
import '../../../patient-schedule/presentation/bloc/get_service_order/get_service_order_bloc.dart';
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

  Future<void> _capturePng(String patientName, String time) async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = await getDownloadsDirectory();
      final imagePath = '${directory!.path}/$patientName - $time.png';
      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(pngBytes);

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Gambar berhasil disimpan di $imagePath'),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Future<void> _sharePng() async {
  //   try {
  //     RenderRepaintBoundary boundary = _globalKey.currentContext!
  //         .findRenderObject() as RenderRepaintBoundary;
  //     ui.Image image = await boundary.toImage();
  //     ByteData? byteData =
  //         await image.toByteData(format: ui.ImageByteFormat.png);
  //     Uint8List pngBytes = byteData!.buffer.asUint8List();

  //     final directory = await getApplicationDocumentsDirectory();
  //     final imagePath = '${directory.path}/screenshot.png';
  //     final imageFile = File(imagePath);
  //     await imageFile.writeAsBytes(pngBytes);

  //     await Share.shareXFiles([XFile(imagePath)],
  //         text: 'Ini Adalah Bukti Pembayaran a/n Pasien');

  //     // ignore: use_build_context_synchronously
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text('Gambar berhasil disimpan dan dibagikan'),
  //       backgroundColor: Colors.green,
  //     ));
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              BlocBuilder<HistoryTransactionBloc, HistoryTransactionState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    loading: () {
                      return const HistoryShimmerLoading();
                    },
                    loaded: (historyTransaction) {
                      if (historyTransaction.isEmpty) {
                        return const Center(
                          child: Text('Tidak ada riwayat transaksi'),
                        );
                      }
                      return Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              const SpaceHeight(12),
                          itemCount: historyTransaction.length,
                          itemBuilder: (context, index) {
                            final transaction = historyTransaction[index];
                            context.read<GetServiceOrderBloc>().add(
                                  GetServiceOrderEvent.getServiceOrder(
                                      transaction.id!),
                                );
                            DateFormat formatter = DateFormat('d MMMM yyyy');
                            return InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            RepaintBoundary(
                                              key: _globalKey,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16,
                                                        horizontal: 40),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                        child: Assets
                                                            .icons.success
                                                            .svg()),
                                                    const SpaceHeight(26.0),
                                                    const Center(
                                                      child: Text(
                                                        'Riwayat Pembayaran Konsultasi Pasien',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ),
                                                    const SpaceHeight(32.0),
                                                    const Text('Nama Pasien'),
                                                    const SpaceHeight(5.0),
                                                    Text(
                                                      transaction
                                                              .patient!.name ??
                                                          '',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    const Divider(),
                                                    const SpaceHeight(10.0),
                                                    const Text(
                                                        'Layanan & Obat'),
                                                    const SpaceHeight(5.0),
                                                    BlocBuilder<
                                                        GetServiceOrderBloc,
                                                        GetServiceOrderState>(
                                                      builder:
                                                          (context, state) {
                                                        return state.maybeWhen(
                                                          orElse: () {
                                                            return const CircularProgressIndicator();
                                                          },
                                                          loaded:
                                                              (serviceOrder) {
                                                            //menampilkan nama layanan dan obat beserta harga
                                                            final service =
                                                                serviceOrder
                                                                    .data!
                                                                    .map((e) =>
                                                                        '${e.name} - ${e.price!.currencyFormatRp}')
                                                                    .join('\n');
                                                            return Row(
                                                              children: [
                                                                Text(
                                                                  service,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
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
                                                      transaction
                                                              .paymentMethod ??
                                                          '',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    const Divider(),
                                                    const SpaceHeight(10.0),
                                                    const Text('Total Tagihan'),
                                                    const SpaceHeight(5.0),
                                                    Text(
                                                      transaction.totalPrice!
                                                          .currencyFormatRp,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    // const SpaceHeight(10.0),
                                                    const Divider(),
                                                    const SpaceHeight(10.0),
                                                    const Text('Nominal Bayar'),
                                                    const SpaceHeight(5.0),
                                                    Text(
                                                      transaction.totalPrice!
                                                          .currencyFormatRp,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    // const SpaceHeight(10.0),
                                                    const Divider(),
                                                    const SpaceHeight(10.0),
                                                    const Text(
                                                        'Waktu Pembayaran'),
                                                    const SpaceHeight(5.0),
                                                    Text(
                                                      DateFormat(
                                                              'EEEE, dd-MM-yyyy, HH:mm',
                                                              'id_ID')
                                                          .format(transaction
                                                              .transactionTime!
                                                              .toLocal()),
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    const SpaceHeight(32.0),
                                                  ],
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
                                                      // _sharePng();
                                                    },
                                                    label: 'Print',
                                                  ),
                                                ),
                                                const SpaceWidth(8.0),
                                                Flexible(
                                                  child: Button.outlined(
                                                    onPressed: () {
                                                      _capturePng(
                                                          transaction
                                                              .patient!.name!,
                                                          DateFormat(
                                                                  'dd-MM-yyyy',
                                                                  'id_ID')
                                                              .format(transaction
                                                                  .transactionTime!));
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
                                                  fontWeight:
                                                      FontWeight.normal),
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
                                            formatter.format(
                                                transaction.transactionTime!),
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          BlocBuilder<GetServiceOrderBloc,
                                                  GetServiceOrderState>(
                                              builder: (context, state) {
                                            return state.maybeWhen(
                                              orElse: () {
                                                return const CircularProgressIndicator();
                                              },
                                              loaded: (serviceOrder) {
                                                return SizedBox(
                                                  width: context.deviceWidth *
                                                      0.08,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: serviceOrder
                                                        .data!.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final data = serviceOrder
                                                          .data![index];
                                                      return Text(
                                                        data.name!,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            );
                                          }),
                                          // BlocConsumer<GetServiceOrderBloc,
                                          //     GetServiceOrderState>(
                                          //   listener: (context, state) {
                                          //     context
                                          //         .read<GetServiceOrderBloc>()
                                          //         .add(
                                          //           GetServiceOrderEvent
                                          //               .getServiceOrder(
                                          //                   transaction.id!),
                                          //         );
                                          //   },
                                          //   builder: (context, state) {
                                          //     return state.maybeWhen(
                                          //       orElse: () {
                                          //         return const CircularProgressIndicator();
                                          //       },
                                          //       loaded: (serviceOrder) {
                                          //         return SizedBox(
                                          //             width: context.deviceWidth *
                                          //                 0.08,
                                          //             child: ListView.builder(
                                          //                 shrinkWrap: true,
                                          //                 itemCount: serviceOrder
                                          //                     .data!.length,
                                          //                 itemBuilder:
                                          //                     (context, index) {
                                          //                   final data =
                                          //                       serviceOrder
                                          //                           .data![index];
                                          //                   return Text(
                                          //                     data.name!,
                                          //                     style: GoogleFonts
                                          //                         .poppins(
                                          //                       fontSize: 14,
                                          //                       fontWeight:
                                          //                           FontWeight
                                          //                               .normal,
                                          //                     ),
                                          //                   );
                                          //                 }));
                                          //       },
                                          //     );
                                          //   },
                                          // ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 24),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 6),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4.5),
                                              color: transaction.totalPrice == 0
                                                  ? AppColors.red
                                                      .withOpacity(0.1)
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
                                                      transaction.totalPrice ==
                                                              0
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
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
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
