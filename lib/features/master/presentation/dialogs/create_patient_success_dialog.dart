// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../core/components/spaces.dart';
import '../../../../core/themes/colors.dart';

class CreatePatientSuccessDialog extends StatelessWidget {
  final String noAntrian;
  const CreatePatientSuccessDialog({
    super.key,
    required this.noAntrian,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Align(
        alignment: Alignment.topRight,
        child: CloseButton(),
      ),
      content: Padding(
        padding: const EdgeInsets.fromLTRB(40.0, 10, 40.0, 40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(50.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
              child: Text(
                noAntrian,
                style: const TextStyle(
                  fontSize: 120.0,
                  color: AppColors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SpaceHeight(30.0),
            const Text(
              'Berikut adalah Nomor antrian Anda\nMohon di simpan !',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SpaceHeight(20.0),
            // Button.filled(
            //   width: 120.0,
            //   onPressed: () {},
            //   label: 'Print',
            // ),
          ],
        ),
      ),
    );
  }
}
