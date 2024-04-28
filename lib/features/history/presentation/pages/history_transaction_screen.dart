import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/core/extensions/int_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/components/spaces.dart';
import '../../../../core/themes/colors.dart';
import '../../../master/presentation/widgets/build_app_bar.dart';
import '../bloc/history_transaction/history_transaction_bloc.dart';

class HistoryTransactionScreen extends StatefulWidget {
  const HistoryTransactionScreen({super.key});

  @override
  State<HistoryTransactionScreen> createState() =>
      _HistoryTransactionScreenState();
}

class _HistoryTransactionScreenState extends State<HistoryTransactionScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    context
        .read<HistoryTransactionBloc>()
        .add(const HistoryTransactionEvent.getHistoryTransaction());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: BuildAppBar(
          title: 'Riwayat Transaksi',
          keyboardType: TextInputType.text,
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
                      child: Text('data'),
                    );
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  loaded: (historyTransaction) {
                    return Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SpaceHeight(12),
                        itemCount: 5,
                        itemBuilder: (context, index) {
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
                                      Text(
                                        'Paracetamol\n Amoxilin\nVitamin C',
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
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
