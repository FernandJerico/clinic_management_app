import 'package:clinic_management_app/core/components/components.dart';
import 'package:clinic_management_app/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuildAppBar extends StatelessWidget {
  final String title;
  final bool withSearchInput;
  final TextEditingController? searchController;
  final void Function(String)? searchChanged;
  final String searchHint;
  final Widget? trailing;

  const BuildAppBar({
    super.key,
    required this.title,
    this.withSearchInput = false,
    this.searchController,
    this.searchChanged,
    this.searchHint = 'Cari di sini',
    this.trailing,
  });

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    getCurrentDate(),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: AppColors.primary.withOpacity(0.8),
                    ),
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
