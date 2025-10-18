import 'package:flutter/material.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';

class SkeletonLoading extends StatefulWidget {
  final double? width;
  final double? height;
  final double borderRadius;

  const SkeletonLoading({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 8,
  });

  @override
  State<SkeletonLoading> createState() => _SkeletonLoadingState();
}

class _SkeletonLoadingState extends State<SkeletonLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.mediumGrey.withOpacity(0.3),
                AppColors.mediumGrey.withOpacity(0.1),
                AppColors.mediumGrey.withOpacity(0.3),
              ],
              stops: [
                _animation.value - 0.3,
                _animation.value,
                _animation.value + 0.3,
              ].map((e) => e.clamp(0.0, 1.0)).toList(),
            ),
          ),
        );
      },
    );
  }
}

// Skeleton for Product Card
class ProductCardSkeleton extends StatelessWidget {
  final Responsive responsive;

  const ProductCardSkeleton({super.key, required this.responsive});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Padding(
        padding: EdgeInsets.all(responsive.setWidth(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image skeleton
            Expanded(
              child: Center(
                child: SkeletonLoading(
                  width: responsive.setWidth(120),
                  height: responsive.setHeight(120),
                  borderRadius: responsive.setWidth(12),
                ),
              ),
            ),
            SizedBox(height: responsive.setHeight(10)),
            // Name skeleton
            SkeletonLoading(
              width: double.infinity,
              height: responsive.setHeight(16),
              borderRadius: responsive.setWidth(4),
            ),
            SizedBox(height: responsive.setHeight(6)),
            // Description skeleton
            SkeletonLoading(
              width: responsive.setWidth(100),
              height: responsive.setHeight(14),
              borderRadius: responsive.setWidth(4),
            ),
            SizedBox(height: responsive.setHeight(8)),
            // Price skeleton
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SkeletonLoading(
                  width: responsive.setWidth(50),
                  height: responsive.setHeight(16),
                  borderRadius: responsive.setWidth(4),
                ),
                SkeletonLoading(
                  width: responsive.setWidth(60),
                  height: responsive.setHeight(20),
                  borderRadius: responsive.setWidth(4),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Skeleton for Cart Card
class CartCardSkeleton extends StatelessWidget {
  final Responsive responsive;

  const CartCardSkeleton({super.key, required this.responsive});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: responsive.setHeight(190),
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
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(responsive.setWidth(12)),
            child: Column(
              children: [
                SkeletonLoading(
                  width: responsive.setWidth(111),
                  height: responsive.setHeight(102),
                  borderRadius: responsive.setWidth(12),
                ),
                SizedBox(height: responsive.setHeight(10)),
                SkeletonLoading(
                  width: responsive.setWidth(100),
                  height: responsive.setHeight(16),
                  borderRadius: responsive.setWidth(4),
                ),
                SizedBox(height: responsive.setHeight(4)),
                SkeletonLoading(
                  width: responsive.setWidth(80),
                  height: responsive.setHeight(14),
                  borderRadius: responsive.setWidth(4),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(responsive.setWidth(12)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SkeletonLoading(
                    width: double.infinity,
                    height: responsive.setHeight(43),
                    borderRadius: responsive.setWidth(12),
                  ),
                  SkeletonLoading(
                    width: double.infinity,
                    height: responsive.setHeight(43),
                    borderRadius: responsive.setWidth(12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
