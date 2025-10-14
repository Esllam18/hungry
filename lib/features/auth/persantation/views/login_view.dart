import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/router/route_names.dart';

import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_snackbar.dart';
import 'package:hungry/core/widgets/loading_widget.dart';
import 'package:hungry/features/auth/persantation/cubit/auth_cubit.dart';
import 'package:hungry/features/auth/persantation/cubit/auth_state.dart';
import 'package:hungry/features/auth/persantation/views/widgets/login_form.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
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
                  message: 'Login successful!',
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
                  LoginForm(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().login(
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                        );
                      }
                    },
                    formKey: _formKey,
                    responsive: responsive,
                    fadeAnimation: _fadeAnimation,
                    slideAnimation: _slideAnimation,
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),
                  if (state is AuthLoading)
                    LoadingWidget(
                      variant: LoadingVariant.shimmer,
                      fullscreen: true,
                      message: 'Logging in...',
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
