import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../widget/icon_button.dart';
import '../widget/progress_steps_indicator.dart';

class ExerciseScreen2 extends StatelessWidget {
  const ExerciseScreen2(
      {super.key, required this.title, required this.numberOfExercises});

  final String title;
  final int numberOfExercises;

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
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "( $numberOfExercises Exercises )",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(child: _buildExerciseList()),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseList() {
    return ListView.builder(
      itemCount: numberOfExercises,
      itemBuilder: (context, index) => _buildExerciseItem(),
    );
  }

  Widget _buildExerciseItem() {
    return Container(
      height: 80.h,
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff898989).withValues(alpha: 0),
            Color(0xffefefef).withValues(alpha: 0.4),
          ],
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl:
                'https://firebasestorage.googleapis.com/v0/b/blue-bit-simple.appspot.com/o/gym.jpeg?alt=media&token=e786b8ca-0d6c-4df9-9648-281ab2ef9877',
            imageBuilder: (context, imageProvider) {
              return Container(
                height: 80.h,
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) {
              print("error fetching image is : $error");
              Get.snackbar("Error", error.toString());
              return Icon(Icons.error);
            },
            fit: BoxFit.cover,
          ),
          // Image.network(
          //   'https://firebasestorage.googleapis.com/v0/b/blue-bit-simple.appspot.com/o/gym.jpeg?alt=media&token=e786b8ca-0d6c-4df9-9648-281ab2ef9877',
          //   height: 80.h,
          //   width: 100.w,
          //   fit: BoxFit.cover,
          // ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Knee extension',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    '3:00 pm - 3:45 pm',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  ProgressStepsIndicator(totalSteps: 4, currentStep: 3),
                ],
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward,
            size: 20.sp,
            color: Colors.white,
          ),
          SizedBox(width: 15.w),
        ],
      ),
    );
  }
}
