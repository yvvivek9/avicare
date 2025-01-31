import 'package:avicare/controller/navigation_controller.dart';
import 'package:avicare/screens/exercise_screen/exercise_screen_2.dart';
import 'package:avicare/screens/home_page/home_screen.dart';
import 'package:avicare/screens/main_screen/widget/bottom_navigation_bar.dart';
import 'package:avicare/screens/workout_page.dart';
import 'package:avicare/screens/statistics_screens/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// import '../exercise_screen/exercise_screen.dart';
import 'package:avicare/temp/protocolList/page.dart';
import '../home_page/home_screen_2.dart';
import '../profile_screen/profile_page.dart';

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
    );
  }
}
