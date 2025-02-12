import 'package:avicare/dummy_data/individual_dates_data.dart';
import 'widget/battery_indicator.dart';
import 'widget/intro_card.dart';
import 'widget/protocols.dart';
import 'package:avicare/screens/widget/build_image.dart';
import 'package:avicare/screens/widget/individual_dates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:avicare/utils/utils.dart';
import 'package:avicare/model/user.dart';
import '../../../constants/colors.dart';
import '../../../screens/notification/notification_screen.dart';

class HomeScreen2Controller extends GetxController {
  final user = Rx<User?>(null);

  @override
  void onInit() {
    fetchUserData();
    super.onInit();
  }

  Future<void> fetchUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getString("token") == null) return;

      final response = await httpPostRequest(route: "/user/details/get", body: {});
      user.value = User.fromJSON(response);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}

class HomeScreen2 extends StatelessWidget {
  HomeScreen2({super.key});

  final controller = Get.put(HomeScreen2Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        buildImage(
                          imagePath: 'https://emojiisland.com/cdn/shop/products/39_large.png?v=1571606117',
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Text(
                                controller.user.value != null ? controller.user.value!.name : "Guest User",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "Good Morning!",
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.greyText,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 60.w,
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
              ),
              const IntroCard(),
              SizedBox(height: 18.h),
              Container(
                padding: EdgeInsets.only(left: 20.w),
                height: 80.h,
                child: ListView.builder(
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: individualDatesData.length,
                  itemBuilder: (context, index) {
                    return individualDates(individualDatesModel: individualDatesData[index]);
                  },
                ),
              ),
              SizedBox(height: 20.h),
              const Protocols(),
            ],
          ),
        ),
      ),
    );
  }
}
