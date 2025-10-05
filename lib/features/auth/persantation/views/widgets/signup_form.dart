import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/functions/validators.dart';
import 'package:hungry/core/router/route_names.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_button.dart';
import 'package:hungry/core/widgets/custom_text.dart';
import 'package:hungry/core/widgets/custom_text_form_field.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required Animation<double> fadeAnimation,
    required Animation<Offset> slideAnimation,
    required this.responsive,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
  }) : _formKey = formKey,
       _fadeAnimation = fadeAnimation,
       _slideAnimation = slideAnimation,
       _nameController = nameController,
       _emailController = emailController,
       _passwordController = passwordController,
       _confirmPasswordController = confirmPasswordController;

  final GlobalKey<FormState> _formKey;
  final Animation<double> _fadeAnimation;
  final Animation<Offset> _slideAnimation;
  final Responsive responsive;
  final TextEditingController _nameController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final TextEditingController _confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Column(
            children: [
              // Top Section - Logo and Welcome
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.setWidth(20),
                ),
                child: Column(
                  children: [
                    Gap(responsive.setHeight(80)),
                    SvgPicture.asset(
                      'assets/logo/logo.svg',
                      height: responsive.setHeight(60),
                      color: AppColors.primary,
                    ),

                    Gap(responsive.setHeight(8)),
                    CustomText(
                      txt: 'Sign up to start your food journey',
                      fontSize: responsive.setFont(14),
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.center,
                    ),
                    Gap(responsive.setHeight(80)),
                  ],
                ),
              ),

              // Bottom Section - Form
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(responsive.setWidth(24)),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(responsive.setWidth(24)),
                      topRight: Radius.circular(responsive.setWidth(24)),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Gap(responsive.setHeight(20)),

                        CustomTextFormField(
                          controller: _nameController,
                          hint: 'Enter your Name',
                          keyboardType: TextInputType.name,
                          prefixIcon: Icons.person,
                          validator: AppValidators.validateName,
                        ),

                        Gap(responsive.setHeight(20)),

                        CustomTextFormField(
                          controller: _emailController,
                          hint: 'Enter your Email',
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Icons.email,
                          validator: AppValidators.validateEmail,
                        ),

                        Gap(responsive.setHeight(20)),

                        CustomTextFormField(
                          controller: _passwordController,
                          hint: 'Enter your Password',
                          obscureText: true,
                          prefixIcon: Icons.lock,
                          validator: AppValidators.validatePassword,
                        ),

                        Gap(responsive.setHeight(20)),

                        CustomTextFormField(
                          controller: _confirmPasswordController,
                          hint: 'Confirm your Password',
                          obscureText: true,
                          prefixIcon: Icons.lock,
                          validator: (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),

                        Gap(responsive.setHeight(30)),

                        SizedBox(
                          width: double.infinity,
                          height: responsive.setHeight(56),
                          child: CustomButton(
                            backgroundColor: AppColors.white,
                            content: CustomText(
                              txt: 'Sign Up',
                              fontSize: responsive.setFont(18),
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                GoRouter.of(
                                  context,
                                ).pushReplacement(RouteNames.root);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              elevation: 4,
                              shadowColor: AppColors.white.withOpacity(0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  responsive.setWidth(16),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Gap(responsive.setHeight(20)),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              txt: 'Already have an account?',
                              fontSize: responsive.setFont(14),
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w500,
                            ),
                            Gap(responsive.setWidth(6)),
                            GestureDetector(
                              onTap: () {
                                GoRouter.of(context).pop();
                              },
                              child: CustomText(
                                txt: 'Log In',
                                fontSize: responsive.setFont(16),
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        Gap(responsive.setHeight(20)),
                      ],
                    ),
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
