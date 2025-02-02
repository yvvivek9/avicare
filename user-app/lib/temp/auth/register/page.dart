import 'package:avicare/temp/homePage/page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:avicare/screens/widget/build_text_field.dart';
import 'package:avicare/screens/widget/fancy_dropdown.dart';

import 'controller.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final controller = Get.put<ProfileController>(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: SizedBox(
            width: 340.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50.h),
                Text(
                  'Create Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Let's Complete Your Profile. Come to Home",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 40.h),
                FancyDropdown(
                  prefixIcon: Icons.person_outline,
                  items: ['User', 'Doctor', 'Staff'],
                  onChanged: controller.setUserType,
                  width: 325.w,
                  hint: "-Select-",
                  title: "User Type",
                ),
                FancyDropdown(
                  prefixIcon: Icons.person_outline,
                  items: ["Male", "Female", "Other"],
                  onChanged: controller.setGender,
                  hint: "Gender",
                  width: 325.w,
                  title: "Gender",
                ),
                SizedBox(height: 5.h),
                _buildDatePicker(),
                _buildMeasurementField(
                  prefixIcon: Icons.monitor_weight_outlined,
                  label: 'Your Weight',
                  units: ['kgs', 'pound'],
                  onValueChanged: controller.setWeight,
                  onUnitChanged: controller.toggleWeightUnit,
                  controller: controller.weightUnit,
                  suffix: '(${controller.weightUnit})',
                ),
                _buildMeasurementField(
                  prefixIcon: Icons.height_outlined,
                  label: 'Your Height',
                  units: ['cm', 'inch', 'foot'],
                  onValueChanged: controller.setHeight,
                  onUnitChanged: controller.toggleHeightUnit,
                  controller: controller.heightUnit,
                  suffix: '(${controller.heightUnit})',
                ),
                SizedBox(height: 10.h),
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
                    'Create Profile',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Birth Date',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: Get.context!,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (date != null) controller.setBirthDate(date);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 20.w,
                  color: Colors.grey,
                ),
                SizedBox(width: 8.w),
                Obx(() {
                  final date = controller.birthDate.value;
                  return Text(
                    date != null
                        ? '${date.day} ${_getMonth(date.month)}, ${date.year}'
                        : '23 May, 2000',
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                  );
                }),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildMeasurementField({
    required IconData prefixIcon,
    required String label,
    required List<String> units,
    required Function(String) onValueChanged,
    required Function(String) onUnitChanged,
    required RxString controller,
    required String suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Stack(
          children: [
            BuildTextField(
              prefixIcon: prefixIcon,
              controller: TextEditingController(),
              hint: 'Please enter ${label.toLowerCase()}',
              keyboardType: TextInputType.number,
              radius: 20,
              onChanged: onValueChanged,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter ${label.toLowerCase()}';
                }
                return null;
              },
            ),
            Positioned(
              top: 1.h,
              right: 0.w,
              child: FancyDropdown(
                items: units,
                onChanged: onUnitChanged,
                width: 95.w,
                hint: suffix,
                border: false,
              ),
            ),
          ],
        ),
        if (units.contains('cm')) ...[
          SizedBox(height: 4.h),
          Text(
            '*${units[0]} is selected as a default measure',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 12.sp,
            ),
          ),
        ],
        if (units.contains('kgs')) ...[
          SizedBox(height: 4.h),
          Text(
            '*${units[0]} is selected as a default measure',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 12.sp,
            ),
          ),
        ],
        SizedBox(height: 16.h),
      ],
    );
  }

  String _getMonth(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}
