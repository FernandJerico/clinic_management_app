import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'spaces.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String label;
  final Function(T? value)? onChanged;
  final bool showLabel;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.label,
    this.onChanged,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SpaceHeight(12.0),
        ],
        DropdownButtonFormField<T>(
          value: value,
          onChanged: onChanged,
          dropdownColor: Colors.white,
          validator: (value) {
            if (value == null) {
              return 'This field is required.';
            }
            return null;
          },
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(item.toString()),
            );
          }).toList(),
          decoration: InputDecoration(
            label: Text(label),
            labelStyle: GoogleFonts.poppins(
              fontSize: 12,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            hintStyle: GoogleFonts.poppins(fontSize: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
