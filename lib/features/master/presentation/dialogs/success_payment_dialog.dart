import 'package:clinic_management_app/features/navbar/presentation/pages/navbar_screen.dart';
import 'package:flutter/material.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/buttons.dart';
import '../../../../core/components/spaces.dart';

class SuccessPaymentDialog extends StatelessWidget {
  const SuccessPaymentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Assets.icons.success.svg()),
            const SpaceHeight(26.0),
            const Center(
              child: Text(
                'Pembayaran Anda Diterima',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SpaceHeight(32.0),
            const Text('METODE BAYAR'),
            const SpaceHeight(5.0),
            const Text(
              'QRIS',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            // const SpaceHeight(10.0),
            const Divider(),
            const SpaceHeight(10.0),
            const Text('TOTAL TAGIHAN'),
            const SpaceHeight(5.0),
            const Text(
              'Rp. 45.000',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            // const SpaceHeight(10.0),
            const Divider(),
            const SpaceHeight(10.0),
            const Text('NOMINAL BAYAR'),
            const SpaceHeight(5.0),
            const Text(
              'Rp. 45.000',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            // const SpaceHeight(10.0),
            const Divider(),
            const SpaceHeight(10.0),
            const Text('WAKTU PEMBAYARAN'),
            const SpaceHeight(5.0),
            const Text(
              '24 Februari 2024, 11:17',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SpaceHeight(32.0),
            Row(
              children: [
                Flexible(
                  child: Button.outlined(
                    onPressed: () {
                      // context.pop();
                      // context.pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NavbarScreen()));
                    },
                    label: 'Selesai',
                  ),
                ),
                // const SpaceWidth(8.0),
                // Flexible(
                //   child: Button.filled(
                //     onPressed: () {},
                //     label: 'Print',
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
