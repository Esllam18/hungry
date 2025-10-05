import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_text.dart';
import 'package:hungry/features/home/persantaion/widgets/add_to_cart_and_total_price.dart';
import 'package:hungry/features/home/persantaion/widgets/header_for_detaile.dart';
import 'package:hungry/features/home/persantaion/widgets/toppings_list_view.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          surfaceTintColor: AppColors.transparent,
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => GoRouter.of(context).pop(),
            child: Icon(
              Icons.arrow_back_ios_new_sharp,
              color: AppColors.black,
              size: responsive.setWidth(20),
            ),
          ),
        ),
        body: Stack(
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: CustomScrollView(
                    slivers: [
                      // Header Section
                      SliverToBoxAdapter(
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: Padding(
                            padding: EdgeInsets.all(responsive.setWidth(20)),
                            child: Column(
                              children: [
                                Gap(responsive.setHeight(10)),
                                CustomIzeOfDetaile(),
                                Gap(responsive.setHeight(30)),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Toppings Section
                      SliverToBoxAdapter(
                        child: SlideTransition(
                          position:
                              Tween<Offset>(
                                begin: const Offset(0, 0.3),
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: _animationController,
                                  curve: const Interval(
                                    0.3,
                                    1.0,
                                    curve: Curves.easeOut,
                                  ),
                                ),
                              ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: responsive.setWidth(20),
                            ),
                            child: CustomText(
                              txt: 'Toppings',
                              fontSize: responsive.setFont(18),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      SliverToBoxAdapter(child: Gap(responsive.setHeight(20))),

                      SliverToBoxAdapter(
                        child: SlideTransition(
                          position:
                              Tween<Offset>(
                                begin: const Offset(0, 0.3),
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: _animationController,
                                  curve: const Interval(
                                    0.4,
                                    1.0,
                                    curve: Curves.easeOut,
                                  ),
                                ),
                              ),
                          child: ToppingsListView(),
                        ),
                      ),

                      SliverToBoxAdapter(child: Gap(responsive.setHeight(20))),

                      // Side Options Section
                      SliverToBoxAdapter(
                        child: SlideTransition(
                          position:
                              Tween<Offset>(
                                begin: const Offset(0, 0.3),
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: _animationController,
                                  curve: const Interval(
                                    0.5,
                                    1.0,
                                    curve: Curves.easeOut,
                                  ),
                                ),
                              ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: responsive.setWidth(20),
                            ),
                            child: CustomText(
                              txt: 'Side options',
                              fontSize: responsive.setFont(18),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      SliverToBoxAdapter(child: Gap(responsive.setHeight(20))),

                      SliverToBoxAdapter(
                        child: SlideTransition(
                          position:
                              Tween<Offset>(
                                begin: const Offset(0, 0.3),
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: _animationController,
                                  curve: const Interval(
                                    0.6,
                                    1.0,
                                    curve: Curves.easeOut,
                                  ),
                                ),
                              ),
                          child: SideOptionsListView(),
                        ),
                      ),

                      SliverToBoxAdapter(child: Gap(responsive.setHeight(150))),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              left: responsive.setWidth(0),
              right: responsive.setWidth(0),
              bottom: responsive.setHeight(0),

              child: AddToCartBtnAndTotalPrice(
                text: 'Add To Cart',
                responsive: responsive,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
