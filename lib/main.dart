import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/router/app_router.dart';
import 'package:hungry/features/auth/persantation/cubit/auth_cubit.dart';

void main() {
  runApp(const Hungry());
}

class Hungry extends StatelessWidget {
  const Hungry({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [BlocProvider(create: (context) => AuthCubit())],
          child: MaterialApp.router(
            title: 'Hungry',
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          ),
        );
      },
    );
  }
}
