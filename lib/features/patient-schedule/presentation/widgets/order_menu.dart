import 'package:clinic_management_app/core/extensions/int_ext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/themes/colors.dart';
import '../../data/models/response/service_order_response_model.dart';

class OrderMenu extends StatelessWidget {
  final ServiceOrder data;
  const OrderMenu({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // final qtyController = TextEditingController(text: '1');
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  child: Image.asset(
                    Assets.images.medicine.path,
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  data.name!,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(),
                ),
                subtitle: Text(
                  data.total!.currencyFormatRp,
                  style: GoogleFonts.poppins(),
                ),
              ),
            ),
            const SpaceWidth(8),
            SizedBox(
              width: 125.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    data.price!.currencyFormatRp,
                    // textAlign: TextAlign.right,
                    style: GoogleFonts.poppins(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
