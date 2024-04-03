// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/themes/colors.dart';

class NavItem extends StatelessWidget {
  final String iconPath;
  final bool isActive;
  final VoidCallback onTap;
  final Color color;
  final String text;
  const NavItem({
    Key? key,
    required this.iconPath,
    required this.isActive,
    required this.onTap,
    this.color = AppColors.white,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          child: ColoredBox(
            color: isActive
                ? AppColors.disabled.withOpacity(0.25)
                : Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 25.0,
                    height: 25.0,
                    child: SvgPicture.asset(
                      iconPath,
                      colorFilter: ColorFilter.mode(
                        color,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  isActive
                      ? Text(
                          text,
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
