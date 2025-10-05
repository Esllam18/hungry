import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/consts/app_colors.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({
    super.key,
    required this.emailController,
    required this.nameController,
    required this.addressController,
  });
  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController addressController;

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();

  @override
  void dispose() {
    _nameFocus.dispose();
    _emailFocus.dispose();
    _addressFocus.dispose();
    super.dispose();
  }

  Widget _buildAnimatedField({required int index, required Widget child}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 100)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAnimatedField(
          index: 0,
          child: _buildSectionTitle('Personal Information'),
        ),
        Gap(20.h),
        _buildAnimatedField(
          index: 1,
          child: _buildEnhancedField(
            controller: widget.nameController,
            label: 'Full Name',
            hint: 'Enter your name',
            icon: CupertinoIcons.person_fill,
            focusNode: _nameFocus,
            keyboardType: TextInputType.name,
          ),
        ),
        Gap(20.h),
        _buildAnimatedField(
          index: 2,
          child: _buildEnhancedField(
            controller: widget.emailController,
            label: 'Email Address',
            hint: 'Enter your email',
            icon: CupertinoIcons.mail_solid,
            focusNode: _emailFocus,
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        Gap(20.h),
        _buildAnimatedField(
          index: 3,
          child: _buildEnhancedField(
            controller: widget.addressController,
            label: 'Delivery Address',
            hint: 'Enter your address',
            icon: Icons.location_on_rounded,
            focusNode: _addressFocus,
            keyboardType: TextInputType.streetAddress,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Gap(10.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancedField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required FocusNode focusNode,
    required TextInputType keyboardType,
  }) {
    return AnimatedBuilder(
      animation: focusNode,
      builder: (context, child) {
        final bool isFocused = focusNode.hasFocus;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isFocused ? AppColors.primary : Colors.grey[300]!,
              width: isFocused ? 2 : 1,
            ),
            boxShadow: isFocused
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 12),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: isFocused ? AppColors.primary : Colors.grey[600],
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              TextFormField(
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
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14.sp,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Icon(
                      icon,
                      color: isFocused ? AppColors.primary : Colors.grey[400],
                      size: 22,
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 12,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
