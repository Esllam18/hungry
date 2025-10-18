// Fixed food_topping_card.dart - No changes needed.
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/consts/app_colors.dart';

class FoodToppingCard extends StatefulWidget {
  final String image;
  final String name;
  final bool isSelected;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final double heightForWhiteCon;
  final double imageWidth;
  final double imageHeight;

  const FoodToppingCard({
    super.key,
    required this.image,
    required this.name,
    this.isSelected = false,
    this.onTap,
    this.width = 100,
    this.height = 120,
    required this.heightForWhiteCon,
    required this.imageWidth,
    required this.imageHeight,
  });

  @override
  State<FoodToppingCard> createState() => _FoodToppingCardState();
}

class _FoodToppingCardState extends State<FoodToppingCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward().then((_) {
      _controller.reverse();
      widget.onTap?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.width.w,
          height: widget.height.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                color: widget.isSelected
                    ? Colors.green.withOpacity(0.3)
                    : Colors.black.withOpacity(0.1),
                blurRadius: widget.isSelected ? 10 : 6,
                offset: Offset(0, widget.isSelected ? 4 : 3),
              ),
            ],
            color: AppColors.primary,
            border: Border.all(
              color: widget.isSelected ? Colors.green : Colors.transparent,
              width: 2,
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -2,
                left: -2,
                right: -2,
                child: Container(
                  height: (widget.height * widget.heightForWhiteCon).h,
                  width: widget.width.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.r),
                      topRight: Radius.circular(15.r),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                  ),
                  child: Center(
                    child: Image.network(
                      widget.image,
                      width: widget.imageWidth.w,
                      height: widget.imageHeight.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 12.h,
                left: 8.w,
                right: 8.w,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Gap(4.w),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: widget.isSelected ? Colors.green : Colors.red,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        widget.isSelected ? Icons.check : Icons.add,
                        color: Colors.white,
                        size: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
