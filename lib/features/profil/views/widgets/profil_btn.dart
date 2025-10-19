import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/widgets/custom_text.dart';

class ProfileBtn extends StatelessWidget {
  const ProfileBtn({
    super.key,
    this.color,
    this.child,
    required Null Function() onTap,
  });
  final Color? color;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 70,

      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary, width: 2),
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: child,
    );
  }
}

class ElmentBtnRow extends StatelessWidget {
  const ElmentBtnRow({
    super.key,
    required this.text,
    this.icon,
    this.color,
    this.iconColor,
  });
  final String text;
  final IconData? icon;
  final Color? color;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            txt: text,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: color,
          ),
          Gap(8.w),
          Icon(icon, color: iconColor),
        ],
      ),
    );
  }
}
