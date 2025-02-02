import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:country_picker/country_picker.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import 'package:avicare/temp/auth/signIn/page.dart';
import 'package:avicare/temp/homePage/page.dart';
import 'package:avicare/constants/colors.dart';
import 'package:avicare/screens/widget/build_text_field.dart';
import 'controller.dart';

class SignupScreen extends StatelessWidget {
  final controller = Get.put(SignupController());

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10.h),
                Text(
                  'Sign up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Welcome to App - Your Fitness Trainer App. Sign up to begin!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 32.h),
                BuildTextField(
                  controller: controller.fullNameController,
                  label: 'Full Name',
                  hint: 'Lorem',
                  prefixIcon: Icons.person_outline,
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Phone Number',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Container(
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Obx(() => TextButton(
                            onPressed: () {
                              showCountryPicker(
                                context: context,
                                showPhoneCode: true,
                                showWorldWide: true,
                                countryListTheme: CountryListThemeData(
                                  backgroundColor: Colors.black,
                                  textStyle: TextStyle(color: Colors.white),
                                ),
                                onSelect: (Country country) {
                                  controller.selectedCountry.value = country;
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '+${controller.selectedCountry.value.phoneCode}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                Icon(Icons.arrow_drop_down,
                                    color: Colors.black),
                              ],
                            ),
                          )),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: BuildTextField(
                        controller: controller.phoneController,
                        hint: '(---) --- ----',
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                BuildTextField(
                  controller: controller.emailController,
                  label: 'Email',
                  hint: '@example21',
                  prefixIcon: Icons.mail_outline,
                ),
                SizedBox(height: 16.h),
                BuildTextField(
                  controller: controller.passwordController,
                  label: 'Password',
                  hint: '************',
                  prefixIcon: Icons.lock,
                  isPassword: true,
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Obx(() => Checkbox(
                          value: controller.isChecked.value,
                          onChanged: (value) =>
                              controller.isChecked.value = value!,
                        )),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'By clicking this check box, you agree to our ',
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.sp),
                          children: [
                            TextSpan(
                              text: 'Terms & Conditions',
                              style: TextStyle(color: Colors.blue),
                            ),
                            TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                    ),
                    onPressed: controller.handleSignUp,
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                    ),
                    onPressed: () {
                      Get.offAll(() => MainScreen());
                    },
                    child: Text(
                      'Continue as guest',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.sp,
                      ),
                    ),
                    ZoomTapAnimation(
                      onTap: () {
                        Get.offAll(() => SignInScreen());
                      },
                      child: Text(
                        " Login",
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
      ),
    );
  }
}
