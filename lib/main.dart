import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => const Hungry(),
    ),
  );
}

class Hungry extends StatelessWidget {
  const Hungry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hungry App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SplashView(),
    );
  }
}
