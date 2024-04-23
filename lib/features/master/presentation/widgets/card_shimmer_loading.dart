import 'package:clinic_management_app/core/extensions/build_context_ext.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/components/spaces.dart';
import '../../../../core/themes/colors.dart';

class CardShimmerLoading extends StatelessWidget {
  const CardShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: context.deviceHeight * 0.15,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.stroke),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SpaceWidth(20),
                  Shimmer.fromColors(
                    baseColor: AppColors.darkGrey,
                    highlightColor: AppColors.grey.withOpacity(0.6),
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: AppColors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SpaceWidth(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Shimmer.fromColors(
                        baseColor: AppColors.darkGrey,
                        highlightColor: AppColors.grey.withOpacity(0.6),
                        child: Container(
                          width: 150,
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppColors.grey.withOpacity(0.2),
                          ),
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: AppColors.darkGrey,
                        highlightColor: AppColors.grey.withOpacity(0.6),
                        child: Container(
                          width: 120,
                          height: 16,
                          decoration: BoxDecoration(
                            color: AppColors.grey.withOpacity(0.2),
                          ),
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: AppColors.darkGrey,
                        highlightColor: AppColors.grey.withOpacity(0.6),
                        child: Container(
                          width: 120,
                          height: 16,
                          decoration: BoxDecoration(
                            color: AppColors.grey.withOpacity(0.2),
                          ),
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: AppColors.darkGrey,
                        highlightColor: AppColors.grey.withOpacity(0.6),
                        child: Container(
                          width: 100,
                          height: 16,
                          decoration: BoxDecoration(
                            color: AppColors.grey.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Shimmer.fromColors(
                baseColor: AppColors.darkGrey,
                highlightColor: AppColors.grey.withOpacity(0.6),
                child: Container(
                  margin: const EdgeInsets.only(right: 24),
                  height: 24,
                  width: 120,
                  decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
