// header_for_detaile.dart (fixed path typo, renamed class to HeaderForDetaile for consistency)
import 'package:flutter/material.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_text.dart';
import 'package:hungry/features/home/data/models/product_model.dart';
import 'package:hungry/features/home/persantaion/widgets/custom_slider.dart';

class HeaderForDetaile extends StatelessWidget {
  final ProductModel product;
  final double spicyLevel;
  final ValueChanged<double>? onSpicyChanged;

  const HeaderForDetaile({
    super.key,
    required this.product,
    this.spicyLevel = 0.5,
    this.onSpicyChanged,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Image
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: 'product_${product.id}',
            child: product.image != null
                ? Image.network(
                    product.image!,
                    width: responsive.setWidth(150),
                    height: responsive.setHeight(220),
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.fastfood,
                        size: responsive.setWidth(100),
                        color: AppColors.mediumGrey,
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        width: responsive.setWidth(150),
                        height: responsive.setHeight(220),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                      );
                    },
                  )
                : Icon(
                    Icons.fastfood,
                    size: responsive.setWidth(100),
                    color: AppColors.mediumGrey,
                  ),
          ),
        ),

        SizedBox(width: responsive.setWidth(12)),

        // Product Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: responsive.setHeight(20)),

              // Product Name
              CustomText(
                txt: product.name,
                fontSize: responsive.setFont(24),
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),

              SizedBox(height: responsive.setHeight(8)),

              // Product Description
              CustomText(
                txt: product.description,
                fontSize: responsive.setFont(14),
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: responsive.setHeight(16)),

              // Price
              Row(
                children: [
                  CustomText(
                    txt: '\$',
                    fontSize: responsive.setFont(18),
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                  CustomText(
                    txt: product.price.toStringAsFixed(2),
                    fontSize: responsive.setFont(24),
                    fontWeight: FontWeight.w900,
                    color: AppColors.primary,
                  ),
                ],
              ),

              SizedBox(height: responsive.setHeight(16)),

              // Spicy Level Label
              CustomText(
                txt: 'Spicy Level',
                fontSize: responsive.setFont(14),
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),

              SizedBox(height: responsive.setHeight(8)),

              // Spicy Slider
              CustomSlider(
                min: 0,
                max: 10,
                divisions: 10,
                initialValue: spicyLevel * 10,
                activeColor: AppColors.primary,
                inactiveColor: Colors.grey.shade400,
                onChanged: (val) {
                  onSpicyChanged?.call(val / 10);
                },
              ),

              SizedBox(height: responsive.setHeight(8)),

              // Spicy Icons
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.setWidth(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      txt: '❄️',
                      fontSize: responsive.setFont(20),
                      fontWeight: FontWeight.w500,
                    ),
                    CustomText(
                      txt: '🌶️',
                      fontSize: responsive.setFont(20),
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
