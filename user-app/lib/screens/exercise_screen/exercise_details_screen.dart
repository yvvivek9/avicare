import 'package:avicare/screens/widget/fancy_dropdown.dart';
import 'package:avicare/screens/widget/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../widget/timeline_widget.dart';

import '../bio_feedback_screen.dart';
import 'package:avicare/model/exercise.dart';

class ExerciseDetailsController extends GetxController {
  RxBool isExpanded = false.obs;
  RxInt maxLines = 3.obs;
  RxInt selectedSet = 1.obs;
  RxString selectedColor = ''.obs;
  String? videoId;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    videoId = YoutubePlayer.convertUrlToId(
        "https://youtu.be/ZN7vuBKYTHg?si=YziBMwZJf1wNnjlw")!;
  }

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }
}

class ExerciseDetailsScreen extends StatelessWidget {
  ExerciseDetailsScreen({super.key, required this.exercise});

  final Exercise exercise;
  final ExerciseDetailsController controller =
      Get.put(ExerciseDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                YoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId: YoutubePlayer.convertUrlToId(exercise.youtube) ?? "",
                    flags: YoutubePlayerFlags(
                      autoPlay: false,
                      mute: false,
                    ),
                  ),
                  showVideoProgressIndicator: true,
                ),
                Positioned(
                  top: 16.h,
                  left: 16.w,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Get.back(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and description
                  Text(
                    exercise.name,
                    // "Power Jacks: Energize Your Body",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Last Update 2 days ago",
                    style: TextStyle(fontSize: 12.sp, color: Colors.blue),
                  ),
                  SizedBox(height: 8.h),
                  Obx(
                    () => Text(
                      exercise.description,
                      // "'Jumping Jack Exercise' is your ultimate high-energy fitness program designed to elevate your heart rate, "
                      // "build stamina, and tone your body—all with the simplicity of a timeless workout move.",
                      style: TextStyle(fontSize: 14.sp, color: Colors.white),
                      maxLines: controller.maxLines.value,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ZoomTapAnimation(
                    onTap: () {
                      controller.maxLines.value =
                          controller.maxLines.value == 3 ? 10 : 3;
                    },
                    child: Text(
                      "See More",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  GestureDetector(
                    onTap: controller.toggleExpanded,
                    child: Row(
                      children: [
                        Text(
                          "How to Do It",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Obx(() => Icon(
                              controller.isExpanded.value
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // Collapsed/Expanded instructions
                  Obx(() => AnimatedSize(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: controller.isExpanded.value
                            ? TimelineWidget()
                            : SizedBox(),
                      )),
                  Divider(color: Colors.grey, height: 32.h),
                  // Dropdowns and Start Exercise button
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Select Band Color *",
                          style:
                              TextStyle(fontSize: 14.sp, color: Colors.white)),
                      SizedBox(height: 8.h),
                      FancyDropdown(
                          items: [
                            "Red",
                            "Blue",
                            "Green",
                            "Yellow",
                            "Black",
                          ],
                          width: 325.w,
                          onChanged: (value) {
                            controller.selectedColor.value = value;
                          }),
                      SizedBox(height: 16.h),
                      Text("Select number of sets *",
                          style:
                              TextStyle(fontSize: 14.sp, color: Colors.white)),
                      SizedBox(height: 8.h),
                      FancyDropdown(
                        width: 325.w,
                        items: [
                          "1",
                          "2",
                          "3",
                          "4",
                          "5",
                          "6",
                          "7",
                          "8",
                          "9",
                          "10"
                        ],
                        onChanged: (value) {
                          controller.selectedSet.value = int.parse(value);
                        },
                      ),
                      SizedBox(height: 32.h),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(() => BioFeedbackScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.r)),
                          minimumSize: Size(double.infinity, 48.h),
                        ),
                        child: Text(
                          "Start Exercise",
                          style:
                              TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 150.h),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _instructionItem(String title, [String? description]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.circle, size: 10.w, color: Colors.blue),
              SizedBox(width: 8.w),
              Text(title,
                  style: TextStyle(fontSize: 14.sp, color: Colors.white)),
            ],
          ),
          if (description != null) ...[
            SizedBox(height: 4.h),
            Padding(
              padding: EdgeInsets.only(left: 18.w),
              child: Text(
                description,
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
