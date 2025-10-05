import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/consts/app_assets.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/router/route_names.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_text.dart';

class FoodCard extends StatelessWidget {
  final int index;
  final Responsive responsive;
  final bool isSelected;

  const FoodCard({
    super.key,
    required this.index,
    required this.responsive,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).push(RouteNames.productDetails),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(responsive.setWidth(12)),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.mediumGrey.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Material(
          elevation: 3,
          color: AppColors.white,
          borderRadius: BorderRadius.circular(responsive.setWidth(15)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(responsive.setWidth(15)),
              color: AppColors.white,
            ),
            child: Padding(
              padding: EdgeInsets.all(responsive.setWidth(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: Hero(
                        tag: 'food_$index',
                        child: Image.asset(
                          AppImages.imageTest,
                          width: responsive.setWidth(120),
                          height: responsive.setHeight(120),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Gap(responsive.setHeight(10)),
                  CustomText(
                    txt: 'Hamburger',
                    fontWeight: FontWeight.w600,
                    fontSize: responsive.setFont(14),
                    color: AppColors.textPrimary,
                  ),
                  CustomText(
                    txt: 'Veggie Burger',
                    fontWeight: FontWeight.w400,
                    fontSize: responsive.setFont(12),
                    color: AppColors.textSecondary,
                  ),
                  Gap(responsive.setHeight(4)),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.star_fill,
                        color: const Color(0xffFF9633),
                        size: responsive.setWidth(16),
                      ),
                      Gap(responsive.setWidth(6)),
                      CustomText(
                        txt: '4.8',
                        fontWeight: FontWeight.w500,
                        fontSize: responsive.setFont(14),
                        color: AppColors.secondary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
