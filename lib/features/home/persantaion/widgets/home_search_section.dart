import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_text.dart';
import 'package:hungry/core/widgets/custom_text_field.dart';
import 'package:hungry/features/home/persantaion/cubit/product_cubit.dart';

class HomeSearchSection extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final Responsive responsive;

  const HomeSearchSection({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.responsive,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: responsive.setWidth(20)),
        child: Column(
          children: [
            CustomTextField(
              controller: controller,
              onChanged: onChanged,
              prefix: Icon(
                CupertinoIcons.search,
                color: AppColors.textSecondary,
                size: responsive.setWidth(20),
              ),
              hint: CustomText(
                txt: 'Search products...',
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
                fontSize: responsive.setFont(16),
              ),
              suffix: controller.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        controller.clear();
                        context.read<ProductCubit>().searchProducts('');
                      },
                      icon: Icon(
                        Icons.clear,
                        size: responsive.setWidth(20),
                        color: AppColors.textSecondary,
                      ),
                    )
                  : null,
            ),
            Gap(responsive.setHeight(20)),
          ],
        ),
      ),
    );
  }
}
