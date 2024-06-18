import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/colors.dart';

enum ButtonStyleType { gradient, gradientLoading }

class ButtonGradient extends StatelessWidget {
  const ButtonGradient.filled({
    super.key,
    required this.onPressed,
    required this.label,
    this.style = ButtonStyleType.gradient,
    this.color = AppColors.primary,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.height = 50.0,
    this.borderRadius = 16.0,
    this.icon,
    this.suffixIcon,
    this.disabled = false,
    this.fontSize = 14.0,
  });

  const ButtonGradient.loading({
    super.key,
    required this.onPressed,
    this.label = '',
    this.style = ButtonStyleType.gradientLoading,
    this.color = Colors.transparent,
    this.textColor = AppColors.primary,
    this.width = double.infinity,
    this.height = 50.0,
    this.borderRadius = 16.0,
    this.icon,
    this.suffixIcon,
    this.disabled = false,
    this.fontSize = 16.0,
  });

  final Function() onPressed;
  final String label;
  final ButtonStyleType style;
  final Color color;
  final Color textColor;
  final double? width;
  final double height;
  final double borderRadius;
  final Widget? icon;
  final Widget? suffixIcon;
  final bool disabled;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2B8D77), Color(0xFF00BC00)],
        ),
      ),
      child: style == ButtonStyleType.gradient
          ? ElevatedButton(
              onPressed: disabled ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon ?? const SizedBox.shrink(),
                  if (icon != null && label.isNotEmpty)
                    const SizedBox(width: 10.0),
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      color: textColor,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (suffixIcon != null && label.isNotEmpty)
                    const SizedBox(width: 10.0),
                  suffixIcon ?? const SizedBox.shrink(),
                ],
              ),
            )
          : ElevatedButton(
              onPressed: disabled ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon ?? const SizedBox.shrink(),
                  if (icon != null && label.isNotEmpty)
                    const SizedBox(width: 10.0),
                  const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                  if (suffixIcon != null && label.isNotEmpty)
                    const SizedBox(width: 10.0),
                  suffixIcon ?? const SizedBox.shrink(),
                ],
              ),
            ),
    );
  }
}
