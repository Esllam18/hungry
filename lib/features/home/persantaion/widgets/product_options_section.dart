import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_text.dart';
import 'package:hungry/features/home/data/models/topping_model.dart';

import 'package:hungry/features/home/persantaion/widgets/toppings_list_view.dart';

class ProductOptionsSection extends StatelessWidget {
  final Set<int> selectedToppings;
  final Set<int> selectedSideOptions;
  final Function(int) onToppingToggle;
  final Function(int) onSideOptionToggle;
  final Responsive responsive;
  final List<ToppingModel> toppings;
  final List<SideOptionModel> sideOptions;

  const ProductOptionsSection({
    super.key,
    required this.selectedToppings,
    required this.selectedSideOptions,
    required this.onToppingToggle,
    required this.onSideOptionToggle,
    required this.responsive,
    required this.toppings,
    required this.sideOptions,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Toppings Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: responsive.setWidth(20)),
            child: CustomText(
              txt: 'Toppings',
              fontSize: responsive.setFont(18),
              fontWeight: FontWeight.w600,
            ),
          ),

          Gap(responsive.setHeight(20)),

          // Toppings List
          toppings.isEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.setWidth(20),
                  ),
                  child: CustomText(
                    txt: 'No toppings available',
                    fontSize: responsive.setFont(14),
                    color: AppColors.textSecondary,
                  ),
                )
              : ToppingsListView(
                  toppings: toppings,
                  selectedToppings: selectedToppings,
                  onToppingToggle: onToppingToggle,
                ),

          Gap(responsive.setHeight(20)),

          // Side Options Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: responsive.setWidth(20)),
            child: CustomText(
              txt: 'Side options',
              fontSize: responsive.setFont(18),
              fontWeight: FontWeight.w600,
            ),
          ),

          Gap(responsive.setHeight(20)),

          // Side Options List
          sideOptions.isEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.setWidth(20),
                  ),
                  child: CustomText(
                    txt: 'No side options available',
                    fontSize: responsive.setFont(14),
                    color: AppColors.textSecondary,
                  ),
                )
              : SideOptionsListView(
                  sideOptions: sideOptions,
                  selectedSideOptions: selectedSideOptions,
                  onSideOptionToggle: onSideOptionToggle,
                ),
        ],
      ),
    );
  }
}
