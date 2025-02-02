import 'package:avicare/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../screens/widget/bottom_sheet_button.dart';
import 'onboarding_screen_3.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

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
                    'assets/images/onboarding2.png',
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
                            text: 'Strength in ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'Motion',
                            style: TextStyle(
                              color: AppColors.linkColor1,
                              // Different color for this part
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ': Unleash Your Best Self.',
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
        bottomSheet: bottomSheetButton(
          text: 'Next',
          onTap: () {
            Get.to(const OnboardingScreen3());
          },
        ));
  }
}
