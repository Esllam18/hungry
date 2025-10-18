import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_snackbar.dart';
import 'package:hungry/features/home/data/models/product_model.dart';
import 'package:hungry/features/home/data/models/topping_model.dart';
import 'package:hungry/features/home/persantaion/cubit/product_cubit.dart';
import 'package:hungry/features/home/persantaion/widgets/add_to_cart_and_total_price.dart';
import 'package:hungry/features/home/persantaion/widgets/header_for_detaile.dart';
import 'package:hungry/features/home/persantaion/widgets/product_options_section.dart';

class ProductDetailsContent extends StatelessWidget {
  final ProductModel product;
  final Set<int> selectedToppings;
  final Set<int> selectedSideOptions;
  final double spicyLevel;
  final Function(int) onToppingToggle;
  final Function(int) onSideOptionToggle;
  final Function(double) onSpicyChanged;
  final Responsive responsive;
  final List<ToppingModel> toppings; // Added
  final List<SideOptionModel> sideOptions; // Added

  const ProductDetailsContent({
    super.key,
    required this.product,
    required this.selectedToppings,
    required this.selectedSideOptions,
    required this.spicyLevel,
    required this.onToppingToggle,
    required this.onSideOptionToggle,
    required this.onSpicyChanged,
    required this.responsive,
    required this.toppings,
    required this.sideOptions,
  });

  double _calculateTotal() {
    double total = product.price;
    for (var toppingId in selectedToppings) {
      final topping = toppings.firstWhere(
        (t) => t.id == toppingId,
        orElse: () => ToppingModel(id: 0, name: '', price: 0.0),
      );
      total += topping.price;
    }
    for (var optionId in selectedSideOptions) {
      final option = sideOptions.firstWhere(
        (o) => o.id == optionId,
        orElse: () => SideOptionModel(id: 0, name: '', price: 0.0),
      );
      total += option.price;
    }
    return total;
  }

  void _handleAddToCart(BuildContext context) {
    context.read<ProductCubit>().addToCart(
      product.id,
      selectedToppings.toList(),
      selectedSideOptions.toList(),
    );
    CustomSnackBar.show(
      context,
      message: 'Added to cart successfully!',
      type: SnackBarType.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            // Product Header
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(responsive.setWidth(20)),
                child: Column(
                  children: [
                    Gap(responsive.setHeight(10)),
                    HeaderForDetaile(
                      product: product,
                      spicyLevel: spicyLevel,
                      onSpicyChanged: onSpicyChanged,
                    ),
                    Gap(responsive.setHeight(30)),
                  ],
                ),
              ),
            ),

            // Product Options
            ProductOptionsSection(
              selectedToppings: selectedToppings,
              selectedSideOptions: selectedSideOptions,
              onToppingToggle: onToppingToggle,
              onSideOptionToggle: onSideOptionToggle,
              responsive: responsive,
              toppings: toppings, // Pass toppings
              sideOptions: sideOptions, // Pass side options
            ),

            SliverToBoxAdapter(child: Gap(responsive.setHeight(150))),
          ],
        ),

        // Add to Cart Button
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: AddToCartBtnAndTotalPrice(
            text: 'Add To Cart',
            responsive: responsive,
            totalPrice: _calculateTotal(),
            onPressed: () => _handleAddToCart(context),
          ),
        ),
      ],
    );
  }
}
