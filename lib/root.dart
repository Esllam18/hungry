import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/features/cart/views/cart_view.dart';
import 'package:hungry/features/home/persantaion/views/home_veiw.dart';
import 'package:hungry/features/order/views/order_view.dart';
import 'package:hungry/features/profil/views/profil_view.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int currentScreen = 0;
  late PageController controller;
  late List<Widget> screensViews;
  @override
  void initState() {
    controller = PageController(initialPage: currentScreen);
    screensViews = [HomeView(), CartView(), OrderView(), ProfilView()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(controller: controller, children: screensViews),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_restaurant_sharp),
              label: 'Order',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled),
              label: 'Profile',
            ),
          ],
          onTap: (index) {
            setState(() {
              currentScreen = index;
            });
            controller.jumpToPage(currentScreen);
          },
          currentIndex: currentScreen,

          elevation: 0,
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.grey,
          backgroundColor: AppColors.transparent,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
