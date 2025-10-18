import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_text.dart';

class ProductDetailsError extends StatelessWidget {
  final Responsive responsive;

  const ProductDetailsError({super.key, required this.responsive});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: AppColors.textSecondary),
          Gap(responsive.setHeight(16)),
          CustomText(
            txt: 'Product not found',
            fontSize: responsive.setFont(18),
            color: AppColors.textSecondary,
          ),
          Gap(responsive.setHeight(16)),
          ElevatedButton(
            onPressed: () => GoRouter.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(
                horizontal: responsive.setWidth(32),
                vertical: responsive.setHeight(12),
              ),
            ),
            child: CustomText(
              txt: 'Go Back',
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
