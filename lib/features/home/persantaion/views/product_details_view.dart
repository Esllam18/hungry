import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_snackbar.dart';
import 'package:hungry/features/home/persantaion/cubit/product_cubit.dart';
import 'package:hungry/features/home/persantaion/cubit/product_state.dart';
import 'package:hungry/features/home/persantaion/widgets/product_details_content.dart';
import 'package:hungry/features/home/persantaion/widgets/product_details_error.dart';
import 'package:hungry/features/home/persantaion/widgets/product_details_loading.dart';

class ProductDetailsView extends StatefulWidget {
  final String productId;

  const ProductDetailsView({super.key, required this.productId});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  Set<int> selectedToppings = {};
  Set<int> selectedSideOptions = {};
  double spicyLevel = 0.5;

  @override
  void initState() {
    super.initState();
    _loadProductData();
  }

  void _loadProductData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productId = int.tryParse(widget.productId);
      if (productId != null) {
        context.read<ProductCubit>().getProductDetails(productId);
      }
    });
  }

  void _toggleTopping(int id) {
    setState(() {
      if (selectedToppings.contains(id)) {
        selectedToppings.remove(id);
      } else {
        selectedToppings.add(id);
      }
    });
  }

  void _toggleSideOption(int id) {
    setState(() {
      if (selectedSideOptions.contains(id)) {
        selectedSideOptions.remove(id);
      } else {
        selectedSideOptions.add(id);
      }
    });
  }

  void _updateSpicyLevel(double value) {
    setState(() {
      spicyLevel = value;
    });
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
        body: BlocConsumer<ProductCubit, ProductState>(
          listener: (context, state) {
            if (state is ProductError) {
              CustomSnackBar.show(
                context,
                message: state.message,
                type: SnackBarType.error,
              );
            } else if (state is ProductDetailsLoaded) {
              if (state.toppings.isNotEmpty || state.sideOptions.isNotEmpty) {
                CustomSnackBar.show(
                  context,
                  message: 'Options loaded successfully!',
                  type: SnackBarType.success,
                );
              }
            }
          },
          builder: (context, state) {
            if (state is ProductLoading) {
              return Center(
                child: ProductDetailsLoading(responsive: responsive),
              );
            }

            if (state is! ProductDetailsLoaded) {
              return ProductDetailsError(responsive: responsive);
            }

            return ProductDetailsContent(
              product: state.product,
              selectedToppings: selectedToppings,
              selectedSideOptions: selectedSideOptions,
              spicyLevel: spicyLevel,
              onToppingToggle: _toggleTopping,
              onSideOptionToggle: _toggleSideOption,
              onSpicyChanged: _updateSpicyLevel,
              responsive: responsive,
              toppings: state.toppings, // Pass toppings
              sideOptions: state.sideOptions, // Pass side options
            );
          },
        ),
      ),
    );
  }
}
