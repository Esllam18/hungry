import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/consts/app_assets.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_text.dart';

class CartCard extends StatefulWidget {
  final int index;

  const CartCard({super.key, required this.index});

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    // FIXED: Safe staggered animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Future.delayed(Duration(milliseconds: widget.index * 100), () {
          if (mounted) {
            _controller.forward();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return AnimatedBuilder(
      animation: _opacityAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(responsive.setWidth(15)),
            child: Container(
              height: responsive.setHeight(190),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(responsive.setWidth(15)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(responsive.setWidth(8)),
                    child: Column(
                      children: [
                        Image.asset(
                          AppImages.imageTest,
                          width: responsive.setWidth(111),
                          height: responsive.setHeight(102.18),
                          fit: BoxFit.contain,
                          frameBuilder:
                              (context, child, frame, wasSynchronouslyLoaded) {
                                return child;
                              },
                        ),
                        Gap(responsive.setHeight(10)),
                        CustomText(
                          txt: 'Hamburger',
                          fontWeight: FontWeight.w600,
                          fontSize: responsive.setFont(16),
                          color: AppColors.black,
                        ),
                        CustomText(
                          txt: 'Veggie Burger',
                          fontWeight: FontWeight.w400,
                          fontSize: responsive.setFont(14),
                          color: AppColors.textSecondary,
                        ),
                        Gap(responsive.setHeight(10)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(responsive.setWidth(12)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: responsive.setWidth(40),
                                height: responsive.setHeight(43),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(
                                    responsive.setWidth(12),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (quantity > 1) quantity--;
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      bottom: responsive.setHeight(10),
                                    ),
                                    child: Icon(
                                      Icons.minimize,
                                      color: Colors.white,
                                      size: responsive.setWidth(20),
                                    ),
                                  ),
                                ),
                              ),
                              Gap(responsive.setWidth(30)),
                              CustomText(
                                txt: '$quantity',
                                fontWeight: FontWeight.w600,
                                fontSize: responsive.setFont(16),
                                color: AppColors.black,
                              ),
                              Gap(responsive.setWidth(30)),
                              Container(
                                width: responsive.setWidth(40),
                                height: responsive.setHeight(43),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(
                                    responsive.setWidth(12),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      quantity++;
                                    });
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: responsive.setWidth(20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(responsive.setHeight(40)),
                        ElevatedButton(
                          onPressed: () {
                            // Handle remove from cart action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: EdgeInsets.symmetric(
                              horizontal: responsive.setWidth(30),
                              vertical: responsive.setHeight(14),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                responsive.setWidth(12),
                              ),
                            ),
                          ),
                          child: CustomText(
                            txt: '  Remove  ',
                            fontSize: responsive.setFont(18),
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
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
      },
    );
  }
}
