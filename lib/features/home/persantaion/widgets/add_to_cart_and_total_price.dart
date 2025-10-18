import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_text.dart';

class AddToCartBtnAndTotalPrice extends StatefulWidget {
  final Responsive responsive;
  final String text;
  final double? totalPrice;
  final VoidCallback? onPressed;

  const AddToCartBtnAndTotalPrice({
    super.key,
    required this.responsive,
    required this.text,
    this.totalPrice,
    this.onPressed,
  });

  @override
  State<AddToCartBtnAndTotalPrice> createState() =>
      _AddToCartBtnAndTotalPriceState();
}

class _AddToCartBtnAndTotalPriceState extends State<AddToCartBtnAndTotalPrice>
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

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onPressed?.call();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.responsive.setHeight(110),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.white, AppColors.white.withOpacity(0.95)],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(widget.responsive.setWidth(24)),
          topRight: Radius.circular(widget.responsive.setWidth(24)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 20,
            offset: const Offset(0, -4),
            spreadRadius: 2,
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widget.responsive.setWidth(20),
            vertical: widget.responsive.setHeight(12),
          ),
          child: Row(
            children: [
              // Total Price Section
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      txt: 'Total Price',
                      fontSize: widget.responsive.setFont(13),
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                    Gap(widget.responsive.setHeight(4)),
                    Row(
                      children: [
                        CustomText(
                          txt: '\$',
                          fontSize: widget.responsive.setFont(18),
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                        Gap(widget.responsive.setWidth(2)),
                        CustomText(
                          txt: (widget.totalPrice ?? 0.0).toStringAsFixed(2),
                          fontSize: widget.responsive.setFont(26),
                          fontWeight: FontWeight.w900,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Add to Cart Button
              GestureDetector(
                onTapDown: _handleTapDown,
                onTapUp: _handleTapUp,
                onTapCancel: _handleTapCancel,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.responsive.setWidth(32),
                      vertical: widget.responsive.setHeight(16),
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.primary.withOpacity(0.85),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(
                        widget.responsive.setWidth(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          color: AppColors.white,
                          size: widget.responsive.setWidth(20),
                        ),
                        Gap(widget.responsive.setWidth(8)),
                        CustomText(
                          txt: widget.text,
                          fontSize: widget.responsive.setFont(17),
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
