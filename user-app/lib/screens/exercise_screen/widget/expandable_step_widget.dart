import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ExpandableStepsController extends GetxController {
  var isExpanded = false.obs;
  var selectedStep = 3.obs;

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  void selectStep(int index) {
    selectedStep.value = index;
  }
}

class ExpandableSteps extends StatelessWidget {
  final ExpandableStepsController controller =
      Get.put(ExpandableStepsController());

  final List<String> titles = [
    "Spread Your Arms",
    "Rest at the Toe",
    "Adjust Foot Movement",
    "Clapping Both Hands",
  ];

  final List<String> descriptions = [
    "To make the gestures feel more relaxed, stretch your arms as you start this movement. No bending of hands.",
    "",
    "",
    "",
  ];

  ExpandableSteps({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: controller.isExpanded.value ? 400.h : 100.h,
          width: 300.w,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: controller.toggleExpanded,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "How to Do It",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      controller.isExpanded.value
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.builder(
                  itemCount: titles.length,
                  itemBuilder: (context, index) {
                    final isSelected = controller.selectedStep.value == index;
                    return GestureDetector(
                      onTap: () => controller.selectStep(index),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 12.w,
                                height: 12.w,
                                decoration: BoxDecoration(
                                  color:
                                      isSelected ? Colors.blue : Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              if (index < titles.length - 1)
                                Container(
                                  width: 2.w,
                                  height: 40.h,
                                  color: isSelected ? Colors.blue : Colors.grey,
                                ),
                            ],
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  titles[index],
                                  style: TextStyle(
                                    color:
                                        isSelected ? Colors.blue : Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                                if (controller.isExpanded.value &&
                                    isSelected &&
                                    descriptions[index].isNotEmpty)
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.h),
                                    child: Text(
                                      descriptions[index],
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
