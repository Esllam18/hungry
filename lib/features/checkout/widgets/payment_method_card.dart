import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_text.dart';

class PaymentMethodCard extends StatelessWidget {
  final Responsive responsive;
  final String title;
  final String? subtitle;
  final Widget icon;
  final bool isSelected;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isProfile;

  const PaymentMethodCard({
    super.key,

    required this.responsive,
    required this.title,

    this.subtitle,
    required this.icon,
    required this.isSelected,
    this.onTap,
    this.backgroundColor,
    this.textColor,
    this.isProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(responsive.setWidth(16)),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.white,
          borderRadius: BorderRadius.circular(responsive.setWidth(16)),
          border: Border.all(
            color: isSelected
                ? AppColors.white
                : AppColors.mediumGrey.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            icon,
            Gap(responsive.setWidth(16)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    txt: title,
                    fontSize: responsive.setFont(16),
                    fontWeight: FontWeight.w600,
                    color: textColor ?? AppColors.textPrimary,
                  ),
                  if (subtitle != null) ...[
                    Gap(responsive.setHeight(4)),
                    CustomText(
                      txt: subtitle!,
                      fontSize: responsive.setFont(14),
                      color:
                          textColor?.withOpacity(0.8) ??
                          AppColors.textSecondary,
                    ),
                  ],
                ],
              ),
            ),

            isProfile
                ? CustomText(
                    txt: 'defult',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  )
                : Container(
                    width: responsive.setWidth(24),
                    height: responsive.setHeight(24),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: textColor ?? AppColors.primary,
                        width: 2,
                      ),
                      color: isSelected
                          ? (textColor ?? AppColors.primary)
                          : AppColors.transparent,
                    ),
                    child: isProfile
                        ? CustomText(txt: 'data')
                        : isSelected
                        ? Icon(
                            Icons.album_sharp,
                            size: responsive.setWidth(16),
                            color: backgroundColor ?? AppColors.white,
                          )
                        : null,
                  ),
          ],
        ),
      ),
    );
  }
}
