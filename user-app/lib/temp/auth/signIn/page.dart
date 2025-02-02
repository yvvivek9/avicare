import 'package:avicare/constants/colors.dart';
import 'package:avicare/temp/homePage/page.dart';
import 'package:avicare/screens/widget/build_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import 'package:avicare/temp/auth/signUp/page.dart';
import 'controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final controller = Get.put(SigninController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(
                height: 110.h,
              ),
              Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                style: TextStyle(
                  fontSize: 13.sp,
                ),
                "Welcome Back to App – Your Fitness Trainer App.\nLog in to begin!",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 25.h,
              ),
              BuildTextField(
                label: "Email",
                controller: controller.emailController,
                prefixIcon: Icons.email_outlined,
                hint: "Enter your email",
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 10.h,
              ),
              BuildTextField(
                label: "Password",
                controller: controller.passwordController,
                prefixIcon: Icons.lock_outline,
                hint: "Enter your password",
                isPassword: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(MainScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 60.h),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      "OR",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 60.h),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/apple_logo.png",
                      width: 20.w,
                      height: 20.h,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "Continue with Apple",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 60.h),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/google_logo.png",
                      width: 20.w,
                      height: 20.h,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "Continue with Google",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account ?",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.sp,
                    ),
                  ),
                  ZoomTapAnimation(
                    onTap: () {
                      Get.offAll(() => SignupScreen());
                    },
                    child: Text(
                      " Create Account",
                      style: TextStyle(
                        color: AppColors.blue,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
