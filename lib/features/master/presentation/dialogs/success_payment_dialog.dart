import 'package:clinic_management_app/core/extensions/int_ext.dart';
import 'package:clinic_management_app/features/navbar/presentation/pages/navbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/buttons.dart';
import '../../../../core/components/spaces.dart';

class SuccessPaymentDialog extends StatefulWidget {
  final String paymentMethod;
  final int totalPrice;
  final DateTime transactionTime;
  const SuccessPaymentDialog(
      {super.key,
      required this.paymentMethod,
      required this.totalPrice,
      required this.transactionTime});

  @override
  State<SuccessPaymentDialog> createState() => _SuccessPaymentDialogState();
}

class _SuccessPaymentDialogState extends State<SuccessPaymentDialog> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Assets.icons.success.svg()),
            const SpaceHeight(26.0),
            const Center(
              child: Text(
                'Pembayaran Telah Sukses Dilakukan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SpaceHeight(32.0),
            const Text('METODE BAYAR'),
            const SpaceHeight(5.0),
            Text(
              widget.paymentMethod,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            // const SpaceHeight(10.0),
            const Divider(),
            const SpaceHeight(10.0),
            const Text('TOTAL TAGIHAN'),
            const SpaceHeight(5.0),
            Text(
              widget.totalPrice.currencyFormatRp,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            // const SpaceHeight(10.0),
            const Divider(),
            const SpaceHeight(10.0),
            const Text('NOMINAL BAYAR'),
            const SpaceHeight(5.0),
            Text(
              widget.totalPrice.currencyFormatRp,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            // const SpaceHeight(10.0),
            const Divider(),
            const SpaceHeight(10.0),
            const Text('WAKTU PEMBAYARAN'),
            const SpaceHeight(5.0),
            Text(
              DateFormat('EEEE, dd-MM-yyyy, HH:mm', 'id_ID')
                  .format(widget.transactionTime),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SpaceHeight(32.0),
            Row(
              children: [
                Flexible(
                  child: Button.outlined(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const NavbarScreen(initialSelectedItem: 6)));
                    },
                    label: 'Kembali',
                  ),
                ),
                const SpaceWidth(8.0),
                Flexible(
                  child: Button.filled(
                    onPressed: () {},
                    label: 'Print',
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
