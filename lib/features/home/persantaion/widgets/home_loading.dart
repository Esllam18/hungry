// lib/features/home/presentation/widgets/home_loading.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/skeleton_loading.dart';

class HomeLoading extends StatelessWidget {
  const HomeLoading({super.key, required this.responsive});

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
                // HOME HEADER PLACEHOLDER
                SkeletonLoading(
                  width: double.infinity,
                  height: responsive.setHeight(40),
                  borderRadius: 8,
                ),
                Gap(responsive.setHeight(20)),

                // 🔍 Search Bar Placeholder
                SkeletonLoading(
                  width: double.infinity,
                  height: responsive.setHeight(50),
                  borderRadius: 25,
                ),
                Gap(responsive.setHeight(20)),

                // 🏷️ Category List Placeholder
                _buildCategorySkeleton(),

                Gap(responsive.setHeight(20)),

                // 🛒 First Product List Placeholder
                _buildProductSkeletonList(),

                Gap(responsive.setHeight(30)),

                // 🧃 Second Product List Placeholder
                _buildProductSkeletonList(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // 🔹 Category skeleton
  Widget _buildCategorySkeleton() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          5,
          (index) => Padding(
            padding: EdgeInsets.only(right: responsive.setWidth(12)),
            child: SkeletonLoading(
              width: responsive.setWidth(100),
              height: responsive.setHeight(40),
              borderRadius: 20,
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Product skeleton list
  Widget _buildProductSkeletonList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          3,
          (index) => Padding(
            padding: EdgeInsets.only(right: responsive.setWidth(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLoading(
                  width: responsive.setWidth(160),
                  height: responsive.setHeight(147),
                  borderRadius: 10,
                ),
                Gap(responsive.setHeight(20)),
                SkeletonLoading(
                  width: responsive.setWidth(120),
                  height: responsive.setHeight(16),
                  borderRadius: 4,
                ),
                Gap(responsive.setHeight(10)),
                SkeletonLoading(
                  width: responsive.setWidth(80),
                  height: responsive.setHeight(14),
                  borderRadius: 4,
                ),
                Gap(responsive.setHeight(10)),
                SkeletonLoading(
                  width: responsive.setWidth(60),
                  height: responsive.setHeight(16),
                  borderRadius: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
