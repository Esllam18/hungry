import 'package:flutter/cupertino.dart';
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

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.responsive,
    required Animation<double> fadeAnimation,
    required Animation<Offset> slideAnimation,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) : _formKey = formKey,
       _fadeAnimation = fadeAnimation,
       _slideAnimation = slideAnimation,
       _emailController = emailController,
       _passwordController = passwordController;

  final GlobalKey<FormState> _formKey;
  final Responsive responsive;
  final Animation<double> _fadeAnimation;
  final Animation<Offset> _slideAnimation;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

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
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.setWidth(20),
                ),
                child: Column(
                  children: [
                    Gap(responsive.setHeight(80)),
                    SvgPicture.asset(
                      'assets/logo/logo.svg',
                      height: responsive.setHeight(50),
                      color: AppColors.primary,
                    ),
                    Gap(responsive.setHeight(8)),
                    CustomText(
                      txt: 'Welcome to Hungry, Discover The fast food',
                      fontSize: responsive.setFont(12),
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.center,
                    ),
                    Gap(responsive.setHeight(120)),
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
                          controller: _emailController,
                          hint: 'Enter your Email',
                          validator: AppValidators.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: CupertinoIcons.mail_solid,
                        ),

                        Gap(responsive.setHeight(20)),

                        CustomTextFormField(
                          controller: _passwordController,
                          hint: 'Enter your Password',
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          prefixIcon: CupertinoIcons.lock_fill,
                          validator: AppValidators.validatePassword,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                GoRouter.of(
                                  context,
                                ).push(RouteNames.resetPassword);
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: responsive.setFont(13),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Gap(responsive.setHeight(20)),

                        SizedBox(
                          width: double.infinity,
                          height: responsive.setHeight(56),
                          child: CustomButton(
                            backgroundColor: AppColors.white,
                            content: CustomText(
                              txt: 'Login',
                              fontSize: responsive.setFont(18),
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                            onPressed: () {
                              GoRouter.of(
                                context,
                              ).pushReplacement(RouteNames.root);
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
                              txt: 'Don\'t have an account?',
                              fontSize: responsive.setFont(14),
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w500,
                            ),
                            Gap(responsive.setWidth(6)),
                            GestureDetector(
                              onTap: () {
                                GoRouter.of(context).push(RouteNames.signUp);
                              },
                              child: CustomText(
                                txt: 'Sign Up',
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
