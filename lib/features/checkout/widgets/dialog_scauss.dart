import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_button.dart';
import 'package:hungry/core/widgets/custom_text.dart';

class DialogScauss extends StatelessWidget {
  const DialogScauss({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Dialog(
      elevation: 4,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(responsive.setWidth(20)),
      ),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(responsive.setWidth(20)),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(responsive.setWidth(16)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                weight: 10,
                color: AppColors.primary,
                size: responsive.setWidth(90),
              ),
              Gap(responsive.setHeight(20)),

              CustomText(
                txt: 'Success !',
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: responsive.setFont(26),
              ),

              Gap(responsive.setHeight(10)),

              CustomText(
                txt:
                    'Your payment was successful.\nA receipt for this purchase has\nbeen sent to your email.',
                color: AppColors.grey.withOpacity(.9),
                fontWeight: FontWeight.w400,
                fontSize: responsive.setFont(14),
                textAlign: TextAlign.center,
              ),

              Gap(responsive.setHeight(30)),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    backgroundColor: AppColors.primary,
                    content: CustomText(
                      txt: 'Go Back',
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: responsive.setFont(18),
                    ),
                    onPressed: () => GoRouter.of(context).pop(),
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
