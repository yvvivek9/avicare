import 'package:avicare/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroCard extends StatelessWidget {
  const IntroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: 25.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 14.h),
              width: double.infinity,
              height: 160.h,
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.all(
                  Radius.circular(18.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Great Job !!",
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "You’ve successfully completed\ntoday's training",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.slightGrey.withOpacity(0.6),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Workout Duration",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "0:36 Hours",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          right: 0,
          child: Image.asset(
            height: 189.h,
            width: 189.w,
            'assets/images/target.png',
          ),
        ),
      ],
    );
  }
}
