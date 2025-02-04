import 'package:avicare/constants/colors.dart';
import 'package:avicare/screens/widget/bottom_sheet_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/icon_button.dart';
import 'end_screen_2.dart';
import 'package:avicare/temp/auth/signUp/page.dart';

class EndScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: backButton(onTap: () {
          Get.back();
        }),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/end_screen.png',
                width: 200.w,
                height: 200.h,
              ),
              SizedBox(height: 20.h),
              Text(
                'Ending the session too early?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Sign up today for a personalized experience at your fingertips.',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16.sp,
                      ),
                    ),
                    TextSpan(
                      text:
                          'Discover exercises and reports crafted exclusively for you.',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => EndScreen2()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      padding: EdgeInsets.symmetric(vertical: 22.h),
                    ),
                    child: Text('End the session',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(width: 10.w),
                bottomSheetIconButton(
                  onTap: () => Get.to(() => SignupScreen()),
                  text: "Sign up",
                  color: AppColors.blue,
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              'Sign-up to save your session',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
