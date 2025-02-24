import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controller/parameter_controller.dart';

class ParametersScreen extends StatelessWidget {
  final controller = Get.put(ParametersController());

  ParametersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 392.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Parameters',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          // Input field with Add button
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.textController,
                    decoration: InputDecoration(
                      hintText: 'Type here',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(4.w),
                  child: ElevatedButton(
                    onPressed: controller.addParameter,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 12.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        )),
                    child: Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          // Dynamic parameter chips
          Obx(() => Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: controller.parameters
                    .map((parameter) => _buildChip(parameter))
                    .toList(),
              )),
        ],
      ),
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.grey[350],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14.sp),
          ),
          SizedBox(width: 4.w),
          GestureDetector(
            onTap: () => controller.removeParameter(label),
            child: Icon(Icons.close, size: 16.sp),
          ),
        ],
      ),
    );
  }
}
