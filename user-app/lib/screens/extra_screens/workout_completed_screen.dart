import 'package:avicare/controller/workout_completed_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class WorkoutCompletionScreen extends StatelessWidget {
  final int duration;
  final int reps;

  WorkoutCompletionScreen({
    Key? key,
    required this.duration,
    required this.reps,
  }) : super(key: key);

  final controller = Get.put(WorkoutCompletionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Background elements
            // _buildConfetti(),

            // Main content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 60.h),
                  _buildCongratulationsContent(),
                  Spacer(),
                  _buildActionButtons(),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCongratulationsContent() {
    return Column(
      children: [
        SizedBox(
          height: 200.h,
          child: Obx(() {
            if (!controller.isVideoInitialized.value) {
              return CircularProgressIndicator();
            }
            return AspectRatio(
              aspectRatio: controller.videoController.value.aspectRatio,
              child: VideoPlayer(controller.videoController),
            );
          }),
        ),
        Text(
          'Congratulations, You Have Finished Your Workout',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          'Congratulations on powering through your workout! You\'ve shown incredible strength and determination—keep up the great work!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 50.h),
        _buildStats(),
      ],
    );
  }

  Widget _buildStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStatItem(
          icon: Icons.timer,
          value: duration.toString(),
          label: 'Minute',
          color: Colors.orange,
        ),
        SizedBox(width: 40.w),
        _buildStatItem(
          icon: Icons.fitness_center,
          value: reps.toString(),
          label: 'Reps',
          color: Colors.blue,
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24.sp),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[800],
              padding: EdgeInsets.symmetric(vertical: 15.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            onPressed: () => Get.back(),
            child: Text(
              'Back to home',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(vertical: 15.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            onPressed: () {
              // Implement report functionality
            },
            child: Text(
              'Report',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
