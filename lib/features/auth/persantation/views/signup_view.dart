import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/router/route_names.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_snackbar.dart';
import 'package:hungry/core/widgets/loading_widget.dart';
import 'package:hungry/features/auth/persantation/cubit/auth_cubit.dart';
import 'package:hungry/features/auth/persantation/cubit/auth_state.dart';
import 'package:hungry/features/auth/persantation/views/widgets/signup_form.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                CustomSnackBar.show(
                  context,
                  message: 'Registration successful!',
                  type: SnackBarType.success,
                );
                GoRouter.of(context).pushReplacement(RouteNames.root);
              } else if (state is AuthError) {
                CustomSnackBar.show(
                  context,
                  message: state.message,
                  type: SnackBarType.error,
                );
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  SignupForm(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().register(
                          name: _nameController.text.trim(),
                          email: _emailController.text.trim(),
                          phone: '1234567890',
                          password: _passwordController.text.trim(),
                        );
                      }
                    },
                    formKey: _formKey,
                    fadeAnimation: _fadeAnimation,
                    slideAnimation: _slideAnimation,
                    responsive: responsive,
                    nameController: _nameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                  ),
                  if (state is AuthLoading)
                    LoadingWidget(
                      variant: LoadingVariant.modern,
                      fullscreen: true,
                      message: 'Creating your account...',
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
