// Modify your CustomBottomNavBar to handle navigation
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final NavigationController controller;

  const CustomBottomNavBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(90.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(0, const AssetImage("assets/images/home.png")),
          _buildNavItem(1, const AssetImage("assets/images/dumble.png")),
          _buildNavItem(2, const AssetImage("assets/images/trend-up.png")),
          _buildNavItem(
              3, const AssetImage("assets/images/profile-circle.png")),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, ImageProvider icon) {
    return Obx(() => GestureDetector(
          onTap: () => controller.changeIndex(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 60.w,
            height: 60.h,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: controller.selectedIndex.value == index
                  ? Colors.black
                  : Colors.white,
              borderRadius: BorderRadius.circular(90.r),
            ),
            child: ImageIcon(
              icon,
              color: controller.selectedIndex.value == index
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ));
  }
}
