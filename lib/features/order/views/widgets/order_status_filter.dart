import 'package:flutter/material.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_text.dart';

class OrderStatusFilter extends StatelessWidget {
  final String selectedStatus;
  final Function(String) onStatusChanged;

  const OrderStatusFilter({
    super.key,
    required this.selectedStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final statuses = [
      'All',
      'Processing',
      'On the way',
      'Delivered',
      'Cancelled',
    ];

    return SizedBox(
      height: responsive.setHeight(45),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: statuses.length,
        itemBuilder: (context, index) {
          final status = statuses[index];
          final isSelected = selectedStatus == status;

          return Padding(
            padding: EdgeInsets.only(right: responsive.setWidth(10)),
            child: GestureDetector(
              onTap: () => onStatusChanged(status),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.setWidth(20),
                  vertical: responsive.setHeight(12),
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.white,
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
                child: Center(
                  child: CustomText(
                    txt: status,
                    fontSize: responsive.setFont(14),
                    fontWeight: FontWeight.w600,
                    color: isSelected ? AppColors.white : AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
