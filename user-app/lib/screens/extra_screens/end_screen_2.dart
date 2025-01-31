import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EndScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150.w,
                height: 150.w,
                child: Image.asset("assets/images/thank_you.png"),
              ),
              SizedBox(height: 20.h),
              Text(
                'Thank you for visiting!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(fontSize: 16.sp),
                  children: [
                    TextSpan(
                      text: 'We hope to welcome you to the ',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    TextSpan(
                      text: 'Avicare',
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextSpan(
                      text: ' family soon.',
                      style: TextStyle(color: Colors.grey[400]),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14.sp,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Create Account',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
