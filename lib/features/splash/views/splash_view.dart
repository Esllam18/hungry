import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Add for BlocProvider
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/consts/app_assets.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/router/route_names.dart';
import 'package:hungry/features/auth/persantation/cubit/auth_cubit.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Start animation
    Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
        });
      }
    });

    // Check authentication and navigate
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    // Wait for splash duration
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // Check if user is logged in using the provided AuthCubit
    final isLoggedIn = await context.read<AuthCubit>().isLoggedIn();

    if (mounted) {
      if (isLoggedIn) {
        GoRouter.of(context).go(RouteNames.root);
      } else {
        GoRouter.of(context).go(RouteNames.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          const Spacer(),
          AnimatedOpacity(
            duration: const Duration(seconds: 2),
            opacity: _opacity,
            child: SvgPicture.asset(AppImages.logo),
          ),
          const Spacer(),
          Image.asset(AppImages.imageSpalsh),
        ],
      ),
    );
  }
}
