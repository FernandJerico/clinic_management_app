import 'package:flutter/material.dart';

import '../themes/colors.dart';

enum PatientStatus {
  waiting('Waiting'),
  confirmed('Confirmed'),
  processing('Processing'),
  processed('Processed'),
  rejected('Rejected'),
  completed('Completed'),
  onHold('On Hold'),
  notFound('Unknown status');

  final String value;
  const PatientStatus(this.value);

  factory PatientStatus.fromValue(String value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => PatientStatus.notFound,
    );
  }
}

extension PasientStatusExtension on PatientStatus {
  Color get color {
    switch (this) {
      case PatientStatus.waiting:
        return AppColors.orderIsWaiting;
      case PatientStatus.confirmed:
        return AppColors.orderIsConfirmed;
      case PatientStatus.processing:
        return AppColors.orderIsProcessing;
      case PatientStatus.processed:
        return AppColors.orderIsProcessing;
      case PatientStatus.completed:
        return AppColors.orderIsCompleted;
      case PatientStatus.rejected:
        return AppColors.orderIsRejected;
      case PatientStatus.onHold:
        return AppColors.orderIsOnHold;
      default:
        throw Exception('Unknown status');
    }
  }

  Color get backgroundColor {
    switch (this) {
      case PatientStatus.waiting:
        return AppColors.orderIsWaiting.withOpacity(0.2);
      case PatientStatus.confirmed:
        return AppColors.orderIsConfirmed.withOpacity(0.2);
      case PatientStatus.processing:
        return AppColors.orderIsProcessing.withOpacity(0.2);
      case PatientStatus.processed:
        return AppColors.orderIsProcessing.withOpacity(0.3);
      case PatientStatus.completed:
        return AppColors.orderIsCompleted.withOpacity(0.2);
      case PatientStatus.rejected:
        return AppColors.orderIsRejected.withOpacity(0.2);
      case PatientStatus.onHold:
        return AppColors.orderIsOnHold.withOpacity(0.2);
      default:
        throw Exception('Unknown status');
    }
  }
}
