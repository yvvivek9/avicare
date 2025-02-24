import 'package:avicare_web/screens/widget/action_buttons.dart';
import 'package:avicare_web/screens/widget/fancy_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ParameterController extends GetxController {
  final selectedRowIndex = RxnInt();

  void toggleParameterView(int index) {
    if (selectedRowIndex.value == index) {
      selectedRowIndex.value = null;
    } else {
      selectedRowIndex.value = index;
    }
  }
}

class HardwareTableRow extends StatelessWidget {
  final int index;
  final double size;
  final ParameterController controller;

  const HardwareTableRow({
    required this.index,
    required this.size,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: size.w,
                child: FancyDropdown(
                  hint: "Product",
                  items: ['Product'],
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: 20.w),
              SizedBox(
                width: size.w,
                child: FancyDropdown(
                  hint: "Categories",
                  items: ['Categories'],
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: 20.w),
              SizedBox(
                width: size.w,
                child: FancyDropdown(
                  hint: "Exercise",
                  items: ['Exercise'],
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: 20.w),
              Obx(
                () => SizedBox(
                  width: size.w,
                  child: GestureDetector(
                    onTap: () => controller.toggleParameterView(index),
                    child: Container(
                      width: size.w,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: controller.selectedRowIndex.value == index
                              ? Colors.blue
                              : Colors.black.withValues(alpha: 0.13),
                          width: 1.5,
                        ),
                        boxShadow: controller.selectedRowIndex.value == index
                            ? [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                )
                              ]
                            : null,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 10.w),
                              Text(
                                'Parameters',
                                style: TextStyle(
                                  color:
                                      controller.selectedRowIndex.value == index
                                          ? Colors.blue
                                          : Colors.black,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              AnimatedRotation(
                                duration: const Duration(milliseconds: 200),
                                turns:
                                    controller.selectedRowIndex.value == index
                                        ? 0.5
                                        : 0,
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color:
                                      controller.selectedRowIndex.value == index
                                          ? Colors.blue
                                          : Colors.black,
                                  size: 24.sp,
                                ),
                              ),
                              SizedBox(width: 15.w),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              SizedBox(
                width: ((size * 2) + 40).w,
                child: Center(child: ActionButtons(update: "Update")),
              ),
            ],
          ),
        ),
        Obx(
          () => controller.selectedRowIndex.value == index
              ? _buildParameterStack()
              : const SizedBox(),
        ),
      ],
    );
  }

  Widget _buildParameterStack() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Align(
        alignment: Alignment.centerRight,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 400.w,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ... keep existing parameter stack content unchanged ...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select the parameters',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, size: 20),
                      onPressed: () => controller.toggleParameterView(index),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Body part', style: TextStyle(fontSize: 14.sp)),
                          SizedBox(height: 5.h),
                          Container(
                            height: 40.h,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: 'Left Leg',
                                isExpanded: true,
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                items: ['Left Leg']
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e,
                                              style:
                                                  TextStyle(fontSize: 14.sp)),
                                        ))
                                    .toList(),
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Position', style: TextStyle(fontSize: 14.sp)),
                          SizedBox(height: 5.h),
                          Container(
                            height: 40.h,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: 'Standing',
                                isExpanded: true,
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                items: ['Standing']
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e,
                                              style:
                                                  TextStyle(fontSize: 14.sp)),
                                        ))
                                    .toList(),
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Text('Parameter measure', style: TextStyle(fontSize: 14.sp)),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: 'Angle',
                            isExpanded: true,
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            items: ['Angle']
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e,
                                          style: TextStyle(fontSize: 14.sp)),
                                    ))
                                .toList(),
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: 'Distance',
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          items: ['Distance']
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e,
                                        style: TextStyle(fontSize: 14.sp)),
                                  ))
                              .toList(),
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: 'Time',
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          items: ['Time']
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e,
                                        style: TextStyle(fontSize: 14.sp)),
                                  ))
                              .toList(),
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline, color: Colors.blue),
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                    IconButton(
                      icon:
                          Icon(Icons.remove_circle_outline, color: Colors.grey),
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Container(
                      height: 40.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      alignment: Alignment.centerLeft,
                      child: Text('30°', style: TextStyle(fontSize: 14.sp)),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      height: 40.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      alignment: Alignment.centerLeft,
                      child: Text('45 cms', style: TextStyle(fontSize: 14.sp)),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      height: 40.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      alignment: Alignment.centerLeft,
                      child: Text('20 sec', style: TextStyle(fontSize: 14.sp)),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: Size(80.w, 40.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () => controller.toggleParameterView(index),
                    child: Text('Save', style: TextStyle(fontSize: 14.sp)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget hardwareTableListItem() {
  final controller = Get.put(ParameterController());
  final size = 140.0;

  return Column(
    children: List.generate(
      4,
      (index) => HardwareTableRow(
        index: index,
        size: size,
        controller: controller,
      ),
    ),
  );
}
