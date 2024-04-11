import 'package:flutter/material.dart';

import '../themes/colors.dart';

class ButtonLoading extends StatelessWidget {
  const ButtonLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const CircularProgressIndicator(
            color: AppColors.white,
          )),
    );
  }
}
