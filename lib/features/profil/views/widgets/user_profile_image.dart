import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/consts/app_colors.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary, width: 8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: 120.55.w,
          height: 120.94,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(imageUrl)),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
