import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:avicare/screens/widget/progress_steps_indicator.dart';
import 'package:avicare/screens/exercise_screen/exercise_details_screen.dart';
import 'package:avicare/model/protocols.dart';
import 'package:avicare/model/exercise.dart';


class ExerciseList extends StatelessWidget {
  const ExerciseList({super.key, required this.exercises});

  final List<ExerciseDataHolder> exercises;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: exercises.length,
      itemBuilder: (context, index) => Container(
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
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
            // Image.network(
            //   'https://cdn.pixabay.com/photo/2017/07/02/19/24/dumbbells-2465478_1280.jpg',
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
                      exercises[index].name,
                      overflow: TextOverflow.ellipsis,
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
            ZoomTapAnimation(
              onTap: () async {
                try {
                  final exercise = await Exercise.fetchExerciseById(exercises[index].exerciseID);
                  Get.to(() => ExerciseDetailsScreen(exercise: exercise));
                } catch (e) {
                  Fluttertoast.showToast(msg: "Unexpected error occurred");
                }
              },
              child: Icon(
                Icons.arrow_forward,
                size: 20.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 15.w),
          ],
        ),
      ),
    );
  }
}

