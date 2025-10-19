import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      elevation: 4,
      backgroundColor: AppColors.white,
      child: Padding(
        padding: EdgeInsets.all(responsive.setWidth(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Confirm Logout',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            Gap(responsive.setHeight(16)),
            Text(
              'Are you sure you want to log out of your account?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.grey,
              ),
            ),
            Gap(responsive.setHeight(24)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: responsive.setWidth(20),
                      vertical: responsive.setHeight(12),
                    ),
                  ),
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
