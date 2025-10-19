import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/skeleton_loading.dart';

class ProfileLoading extends StatelessWidget {
  const ProfileLoading({super.key, required this.responsive});
  final Responsive responsive;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(responsive.setWidth(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(responsive.setHeight(20)),
                SkeletonLoading(
                  width: responsive.setWidth(120),
                  height: responsive.setHeight(120),
                  borderRadius: 20,
                ),
                Gap(responsive.setHeight(20)),
                SkeletonLoading(
                  width: responsive.setWidth(150),
                  height: responsive.setHeight(30),
                  borderRadius: 8,
                ),
                Gap(responsive.setHeight(40)),
                SkeletonLoading(
                  width: double.infinity,
                  height: responsive.setHeight(50),
                  borderRadius: 16,
                ),
                Gap(responsive.setHeight(20)),
                SkeletonLoading(
                  width: double.infinity,
                  height: responsive.setHeight(50),
                  borderRadius: 16,
                ),
                Gap(responsive.setHeight(20)),
                SkeletonLoading(
                  width: double.infinity,
                  height: responsive.setHeight(50),
                  borderRadius: 16,
                ),
                Gap(responsive.setHeight(40)),
                SkeletonLoading(
                  width: double.infinity,
                  height: responsive.setHeight(100),
                  borderRadius: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
