import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:flutter/material.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/buttons.dart';
import '../../../../core/components/spaces.dart';

class CreateRMSuccessDialog extends StatelessWidget {
  const CreateRMSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Align(
        alignment: Alignment.topRight,
        child: CloseButton(),
      ),
      content: Padding(
        padding: const EdgeInsets.fromLTRB(40.0, 10, 40.0, 40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Assets.images.createRmSuccess.image(),
            ),
            const SpaceHeight(20.0),
            Button.filled(
              width: 120.0,
              onPressed: () => context.pop(true),
              label: 'Submit',
            ),
          ],
        ),
      ),
    );
  }
}
