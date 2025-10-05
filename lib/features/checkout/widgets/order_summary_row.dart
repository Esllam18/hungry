import 'package:flutter/material.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_text.dart';

class OrderSummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? textColor;

  const OrderSummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: responsive.setHeight(6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            txt: label,
            fontSize: responsive.setFont(isBold ? 18 : 16),
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
            color: textColor ?? AppColors.textSecondary,
          ),
          CustomText(
            txt: value,
            fontSize: responsive.setFont(isBold ? 18 : 16),
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: textColor ?? AppColors.textPrimary,
          ),
        ],
      ),
    );
  }
}
