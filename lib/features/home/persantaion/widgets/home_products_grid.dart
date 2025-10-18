import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_text.dart';
import 'package:hungry/features/home/data/models/product_model.dart';
import 'package:hungry/features/home/persantaion/cubit/product_cubit.dart';
import 'package:hungry/features/home/persantaion/widgets/food_card.dart';

class HomeProductsGrid extends StatelessWidget {
  final List<ProductModel> products;
  final Responsive responsive;

  const HomeProductsGrid({
    super.key,
    required this.products,
    required this.responsive,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.inbox_outlined,
                size: 64,
                color: AppColors.textSecondary,
              ),
              Gap(responsive.setHeight(16)),
              CustomText(
                txt: 'No products found',
                fontSize: responsive.setFont(18),
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: responsive.setWidth(20)),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: responsive.isMobile ? 2 : 3,
          mainAxisSpacing: responsive.setHeight(12),
          crossAxisSpacing: responsive.setWidth(12),
          childAspectRatio: 0.7,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final product = products[index];
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 400 + (index * 100)),
            curve: Curves.easeOutBack,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
              );
            },
            child: FoodCard(
              product: product,
              responsive: responsive,
              onFavoriteToggle: () {
                context.read<ProductCubit>().toggleFavorite(product.id);
              },
            ),
          );
        }, childCount: products.length),
      ),
    );
  }
}
