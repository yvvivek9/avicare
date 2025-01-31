import 'package:avicare/constants/colors.dart';
import 'package:avicare/screens/demo_screen.dart';
import 'package:avicare/screens/home_page/widget/battery_indicator.dart';
import 'package:avicare/screens/notification/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              ZoomTapAnimation(
                onTap: () {},
                child: SizedBox(
                  child: CircleAvatar(
                    radius: 30.r,
                    backgroundColor: AppColors.lightPeach,
                    child: const ImageIcon(AssetImage(
                      "assets/images/profile.png",
                    )),
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Guest User",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "Good Morning!",
                    style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyText),
                  ),
                ],
              ),
              SizedBox(
                width: 65.w,
              ),
              BatteryIndicatorWithLink(),
              SizedBox(
                width: 10.w,
              ),
              ZoomTapAnimation(
                onTap: () {
                  Get.to(() => NotificationPage());
                },
                child: Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: 0.8.w,
                    ),
                  ),
                  child: Center(
                    child: ImageIcon(
                      size: 18.sp,
                      color: Colors.white,
                      const AssetImage(
                        "assets/images/notification.png",
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
