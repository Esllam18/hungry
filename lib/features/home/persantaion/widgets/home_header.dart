import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hungry/core/consts/app_assets.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_text.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              AppImages.logo,
              // ignore: deprecated_member_use
              color: AppColors.primary,
              width: responsive.setWidth(170),
              height: responsive.setHeight(37),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(responsive.setWidth(30)),
              child: CircleAvatar(
                backgroundColor: AppColors.primary,
                radius: responsive.setWidth(30),
                child: Icon(
                  CupertinoIcons.person,
                  color: AppColors.white,
                  size: responsive.setWidth(25),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: responsive.setHeight(8)),
        CustomText(
          txt: 'Hello, Rich Sonic',
          fontSize: responsive.setFont(18),
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      ],
    );
  }
}
