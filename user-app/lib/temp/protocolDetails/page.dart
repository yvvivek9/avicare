import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../screens/widget/icon_button.dart';
import '../../screens/widget/progress_steps_indicator.dart';

import 'package:avicare/temp/homePage/secondPage/widgets.dart';
import 'controller.dart';

class ProtocolDetails extends StatelessWidget {
  ProtocolDetails(
      {super.key, required this.protocolName}) {
    controller.fetchProtocolDetails(protocolName);
  }

  final String protocolName;
  final controller = Get.put(ProtocolDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.h,
        backgroundColor: Colors.black,
        title: Text(
          "Exercises",
          style: TextStyle(color: Colors.white),
        ),
        leading: backButton(onTap: () {
          Get.back();
        }),
        actions: [
          Row(
            children: [
              ZoomTapAnimation(
                onTap: () {},
                child: Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: 0.5.w,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      size: 18.sp,
                      color: Colors.white,
                      Icons.more_horiz_outlined,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Obx(() => Text(
                controller.protocol.value.name,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Obx(() => Text(
                "( ${controller.protocol.value.exercises.length} Exercises )",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey,
                ),
              )),
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(child: Obx(() => ExerciseList(exercises: controller.protocol.value.exercises))),
          ],
        ),
      ),
    );
  }
}
