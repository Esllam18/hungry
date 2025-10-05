import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/features/checkout/widgets/payment_method_card.dart';

class PaymentMethodsSection extends StatefulWidget {
  const PaymentMethodsSection({super.key});

  @override
  State<PaymentMethodsSection> createState() => _PaymentMethodsSectionState();
}

class _PaymentMethodsSectionState extends State<PaymentMethodsSection> {
  String selectedPayment = 'cash';

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Column(
      children: [
        // Cash on Delivery
        PaymentMethodCard(
          responsive: responsive,
          title: 'Cash on Delivery',
          isSelected: selectedPayment == 'cash',
          onTap: () {
            setState(() {
              selectedPayment = 'cash';
            });
          },
          textColor: AppColors.white,
          icon: Container(
            padding: EdgeInsets.all(responsive.setWidth(10)),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.attach_money,
              color: AppColors.success,
              size: responsive.setWidth(24),
            ),
          ),
          backgroundColor: const Color(0xFF3C2F2F),
        ),

        Gap(responsive.setHeight(12)),

        // Debit Card
        PaymentMethodCard(
          responsive: responsive,
          title: 'Debit card',
          subtitle: '3566 **** **** 0505',
          isSelected: selectedPayment == 'card',
          onTap: () {
            setState(() {
              selectedPayment = 'card';
            });
          },
          textColor: AppColors.white,
          backgroundColor: const Color.fromARGB(255, 29, 49, 85),
          icon: Container(
            width: responsive.setWidth(60),
            height: responsive.setHeight(35),
            padding: EdgeInsets.all(responsive.setWidth(8)),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(responsive.setWidth(8)),
            ),
            child: Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Visa_Inc._logo.svg/2560px-Visa_Inc._logo.svg.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Text(
                    'VISA',
                    style: TextStyle(
                      color: Color(0xFF1A1F71),
                      fontSize: responsive.setFont(18),
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        Gap(responsive.setHeight(20)),
      ],
    );
  }
}
