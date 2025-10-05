import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_text.dart';
import 'package:hungry/features/order/views/widgets/order_card.dart';
import 'package:hungry/features/order/views/widgets/order_status_filter.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  String selectedStatus = 'All';

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _controller.forward();
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

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          centerTitle: true,
          title: CustomText(
            txt: 'Order History',
            fontSize: responsive.setFont(20),
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: Gap(responsive.setHeight(16))),

              // Status Filter
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.setWidth(20),
                  ),
                  child: OrderStatusFilter(
                    selectedStatus: selectedStatus,
                    onStatusChanged: (status) {
                      setState(() {
                        selectedStatus = status;
                      });
                    },
                  ),
                ),
              ),

              SliverToBoxAdapter(child: Gap(responsive.setHeight(20))),

              // Orders List
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.setWidth(20),
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: EdgeInsets.only(
                        bottom: responsive.setHeight(16),
                      ),
                      child: OrderCard(index: index, responsive: responsive),
                    ),
                    childCount: 8,
                  ),
                ),
              ),

              SliverToBoxAdapter(child: Gap(responsive.setHeight(20))),
            ],
          ),
        ),
      ),
    );
  }
}
