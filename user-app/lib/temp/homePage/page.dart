import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:avicare/screens/statistics_screens/statistics_screen.dart';
import 'firstPage/page.dart';
import 'secondPage/page.dart';
import 'profilePage/page.dart';
import 'navBar.dart';
import 'package:avicare/screens/extra_screens/end_screen.dart';

class MainScreen extends StatelessWidget {
  final NavigationController controller = Get.put(NavigationController());

  final List<Widget> pages = [
    const HomeScreen2(),
    ExerciseScreen(),
    StatisticsScreen(),
    ProfilePage(),
  ];

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (x, y) async {
          final prefs = await SharedPreferences.getInstance();
          final session = prefs.getString("token");
          if(session == null) Get.to(() => EndScreen());
        },
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Obx(() => AnimatedSwitcher(
                    switchInCurve: Curves.bounceInOut,
                    switchOutCurve: Curves.bounceOut,
                    duration: const Duration(milliseconds: 500),
                    child: pages[controller.selectedIndex.value],
                  )),
              Positioned(
                bottom: 20.h,
                left: 45.w,
                right: 45.w,
                child: CustomBottomNavBar(controller: controller),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
