import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_text.dart';
import 'package:hungry/features/checkout/widgets/order_summary_row.dart';

class OrderSummarySection extends StatelessWidget {
  const OrderSummarySection({super.key, required this.responsive});

  final Responsive responsive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(responsive.setWidth(16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(responsive.setWidth(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          OrderSummaryRow(label: 'Order', value: '\$16.48'),
          OrderSummaryRow(label: 'Taxes', value: '\$0.30'),
          OrderSummaryRow(label: 'Delivery fees', value: '\$1.50'),

          Gap(responsive.setHeight(12)),

          Divider(thickness: 1, color: AppColors.mediumGrey.withOpacity(0.2)),

          Gap(responsive.setHeight(12)),

          OrderSummaryRow(
            label: 'Total',
            value: '\$18.28',
            isBold: true,
            textColor: AppColors.secondary,
          ),

          Gap(responsive.setHeight(16)),

          Container(
            padding: EdgeInsets.all(responsive.setWidth(12)),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(responsive.setWidth(12)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: responsive.setWidth(20),
                  color: AppColors.primary,
                ),
                Gap(responsive.setWidth(8)),
                CustomText(
                  txt: 'Estimated delivery: ',
                  fontSize: responsive.setFont(14),
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
                CustomText(
                  txt: '15 - 30 mins',
                  fontSize: responsive.setFont(14),
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
