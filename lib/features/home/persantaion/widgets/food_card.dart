import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/router/route_names.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_text.dart';
import 'package:hungry/features/home/data/models/product_model.dart';

class FoodCard extends StatelessWidget {
  final ProductModel product;
  final Responsive responsive;
  final VoidCallback onFavoriteToggle;

  const FoodCard({
    super.key,
    required this.product,
    required this.responsive,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to product details with product ID
        GoRouter.of(context).push(RouteNames.productDetails, extra: product.id);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(responsive.setWidth(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(responsive.setWidth(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  Expanded(
                    child: Center(
                      child: Hero(
                        tag: 'product_${product.id}',
                        child: product.image != null
                            ? Image.network(
                                product.image!,
                                width: responsive.setWidth(120),
                                height: responsive.setHeight(120),
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.fastfood,
                                    size: responsive.setWidth(60),
                                    color: AppColors.mediumGrey,
                                  );
                                },
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return SizedBox(
                                        width: responsive.setWidth(120),
                                        height: responsive.setHeight(120),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: AppColors.primary,
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      );
                                    },
                              )
                            : Icon(
                                Icons.fastfood,
                                size: responsive.setWidth(60),
                                color: AppColors.mediumGrey,
                              ),
                      ),
                    ),
                  ),

                  Gap(responsive.setHeight(10)),

                  // Product Name
                  CustomText(
                    txt: product.name,
                    fontWeight: FontWeight.w600,
                    fontSize: responsive.setFont(14),
                    color: AppColors.textPrimary,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Product Description
                  CustomText(
                    txt: product.description,
                    fontWeight: FontWeight.w400,
                    fontSize: responsive.setFont(12),
                    color: AppColors.textSecondary,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Gap(responsive.setHeight(8)),

                  // Rating and Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (product.rating != null)
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.star_fill,
                              color: const Color(0xffFF9633),
                              size: responsive.setWidth(14),
                            ),
                            Gap(responsive.setWidth(4)),
                            CustomText(
                              txt: product.rating!.toStringAsFixed(1),
                              fontWeight: FontWeight.w500,
                              fontSize: responsive.setFont(12),
                              color: AppColors.textSecondary,
                            ),
                          ],
                        ),
                      CustomText(
                        txt: '\$${product.price.toStringAsFixed(2)}',
                        fontWeight: FontWeight.w700,
                        fontSize: responsive.setFont(16),
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Favorite Button
            Positioned(
              top: responsive.setHeight(8),
              right: responsive.setWidth(8),
              child: GestureDetector(
                onTap: onFavoriteToggle,
                child: Container(
                  padding: EdgeInsets.all(responsive.setWidth(6)),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    product.isFavorite
                        ? CupertinoIcons.heart_fill
                        : CupertinoIcons.heart,
                    color: product.isFavorite
                        ? Colors.red
                        : AppColors.textSecondary,
                    size: responsive.setWidth(18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
