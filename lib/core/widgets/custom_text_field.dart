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
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.maxLines = 1,
    this.obscureText = false,
  });

  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final Widget? label;
  final Widget? hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool enabled;
  final int maxLines;
  final bool obscureText;

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
          color: const Color(0xff3C2F2F),
        ),
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: const Color(0xff3C2F2F),
        cursorHeight: 22.h,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        enabled: enabled,
        maxLines: maxLines,
        obscureText: obscureText,
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
            borderSide: BorderSide(color: AppColors.primary, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red.shade300),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.mediumGrey.withOpacity(0.3),
            ),
          ),
          fillColor: AppColors.white,
          filled: true,
          label: label,
          hintText: hint is Text ? (hint as Text).data : null,
          hintStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xff3C2F2F).withOpacity(0.5),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
        ),
      ),
    );
  }
}
