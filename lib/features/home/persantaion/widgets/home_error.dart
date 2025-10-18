import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_text.dart';
import 'package:hungry/features/home/persantaion/cubit/product_cubit.dart';

class HomeError extends StatelessWidget {
  final Responsive responsive;

  const HomeError({super.key, required this.responsive});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: AppColors.error),
          Gap(responsive.setHeight(16)),
          CustomText(
            txt: 'Something went wrong',
            fontSize: responsive.setFont(18),
            color: AppColors.error,
          ),
          Gap(responsive.setHeight(16)),
          ElevatedButton(
            onPressed: () {
              context.read<ProductCubit>().initialize();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(
                horizontal: responsive.setWidth(32),
                vertical: responsive.setHeight(12),
              ),
            ),
            child: CustomText(
              txt: 'Retry',
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
