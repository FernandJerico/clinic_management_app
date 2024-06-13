import 'package:clinic_management_app/core/assets/assets.gen.dart';
import 'package:clinic_management_app/core/components/button_gradient.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessDialog extends StatelessWidget {
  final String message;
  final String buttonText;
  //onpressed function button
  final Function() onPressed;
  const SuccessDialog(
      {super.key,
      required this.message,
      required this.buttonText,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      contentPadding: EdgeInsets.zero,
      content: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 134,
              width: 134,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: const Color(0xffDFEFFF)),
              child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Image.asset(Assets.images.horaayy.path)),
            ),
            const SizedBox(height: 16.0),
            Text(
              message,
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Button.gradient(
                onPressed: () {
                  onPressed();
                },
                label: buttonText)
          ],
        ),
      ),
    );
  }
}
