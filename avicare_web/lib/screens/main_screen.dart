import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/main_controller.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left sidebar
            Card(
              child: Container(
                width: 250.w,
                height: 1024.h,
                color: Colors.white,
                child: buildSidebar(),
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            SingleChildScrollView(
              child: mainController.screens[mainController.selectedIndex.value],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSidebar() {
    return ListView(
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/splash.png',
              width: 40.w,
            ),
            Text(
              'TaaviCare',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 80.h),
        _buildSidebarItem(
          index: 0,
          iconPath: 'assets/images/overview_icon.png',
          title: 'Overview',
        ),
        _buildSidebarItem(
          index: 1,
          iconPath: 'assets/images/users_icon.png',
          title: 'Users',
        ),
        _buildSidebarItem(
          index: 2,
          iconPath: 'assets/images/exercise_icon.png',
          title: 'Exercises',
        ),
        _buildSidebarItem(
          index: 3,
          iconPath: 'assets/images/categories_icon.png',
          title: 'Protocols',
        ),
        _buildSidebarItem(
          index: 4,
          iconPath: 'assets/images/hardware_icon.png',
          title: 'Hardware',
        ),
        _buildSidebarItem(
          index: 5,
          iconPath: 'assets/images/overview_icon.png',
          title: 'Privacy Policy',
        ),
        _buildSidebarItem(
          index: 6,
          iconPath: 'assets/images/overview_icon.png',
          title: 'Terms & Conditions',
        ),
        SizedBox(height: 270.h),
        Container(
          margin: EdgeInsets.symmetric(
            vertical: 15.h,
            horizontal: 15.w,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: Colors.grey.shade300,
          ),
          width: 120.w,
          height: 70.w,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: 30.sp,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Darpan Neve",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      "India",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSidebarItem({
    required int index,
    required String iconPath,
    required String title,
  }) {
    final isSelected = mainController.selectedIndex.value == index;

    return ListTile(
      leading: Image.asset(
        iconPath,
        width: 14.w,
        height: 14.h,
        color: isSelected ? Colors.black : Colors.grey,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.black : Colors.grey,
        ),
      ),
      selected: isSelected,
      // Highlight background
      onTap: () {
        mainController.selectedIndex.value = index;
      },
    );
  }
}
