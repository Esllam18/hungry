import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/consts/app_assets.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_text.dart';

class OrderCard extends StatefulWidget {
  final int index;
  final Responsive responsive;

  const OrderCard({super.key, required this.index, required this.responsive});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool isExpanded = false;

  final List<Map<String, String>> orderStatuses = [
    {'status': 'Delivered', 'color': '0xFF4CAF50'},
    {'status': 'Processing', 'color': '0xFFFFC107'},
    {'status': 'Cancelled', 'color': '0xFFF44336'},
    {'status': 'On the way', 'color': '0xFF03A9F4'},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Future.delayed(Duration(milliseconds: widget.index * 50), () {
          if (mounted) _controller.forward();
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
    final statusData = orderStatuses[widget.index % orderStatuses.length];
    final statusColor = Color(int.parse(statusData['color']!));

    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(widget.responsive.setWidth(20)),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(
                widget.responsive.setWidth(20),
              ),
              border: Border.all(
                color: statusColor.withOpacity(0.2),
                width: 1.5,
              ),
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  borderRadius: BorderRadius.circular(
                    widget.responsive.setWidth(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(widget.responsive.setWidth(16)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // Order Image
                            Container(
                              width: widget.responsive.setWidth(70),
                              height: widget.responsive.setHeight(70),
                              decoration: BoxDecoration(
                                color: AppColors.lightGrey,
                                borderRadius: BorderRadius.circular(
                                  widget.responsive.setWidth(12),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  widget.responsive.setWidth(12),
                                ),
                                child: Image.asset(
                                  AppImages.imageTest,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            Gap(widget.responsive.setWidth(12)),

                            // Order Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        txt: 'Order #${1000 + widget.index}',
                                        fontSize: widget.responsive.setFont(16),
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textPrimary,
                                      ),
                                      Icon(
                                        isExpanded
                                            ? CupertinoIcons.chevron_up
                                            : CupertinoIcons.chevron_down,
                                        size: widget.responsive.setWidth(18),
                                        color: AppColors.textSecondary,
                                      ),
                                    ],
                                  ),
                                  Gap(widget.responsive.setHeight(4)),
                                  CustomText(
                                    txt: '3 items • \$45.99',
                                    fontSize: widget.responsive.setFont(14),
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textSecondary,
                                  ),
                                  Gap(widget.responsive.setHeight(8)),
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.clock,
                                        size: widget.responsive.setWidth(14),
                                        color: AppColors.textSecondary,
                                      ),
                                      Gap(widget.responsive.setWidth(4)),
                                      CustomText(
                                        txt: '2 days ago',
                                        fontSize: widget.responsive.setFont(12),
                                        color: AppColors.textSecondary,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        Gap(widget.responsive.setHeight(12)),

                        // Status Badge
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: widget.responsive.setWidth(12),
                                  vertical: widget.responsive.setHeight(8),
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(
                                    widget.responsive.setWidth(20),
                                  ),
                                  border: Border.all(
                                    color: statusColor.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: widget.responsive.setWidth(8),
                                      height: widget.responsive.setHeight(8),
                                      decoration: BoxDecoration(
                                        color: statusColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Gap(widget.responsive.setWidth(8)),
                                    CustomText(
                                      txt: statusData['status']!,
                                      fontSize: widget.responsive.setFont(13),
                                      fontWeight: FontWeight.w600,
                                      color: statusColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Gap(widget.responsive.setWidth(8)),
                            if (statusData['status'] == 'Delivered')
                              _buildActionButton(
                                'Reorder',
                                CupertinoIcons.repeat,
                                AppColors.primary,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Expanded Details
                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: _buildExpandedDetails(),
                  crossFadeState: isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: widget.responsive.setWidth(12),
        vertical: widget.responsive.setHeight(8),
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(widget.responsive.setWidth(12)),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, size: widget.responsive.setWidth(16), color: color),
          Gap(widget.responsive.setWidth(6)),
          CustomText(
            txt: text,
            fontSize: widget.responsive.setFont(13),
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedDetails() {
    return Container(
      padding: EdgeInsets.all(widget.responsive.setWidth(16)),
      decoration: BoxDecoration(
        color: AppColors.lightGrey.withOpacity(0.3),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(widget.responsive.setWidth(20)),
          bottomRight: Radius.circular(widget.responsive.setWidth(20)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            txt: 'Order Items',
            fontSize: widget.responsive.setFont(14),
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          Gap(widget.responsive.setHeight(12)),
          _buildOrderItem('Hamburger', 2, '\$12.99'),
          Gap(widget.responsive.setHeight(8)),
          _buildOrderItem('French Fries', 1, '\$5.99'),
          Gap(widget.responsive.setHeight(16)),
          Divider(color: AppColors.mediumGrey.withOpacity(0.3)),
          Gap(widget.responsive.setHeight(12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                txt: 'Total',
                fontSize: widget.responsive.setFont(16),
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
              CustomText(
                txt: '\$45.99',
                fontSize: widget.responsive.setFont(18),
                fontWeight: FontWeight.w900,
                color: AppColors.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(String name, int quantity, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: widget.responsive.setWidth(8),
                vertical: widget.responsive.setHeight(4),
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(
                  widget.responsive.setWidth(6),
                ),
              ),
              child: CustomText(
                txt: '${quantity}x',
                fontSize: widget.responsive.setFont(12),
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            Gap(widget.responsive.setWidth(8)),
            CustomText(
              txt: name,
              fontSize: widget.responsive.setFont(14),
              color: AppColors.textPrimary,
            ),
          ],
        ),
        CustomText(
          txt: price,
          fontSize: widget.responsive.setFont(14),
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ],
    );
  }
}
