import 'package:go_router/go_router.dart';

import 'package:hungry/core/router/route_names.dart';
import 'package:hungry/features/auth/persantation/views/login_view.dart';
import 'package:hungry/features/auth/persantation/views/signup_view.dart';
import 'package:hungry/features/checkout/views/checkout_view.dart';
import 'package:hungry/features/home/persantaion/views/product_details_view.dart';
import 'package:hungry/features/splash/views/splash_view.dart';
import 'package:hungry/root.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: RouteNames.splash,
      builder: (context, state) => const SplashView(), // Added const
    ),

    GoRoute(
      path: RouteNames.login,
      builder: (context, state) => const LoginView(), // Added const
    ),
    GoRoute(
      path: RouteNames.signUp,
      builder: (context, state) => const SignupView(), // Added const
    ),
    GoRoute(
      path: RouteNames.root,
      builder: (context, state) => const Root(), // Added const
    ),
    GoRoute(
      path: RouteNames.productDetails,
      builder: (context, state) => const ProductDetailsView(), // Added const
    ),
    GoRoute(
      path: RouteNames.checkoutView,
      builder: (context, state) => const CheckoutView(), // Added const
    ),
    // GoRoute(
    //   path: RouteNames.home,
    //   builder: (context, state) => const HomePage(), // Added const
    // ),
  ],
);
