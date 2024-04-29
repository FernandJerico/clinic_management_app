// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clinic_management_app/core/constants/responsive.dart';
import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:clinic_management_app/core/components/components.dart';
import 'package:clinic_management_app/core/themes/colors.dart';

class BuildAppBar extends StatelessWidget {
  final String title;
  final bool withSearchInput;
  final TextEditingController? searchController;
  final void Function(String)? searchChanged;
  final String searchHint;
  final Widget? trailing;
  final TextInputType keyboardType;
  final bool withBackButton;

  const BuildAppBar({
    Key? key,
    required this.title,
    this.withSearchInput = false,
    this.searchController,
    this.searchChanged,
    this.searchHint = 'Cari di sini',
    this.trailing,
    this.keyboardType = TextInputType.text,
    this.withBackButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getCurrentDate() {
      DateTime now = DateTime.now();
      DateFormat formatter = DateFormat('EEEE, d MMMM yyyy');
      String formattedDate = formatter.format(now);
      return formattedDate;
    }

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.stroke)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 3,
              child: Row(
                children: [
                  if (withBackButton)
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => context.pop(),
                    ),
                  const SpaceWidth(12.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: ResponsiveWidget.isLargeScreen(context)
                              ? 28.0
                              : 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        getCurrentDate(),
                        style: GoogleFonts.poppins(
                          fontSize: ResponsiveWidget.isLargeScreen(context)
                              ? 16.0
                              : 12,
                          color: AppColors.primary.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (withSearchInput)
              Flexible(
                flex: 4,
                child: SearchInput(
                  controller: searchController!,
                  onChanged: searchChanged,
                  hintText: searchHint,
                  keyboardType: keyboardType,
                ),
              ),
            if (withSearchInput)
              const Flexible(flex: 1, child: SizedBox.shrink()),
            trailing ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
