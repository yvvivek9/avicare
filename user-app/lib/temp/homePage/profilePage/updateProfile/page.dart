import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:avicare/model/user.dart';
import 'widgets.dart';
import 'controller.dart';

class UpdateProfilePage extends StatelessWidget {
  UpdateProfilePage({super.key, required this.user}) {
    controller.user = user;
    controller.userType.text = "User";
    controller.gender.text = user.gender ?? "";
    controller.dob.text = user.dob ?? "";
    if(user.weight != null) {
      final split = user.weight!.split(" ");
      controller.weight.text = split[0];
      controller.weightUnit.value = split[1];
    }
    if(user.height != null) {
      final split = user.height!.split(" ");
      controller.height.text = split[0];
      controller.heightUnit.value = split[1];
    }
  }

  final controller = Get.put(UpdateProfileController());
  final User user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: SizedBox(
            width: 340.w,
            child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40.h),
                Text(
                  'Update Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Keep your profile updated for optimal results.",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 40.h),
                CustomDropDown(
                  controller: controller.userType,
                  width: 340.w,
                  leading: Icons.person,
                  title: "User Type",
                  options: ["User", "Doctor", "Staff"],
                ),
                SizedBox(height: 15.h),
                CustomDropDown(
                  controller: controller.gender,
                  width: 340.w,
                  leading: Icons.person,
                  title: "Gender",
                  options: ["Male", "Female"],
                ),
                SizedBox(height: 15.h),
                CustomDatePicker(
                  controller: controller.dob,
                  title: "Birth Date",
                  placeholder: "-Select-",
                  width: 340.w,
                  leading: Icons.calendar_today,
                ),
                SizedBox(height: 15.h),
                CustomInputWithUnit(
                  controller: controller.weight,
                  width: 340.w,
                  leading: Icons.monitor_weight,
                  title: "Your weight",
                  units: ["kgs", "lbs"],
                  selectedUnit: controller.weightUnit.value,
                  onUnitChange: (unit) => controller.weightUnit.value = unit,
                  info: "*kgs is selected as default measure, tap to change",
                  placeholder: "Please enter your weight",
                ),
                SizedBox(height: 15.h),
                CustomInputWithUnit(
                  controller: controller.height,
                  width: 340.w,
                  leading: Icons.height,
                  title: "Your height",
                  units: ["cm", "inch", "ft"],
                  selectedUnit: controller.heightUnit.value,
                  onUnitChange: (unit) => controller.heightUnit.value = unit,
                  info: "*cm is selected as default measure, tap to change",
                  placeholder: "Please enter your height",
                ),
                SizedBox(height: 30.h),
                ElevatedButton(
                  onPressed: controller.handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(double.infinity, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                  ),
                  child: Text(
                    'Update Profile',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
