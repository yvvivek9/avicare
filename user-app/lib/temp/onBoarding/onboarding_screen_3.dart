import 'package:avicare/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:avicare/temp/auth/signIn/page.dart';
import 'package:avicare/temp/auth/signUp/page.dart';
import '../../../screens/widget/bottom_sheet_button.dart';
import '../../../screens/widget/bottom_sheet_icon_button.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Stack(
              children: [
                Image.asset(
                  'assets/images/onboarding3.png',
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Every ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'Step Counts',
                          style: TextStyle(
                            color: AppColors.linkColor1,
                            // Different color for this part
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' - make Them Matter !',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        color: Colors.black,
        child: Row(
          children: [
            Expanded(
              child: bottomSheetIconButton(
                onTap: () {
                  Get.offAll(() => SignInScreen());
                },
                text: 'SignIn',
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: bottomSheetIconButton(
                onTap: () {
                  Get.offAll(() => SignupScreen());
                },
                text: 'SignUp',
                color: AppColors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
