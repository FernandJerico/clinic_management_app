// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clinic_management_app/core/themes/colors.dart';
import 'package:clinic_management_app/features/master/presentation/pages/data_doctor_screen.dart';
import 'package:flutter/material.dart';

import 'package:clinic_management_app/core/assets/assets.gen.dart';
import 'package:clinic_management_app/core/components/button_menu.dart';
import 'package:clinic_management_app/core/components/components.dart';
import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:clinic_management_app/features/master/presentation/widgets/build_app_bar.dart';

import 'data_patient_screen.dart';

class MasterScreen extends StatefulWidget {
  final void Function(int index) onTap;
  const MasterScreen({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: BuildAppBar(
          title: 'Data Master',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 110.0),
        child: Wrap(
          runSpacing: 16,
          children: [
            ButtonMenu(
              label: 'Data Dokter',
              iconPath: Assets.images.menu.data.path,
              onPressed: () {
                context.push(const DataDoctorScreen());
              },
            ),
            const SpaceWidth(45.0),
            ButtonMenu(
              label: 'Data Pasien',
              iconPath: Assets.images.menu.data.path,
              onPressed: () {
                context.push(const DataPatientScreen());
              },
            ),
            const SpaceWidth(45.0),
            ButtonMenu(
              label: 'Jadwal Dokter',
              iconPath: Assets.images.menu.jadwal.path,
              onPressed: () => widget.onTap(3),
            ),
            const SpaceWidth(45.0),
            ButtonMenu(
              label: 'Layanan',
              iconPath: Assets.images.menu.layanan.path,
              onPressed: () => widget.onTap(4),
            ),
          ],
        ),
      ),
    );
  }
}
