import 'package:avicare/constants/colors.dart';
import 'widget/general_option.dart';
import 'widget/stats_icon.dart';
import 'package:avicare/screens/widget/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import 'controller.dart';
import 'package:avicare/screens/demo_screen.dart';
import 'package:avicare/screens/widget/build_image.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final controller = Get.put(ProfilePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        centerTitle: false,
        toolbarHeight: 100.h,
        backgroundColor: Colors.black,
        actions: [
          Row(
            children: [
              ZoomTapAnimation(
                onTap: () {},
                child: Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.orange,
                      width: 0.8.w,
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.orangeLink1,
                        AppColors.orangeLink2,
                      ],
                    ),
                  ),
                  child: const Center(
                    child: ImageIcon(
                      color: Colors.white,
                      AssetImage(
                        "assets/images/logout.png",
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
        ],
        title: Row(
          children: [
            SizedBox(
              width: 5.w,
            ),
            Text(
              'Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        child: Column(
          children: [
            Row(
              children: [
                ZoomTapAnimation(
                  onTap: () {
                    Get.to(() => DemoScreen());
                  },
                  child: buildImage(
                    imagePath:
                        "https://firebasestorage.googleapis.com/v0/b/blue-bit-simple.appspot.com/o/face.jpg?alt=media&token=02da00c3-48d5-4e3a-812b-1043ff0e19e8",
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.user.value.name,
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      controller.user.value.gender ?? " -- ",
                      style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(160.w, 40.h),
                    backgroundColor: Colors.white,
                  ),
                  label: Text(
                    "Share Profile",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {},
                  icon: ImageIcon(
                    color: Colors.black,
                    AssetImage(
                      "assets/images/navigation.png",
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(160.w, 40.h),
                    backgroundColor: Colors.white,
                  ),
                  label: Text(
                    "Edit",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {},
                  icon: Icon(
                    color: Colors.black,
                    Icons.edit_outlined,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                statsIcon(
                  subTitle: "Height",
                  title: controller.user.value.height ?? " -- ",
                  color: AppColors.lightPeach,
                ),
                statsIcon(
                  subTitle: "Weight",
                  title: controller.user.value.weight ?? " -- ",
                  color: AppColors.lightBlue,
                ),
                statsIcon(
                  subTitle: "Age",
                  title: controller.calculateAge(),
                  color: AppColors.purple,
                ),
              ],
            )),
            SizedBox(
              height: 35.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "General",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            generalOption(
              title: "Pop-up Notifications",
              prefixIcon: Icons.notifications_outlined,
              switchWidget: Obx(
                () => SizedBox(
                  height: 30.h,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Switch(
                      value: controller.isPopupActive.value,
                      onChanged: (value) {
                        controller.isPopupActive.value = value;
                      },
                      activeColor: AppColors.purple,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            generalOption(
              title: "Contact Us",
              prefixIcon: Icons.email_outlined,
              switchWidget: null,
            ),
            SizedBox(
              height: 15.h,
            ),
            generalOption(
              title: "Privacy Policy",
              prefixIcon: Icons.privacy_tip_outlined,
              switchWidget: null,
            ),
            SizedBox(
              height: 15.h,
            ),
            generalOption(
              title: "Settings",
              prefixIcon: Icons.settings_outlined,
            )
          ],
        ),
      ),
    );
  }
}
