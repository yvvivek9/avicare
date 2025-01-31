import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TimelineController extends GetxController {
  var completedStep = 0.obs; // Tracks the last completed step
}

class TimelineWidget extends StatelessWidget {
  final TimelineController controller = Get.put(TimelineController());

  final List<Map<String, String>> steps = [
    {
      "title": "Spread Your Arms",
      "description":
          "To make the gestures feel more relaxed, stretch your arms as you start this movement. No bending of hands."
    },
    {
      "title": "Rest at the Toe",
      "description":
          "Place your body weight on your toes and balance carefully."
    },
    {
      "title": "Adjust Foot Movement",
      "description":
          "Ensure smooth and relaxed foot movements for better stability."
    },
    {
      "title": "Clapping Both Hands",
      "description": "Clap your hands together to complete the action."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: steps.length,
      itemBuilder: (context, index) {
        return Obx(() {
          {
            bool isCompleted = index <= controller.completedStep.value;
            return TimelineTile(
              isFirst: index == 0,
              isLast: index == steps.length - 1,
              beforeLineStyle: LineStyle(
                color: isCompleted ? Colors.blue : Colors.grey,
                thickness: 2.w,
              ),
              afterLineStyle: LineStyle(
                color: isCompleted ? Colors.blue : Colors.grey,
                thickness: 2.w,
              ),
              indicatorStyle: IndicatorStyle(
                width: 20.w,
                color: isCompleted ? Colors.blue : Colors.grey,
                indicatorXY: 0.5,
              ),
              endChild: GestureDetector(
                onTap: () {
                  controller.completedStep.value = index;
                },
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  margin: EdgeInsets.only(bottom: 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        steps[index]["title"]!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        steps[index]["description"]!,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
      },
    );
  }
}
