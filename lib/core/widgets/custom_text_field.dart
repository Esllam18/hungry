import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/consts/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.prefix,
    this.suffix,
    this.keyboardType,
    this.label,
    this.hint,
    this.controller,
  });
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final Widget? label;
  final Widget? hint;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      color: AppColors.white,
      borderRadius: BorderRadius.circular(12),
      child: TextField(
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: Color(0xff3C2F2F),
        ),
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: Color(0xff3C2F2F),
        cursorHeight: 22.h,

        decoration: InputDecoration(
          prefixIcon: prefix,
          suffixIcon: suffix,

          focusColor: AppColors.background,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.white),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.white),
          ),
          fillColor: AppColors.background,
          label: label,

          hint: hint,
          hintStyle: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xff3C2F2F),
          ),
        ),
      ),
    );
  }
}
