import 'package:avicare/constants/colors.dart';
import 'package:avicare/temp/auth/register/page.dart';
import 'package:avicare/temp/homePage/profilePage/updateProfile/page.dart';
import 'widget/general_option.dart';
import 'widget/stats_icon.dart';
import 'package:avatar_plus/avatar_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller.dart';
import 'package:avicare/temp/auth/signIn/page.dart';
import 'package:avicare/screens/demo_screen.dart';
import 'package:avicare/temp/policies/privacy_policy.dart';
import 'widget/profile_picker.dart';

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
          Obx(
            () {
              if (controller.loggedIn.value) {
                return ZoomTapAnimation(
                  onTap: controller.handleLogout,
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
                );
              } else {
                return IconButton(
                  onPressed: () {
                    Get.deleteAll();
                    Get.offAll(() => SignInScreen());
                  },
                  style: IconButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white70,
                  ),
                  icon: Icon(Icons.login),
                );
              }
            },
          ),
          SizedBox(
            width: 10.w,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.h),
          child: Obx(() => Column(
                children: [
                  if (controller.loggedIn.value)
                    Row(
                      children: [
                        ZoomTapAnimation(
                          onTap: () async {
                            await Get.to(() => AvatarPickerScreen());
                            controller.loggedIn.refresh();
                          },
                          child: FutureBuilder(
                            future: Future<String>(() async {
                              final prefs = await SharedPreferences.getInstance();
                              final name = prefs.getString("dp");
                              return name ?? "jonny";
                            }),
                            initialData: "jonny",
                            builder: (ctx, data) => AvatarPlus(
                              data.requireData,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // child: buildImage(
                          //   imagePath: "https://firebasestorage.googleapis.com/v0/b/blue-bit-simple.appspot.com/o/face.jpg?alt=media&token=02da00c3-48d5-4e3a-812b-1043ff0e19e8",
                          // ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.user.value.name,
                              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              controller.user.value.gender ?? " -- ",
                              style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w400, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 30.h,
                  ),
                  if (!controller.loggedIn.value)
                    Center(
                      child: Text("Please login to create your profile"),
                    ),
                  if (controller.loggedIn.value)
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
                          onPressed: () async {
                            await Get.to(() => UpdateProfilePage(user: controller.user.value));
                            controller.fetchUserData();
                          },
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
                  if (controller.loggedIn.value)
                    Row(
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
                    ),
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
                    switchWidget: SizedBox(
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
                  SizedBox(
                    height: 15.h,
                  ),
                  // generalOption(
                  //   title: "Contact Us",
                  //   prefixIcon: Icons.email_outlined,
                  //   switchWidget: null,
                  // ),
                  CollapsibleOption(
                    title: "Contact Us",
                    prefixIcon: Icons.email_outlined,
                    options: [
                      SizedBox(height: 7.h),
                      ListTile(
                        onTap: () => launchUrl(Uri.parse("mailto:avicarept@gmail.com")),
                        visualDensity: VisualDensity(vertical: -3),
                        title: Text("Email: avicarept@gmail.com"),
                        textColor: Colors.white,
                        iconColor: Colors.white,
                      ),
                      Divider(),
                      ListTile(
                        onTap: () => launchUrl(Uri.parse("tel:+919881768666")),
                        visualDensity: VisualDensity(vertical: -3),
                        title: Text("Call: +91 9881768666"),
                        textColor: Colors.white,
                        iconColor: Colors.white,
                      ),
                      Divider(),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  generalOption(
                    title: "Privacy Policy",
                    prefixIcon: Icons.privacy_tip_outlined,
                    switchWidget: null,
                    onTap: () => Get.to(() => PrivacyPolicyScreen()),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CollapsibleOption(
                    title: "Settings",
                    prefixIcon: Icons.settings_outlined,
                    options: controller.loggedIn.value
                        ? [
                            SizedBox(height: 7.h),
                            ListTile(
                              onTap: controller.handleAccountDelete,
                              visualDensity: VisualDensity(vertical: -3),
                              title: Text("Delete Account"),
                              textColor: Colors.white,
                              iconColor: Colors.white,
                            ),
                            Divider(),
                          ]
                        : [],
                  ),
                  SizedBox(
                    height: 115.h,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
