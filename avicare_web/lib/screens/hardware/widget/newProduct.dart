import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/category_controller.dart';
import '../../widget/build_text_field.dart';
import '../../widget/fancy_dropdown.dart';
import '../../widget/image_picker.dart';
import '../../widget/parameters_screen.dart';

Widget newProduct() {
  final controller = Get.put(CategoryController());
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Colors.grey,
        width: 0.3.sp,
      ),
      borderRadius: BorderRadius.circular(15.r),
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0.0, 1.0), //(x,y)
          blurRadius: 3.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add new product',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          spacing: 140.w,
          children: [
            Column(
              spacing: 20.h,
              children: [
                buildTextField(
                  controller: controller.nameController,
                  label: "Product Name",
                  hint: "Enter name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                ),
                FancyDropdown(
                  title: "Exercises",
                  width: 392,
                  items: controller.items,
                  onChanged: (value) {
                    controller.selectedCategory.value = value;
                  },
                ),
                ParametersScreen(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 20.h,
              children: [
                FancyDropdown(
                  title: "Position",
                  width: 392,
                  items: controller.items,
                  onChanged: (value) {
                    controller.selectedCategory.value = value;
                  },
                ),
                FancyDropdown(
                  title: "Category",
                  width: 392,
                  items: controller.items,
                  onChanged: (value) {
                    controller.selectedCategory.value = value;
                  },
                ),
                SizedBox(
                  height: 100.h,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          )),
                      child: Text(
                        "Clear All",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          )),
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ).paddingSymmetric(horizontal: 20.w),
      ],
    ),
  );
}
