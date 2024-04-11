import 'package:flutter/material.dart';

import '../themes/colors.dart';

enum HistoryStatus {
  lunas('Lunas'),
  belumDibayar('Belum Dibayar'),
  notFound('Unknown status');

  final String value;
  const HistoryStatus(this.value);

  factory HistoryStatus.fromValue(String value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => HistoryStatus.notFound,
    );
  }
}

extension HistoryStatusExtension on HistoryStatus {
  Color get color {
    switch (this) {
      case HistoryStatus.lunas:
        return AppColors.orderIsConfirmed;
      case HistoryStatus.belumDibayar:
        return AppColors.red;
      default:
        throw Exception('Unknown status');
    }
  }

  Color get backgroundColor {
    switch (this) {
      case HistoryStatus.lunas:
        return AppColors.orderIsConfirmed.withOpacity(0.2);
      case HistoryStatus.belumDibayar:
        return AppColors.red.withOpacity(0.2);
      default:
        throw Exception('Unknown status');
    }
  }
}
