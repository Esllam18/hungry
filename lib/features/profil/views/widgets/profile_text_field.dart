import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // You are using this package

class AppColors {
  static const Color primary = Colors.blue;
}

class ProfileTextField extends StatelessWidget {
  const ProfileTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType = TextInputType.text,
    required this.isFocused,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType keyboardType;
  final bool isFocused;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        labelStyle: TextStyle(
          color: isFocused ? AppColors.primary : Colors.grey[600],
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14.sp),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Icon(
            icon,
            color: isFocused ? AppColors.primary : Colors.grey[400],
            size: 22,
          ),
        ),
        // Add BorderSide to make the border visible
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
        ),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        // Add BorderSide for a different color/width when focused
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16, // Increased padding for better visuals
          horizontal: 0,
        ),
      ),
    );
  }
}
