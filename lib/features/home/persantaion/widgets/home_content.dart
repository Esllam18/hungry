import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/features/home/data/models/category_model.dart';
import 'package:hungry/features/home/data/models/product_model.dart';
import 'package:hungry/features/home/persantaion/cubit/product_cubit.dart';

import 'package:hungry/features/home/persantaion/widgets/categories_filtertion.dart';
import 'package:hungry/features/home/persantaion/widgets/home_header_section.dart';
import 'package:hungry/features/home/persantaion/widgets/home_products_grid.dart';
import 'package:hungry/features/home/persantaion/widgets/home_search_section.dart';

class HomeContent extends StatelessWidget {
  final List<ProductModel> products;
  final List<CategoryModel> categories;
  final int? selectedCategoryId;
  final TextEditingController searchController;
  final ScrollController scrollController;
  final Animation<double> fadeAnimation;
  final Function(String) onSearchChanged;
  final Responsive responsive;

  const HomeContent({
    super.key,
    required this.products,
    required this.categories,
    this.selectedCategoryId,
    required this.searchController,
    required this.scrollController,
    required this.fadeAnimation,
    required this.onSearchChanged,
    required this.responsive,
  });

  Future<void> _onRefresh(BuildContext context) async {
    await context.read<ProductCubit>().refresh();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        color: AppColors.primary,
        child: CustomScrollView(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            HomeHeaderSection(responsive: responsive),

            HomeSearchSection(
              controller: searchController,
              onChanged: onSearchChanged,
              responsive: responsive,
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.setWidth(20),
                ),
                child: CategoriesFiltertion(
                  categories: categories,
                  selectedCategoryId: selectedCategoryId,
                  onCategorySelected: (categoryId) {
                    context.read<ProductCubit>().filterByCategory(categoryId);
                  },
                ),
              ),
            ),

            SliverToBoxAdapter(child: Gap(responsive.setHeight(20))),

            HomeProductsGrid(products: products, responsive: responsive),

            SliverToBoxAdapter(child: Gap(responsive.setHeight(20))),
          ],
        ),
      ),
    );
  }
}
