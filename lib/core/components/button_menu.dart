import 'package:clinic_management_app/core/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/colors.dart';

class ButtonMenu extends StatelessWidget {
  final String label;
  final String iconPath;
  final VoidCallback onPressed;

  const ButtonMenu({
    super.key,
    required this.label,
    required this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 160.0,
        height: 160.0,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: AppColors.primary),
          color: AppColors.primary.withOpacity(0.13),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(child: Image.asset(iconPath)),
            const SpaceHeight(4),
            Text(
              label,
              style: GoogleFonts.poppins(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
