import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_text.dart';

void showOrderConfirmation(BuildContext context, Responsive responsive) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(responsive.setWidth(20)),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            color: AppColors.success,
            size: responsive.setWidth(64),
          ),
          Gap(responsive.setHeight(16)),
          CustomText(
            txt: 'Order Placed!',
            fontSize: responsive.setFont(22),
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          Gap(responsive.setHeight(8)),
          CustomText(
            txt: 'Your order has been successfully placed',
            fontSize: responsive.setFont(14),
            color: AppColors.textSecondary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              GoRouter.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(vertical: responsive.setHeight(12)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(responsive.setWidth(12)),
              ),
            ),
            child: CustomText(
              txt: 'OK',
              fontSize: responsive.setFont(16),
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
