// lib/features/home/presentation/widgets/product_details_loading.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/skeleton_loading.dart';

class ProductDetailsLoading extends StatelessWidget {
  const ProductDetailsLoading({super.key, required this.responsive});

  final Responsive responsive;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(responsive.setWidth(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image Placeholder
                SkeletonLoading(
                  width: double.infinity,
                  height: responsive.setHeight(200),
                  borderRadius: 16,
                ),
                Gap(responsive.setHeight(20)),
                // Product Title Placeholder
                SkeletonLoading(
                  width: responsive.setWidth(200),
                  height: responsive.setHeight(24),
                  borderRadius: 8,
                ),
                Gap(responsive.setHeight(10)),
                // Product Description Placeholder
                SkeletonLoading(
                  width: double.infinity,
                  height: responsive.setHeight(60),
                  borderRadius: 8,
                ),
                Gap(responsive.setHeight(20)),
                // Toppings Section Placeholder
                SkeletonLoading(
                  width: responsive.setWidth(150),
                  height: responsive.setHeight(20),
                  borderRadius: 8,
                ),
                Gap(responsive.setHeight(10)),
                // Toppings List Placeholder (Horizontal)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      4,
                      (index) => Padding(
                        padding: EdgeInsets.only(
                          right: responsive.setWidth(12),
                        ),
                        child: SkeletonLoading(
                          width: responsive.setWidth(80),
                          height: responsive.setHeight(40),
                          borderRadius: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                Gap(responsive.setHeight(20)),
                // Side Options Section Placeholder
                SkeletonLoading(
                  width: responsive.setWidth(150),
                  height: responsive.setHeight(20),
                  borderRadius: 8,
                ),
                Gap(responsive.setHeight(10)),
                // Side Options List Placeholder (Horizontal)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      3,
                      (index) => Padding(
                        padding: EdgeInsets.only(
                          right: responsive.setWidth(12),
                        ),
                        child: SkeletonLoading(
                          width: responsive.setWidth(80),
                          height: responsive.setHeight(40),
                          borderRadius: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                Gap(responsive.setHeight(20)),
                // Spicy Level Slider Placeholder
                SkeletonLoading(
                  width: double.infinity,
                  height: responsive.setHeight(20),
                  borderRadius: 8,
                ),
                Gap(responsive.setHeight(20)),
                // Action Button Placeholder
                SkeletonLoading(
                  width: double.infinity,
                  height: responsive.setHeight(50),
                  borderRadius: 25,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
