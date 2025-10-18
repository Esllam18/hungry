import 'package:flutter/material.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_text.dart';
import 'package:hungry/features/home/data/models/category_model.dart';

class CategoriesFiltertion extends StatelessWidget {
  final List<CategoryModel> categories;
  final int? selectedCategoryId;
  final Function(int?) onCategorySelected;

  const CategoriesFiltertion({
    super.key,
    required this.categories,
    this.selectedCategoryId,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    // Add "All" category at the beginning
    final allCategories = [CategoryModel(id: 0, name: 'All'), ...categories];

    return SizedBox(
      height: responsive.setHeight(45),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: allCategories.length,
        itemBuilder: (context, index) {
          final category = allCategories[index];

          // Check if this category is selected
          final isSelected =
              (category.id == 0 && selectedCategoryId == null) ||
              (category.id == selectedCategoryId);

          return Padding(
            padding: EdgeInsets.only(right: responsive.setWidth(10)),
            child: GestureDetector(
              onTap: () {
                // If "All" is clicked, pass null, otherwise pass category id
                final categoryIdToSelect = category.id == 0
                    ? null
                    : category.id;
                onCategorySelected(categoryIdToSelect);
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
                    txt: category.name,
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
