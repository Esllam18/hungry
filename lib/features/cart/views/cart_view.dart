import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/router/route_names.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/features/cart/views/widgets/cart_card.dart';
import 'package:hungry/features/home/persantaion/widgets/add_to_cart_and_total_price.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Stack(
          children: [
            /// Scrollable list of cart items
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.setWidth(16),
                    vertical: responsive.setHeight(20),
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding: EdgeInsets.only(
                          bottom: responsive.setHeight(16),
                        ),
                        child: CartCard(index: index),
                      ),
                      childCount: 10,
                    ),
                  ),
                ),

                /// Extra padding at the bottom (to avoid overlap with button)
                SliverToBoxAdapter(
                  child: SizedBox(height: responsive.setHeight(80)),
                ),
              ],
            ),

            /// Fixed button at the bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: AddToCartBtnAndTotalPrice(
                onPressed: () =>
                    GoRouter.of(context).push(RouteNames.checkoutView),

                text: 'Checkout',
                responsive: responsive,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
