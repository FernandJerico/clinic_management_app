import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/core/extensions/int_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

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
  @override
  void initState() {
    context
        .read<HistoryTransactionBloc>()
        .add(const HistoryTransactionEvent.getHistoryTransaction());
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
      body: Padding(
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
                    return Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SpaceHeight(12),
                        itemCount: historyTransaction.length,
                        itemBuilder: (context, index) {
                          context.read<GetServiceOrderBloc>().add(
                                GetServiceOrderEvent.getServiceOrder(
                                    historyTransaction[index].id!),
                              );
                          DateFormat formatter = DateFormat('d MMMM yyyy');
                          final transaction = historyTransaction[index];
                          return Container(
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
                                              width: context.deviceWidth * 0.08,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    serviceOrder.data!.length,
                                                itemBuilder: (context, index) {
                                                  final data =
                                                      serviceOrder.data![index];
                                                  return Text(
                                                    data.name!,
                                                    style: GoogleFonts.poppins(
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
                                              color: transaction.totalPrice == 0
                                                  ? AppColors.red
                                                  : AppColors.primary),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
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
