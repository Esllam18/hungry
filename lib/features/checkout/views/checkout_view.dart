import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_text.dart';
import 'package:hungry/features/checkout/widgets/dialog_scauss.dart';
import 'package:hungry/features/checkout/widgets/order_summary_section.dart';
import 'package:hungry/features/checkout/widgets/payment_methods_section.dart';
import 'package:hungry/features/home/persantaion/widgets/add_to_cart_and_total_price.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late AnimationController _checkboxController;
  late Animation<double> _checkboxScaleAnimation;
  String selectedPayment = 'cash';
  bool checked = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _checkboxController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _checkboxScaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _checkboxController, curve: Curves.easeInOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _checkboxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          centerTitle: true,
          title: CustomText(
            txt: 'Checkout',
            fontSize: responsive.setFont(20),
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          leading: GestureDetector(
            onTap: () => GoRouter.of(context).pop(),
            child: Icon(
              Icons.arrow_back_ios,
              size: responsive.setWidth(20),
              color: AppColors.textPrimary,
            ),
          ),
        ),
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.all(responsive.setWidth(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order Summary Section
                    CustomText(
                      txt: 'Order summary',
                      fontSize: responsive.setFont(20),
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary,
                    ),

                    Gap(responsive.setHeight(16)),

                    OrderSummarySection(responsive: responsive),

                    Gap(responsive.setHeight(32)),

                    // Payment Methods Section
                    CustomText(
                      txt: 'Payment methods',
                      fontSize: responsive.setFont(20),
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary,
                    ),

                    Gap(responsive.setHeight(16)),

                    PaymentMethodsSection(),

                    // Save card details checker
                    saveCardDetailsChecker(responsive),

                    Gap(responsive.setHeight(150)),
                  ],
                ),
              ),
              Positioned(
                left: responsive.setWidth(0),
                right: responsive.setWidth(0),
                bottom: responsive.setHeight(0),
                child: AddToCartBtnAndTotalPrice(
                  text: 'Pay Now',
                  responsive: responsive,
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => DialogScauss(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector saveCardDetailsChecker(Responsive responsive) {
    return GestureDetector(
      onTapDown: (_) => _checkboxController.forward(),
      onTapUp: (_) {
        _checkboxController.reverse();
        setState(() {
          checked = !checked;
        });
      },
      onTapCancel: () => _checkboxController.reverse(),
      child: Row(
        children: [
          ScaleTransition(
            scale: _checkboxScaleAnimation,
            child: Icon(
              checked ? Icons.check_box_rounded : Icons.check_box_outline_blank,
              color: AppColors.primary,
              size: responsive.setWidth(24),
            ),
          ),
          Gap(responsive.setWidth(8)),
          CustomText(
            txt: 'Save card details for future payments',
            fontWeight: FontWeight.w500,
            fontSize: responsive.setFont(16),
            color: AppColors.textPrimary,
          ),
        ],
      ),
    );
  }
}
