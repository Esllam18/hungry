import 'package:flutter/material.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_text.dart';
import 'package:hungry/features/home/data/datasources/remote_datasources.dart';

class FilterationShipsChoise extends StatefulWidget {
  const FilterationShipsChoise({super.key});

  @override
  State<FilterationShipsChoise> createState() => _FilterationShipsChoiseState();
}

class _FilterationShipsChoiseState extends State<FilterationShipsChoise> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return SizedBox(
      height: responsive.setHeight(45),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = index == selectedIndex;

          return Padding(
            padding: EdgeInsets.only(right: responsive.setWidth(10)),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
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
                    txt: category,
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
