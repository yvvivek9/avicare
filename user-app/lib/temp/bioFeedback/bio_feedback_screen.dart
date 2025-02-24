import 'package:avicare/controller/arrow_animation_controller.dart';
import 'package:avicare/screens/widget/animated_arrows.dart';
import 'package:avicare/screens/extra_screens/workout_completed_screen.dart';
import 'package:avicare/screens/widget/form_hint_widget.dart';
import 'package:avicare/screens/widget/icon_button.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import 'bio_feedback_controller.dart';
import 'dart:math' as math;

class BioFeedbackScreen extends StatelessWidget {
  BioFeedbackScreen({super.key});

  final controller = Get.put(BioFeedbackController());
  final leftArrowController = Get.put(ArrowAnimationController(), tag: "left");
  final rightArrowController = Get.put(ArrowAnimationController(), tag: "right");
  final topArrowController = Get.put(ArrowAnimationController(), tag: "top");
  final bottomArrowController = Get.put(ArrowAnimationController(), tag: "bottom");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: controller.requestCameraPermission(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == true) {
                controller.initializeCamera();
                return Obx(() {
                  if (controller.isCameraInitialized.value) {
                    return Stack(
                      children: [
                        SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: CameraPreview(
                            controller.cameraController,
                            child: controller.customPaint.value,
                          ),
                        ),
                        Positioned(
                          top: 50.h,
                          left: 16.w,
                          child: ZoomTapAnimation(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10.w),
                              width: 44.w,
                              height: 44.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.5),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 50.w,
                          right: 16.w,
                          child: ZoomTapAnimation(
                            onTap: () {
                              controller.isMenuOpen.value = !controller.isMenuOpen.value;
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10.w),
                              width: 44.w,
                              height: 44.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.5),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.more_horiz,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 307.h,
                          left: 0,
                          child: Container(
                            height: 273.h,
                            width: 76.w,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50.r),
                                bottomRight: Radius.circular(50.r),
                              ),
                            ),
                            child: Stack(
                              children: [
                                // _buildDegreeSelector(),
                                // _buildInfoBox('Reps', controller.leftReps.value),
                                // _buildInfoBox2('Hold\nTime', '${controller.leftHoldTime}s'),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 398.h,
                          left: 11.w,
                          child: _buildInfoBox('Reps', controller.leftReps.value),
                        ),
                        Positioned(
                          top: 476.h,
                          left: 11.w,
                          child: _buildInfoBox2('Hold\nTime', '${controller.leftHoldTime}s'),
                        ),
                        Positioned(top: 321.h, left: 11.w, child: _buildDegreeSelector(controller.leftCurrentDegree.value)),
                        Positioned(
                          top: 307.h,
                          right: 0,
                          child: Container(
                            height: 273.h,
                            width: 76.w,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50.r),
                                bottomLeft: Radius.circular(50.r),
                              ),
                            ),
                            child: Stack(
                              children: [
                                // _buildDegreeSelector(),
                                // _buildInfoBox('Reps', controller.leftReps.value),
                                // _buildInfoBox2('Hold\nTime', '${controller.leftHoldTime}s'),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 398.h,
                          right: 11.w,
                          child: _buildInfoBox('Reps', controller.rightReps.value),
                        ),
                        Positioned(
                          top: 476.h,
                          right: 11.w,
                          child: _buildInfoBox2('Hold\nTime', '${controller.rightHoldTime}s'),
                        ),
                        Positioned(
                          top: 321.h,
                          right: 11.w,
                          child: _buildDegreeSelector(
                            controller.rightCurrentDegree.value,
                          ),
                        ),
                        Positioned(
                          top: 70.h,
                          left: 148.h,
                          child: _buildTimer(),
                        ),
                        Positioned(
                          top: 185.h,
                          left: 30.w,
                          child: SizedBox(
                            height: 20.h,
                            width: 325.w,
                            child: _buildPressureIndicators(),
                          ),
                        ),
                        Positioned(
                          top: 0.h,
                          right: 0,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            width: controller.isMenuOpen.value ? 207.w : 0,
                            height: controller.isMenuOpen.value ? 430.h : 0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: menuBar(),
                          ),
                        ),
                        Positioned(
                          top: 400.h,
                          left: 75.w,
                          child: AnimatedArrows(
                            controller: leftArrowController,
                          ),
                        ),
                        Positioned(
                          top: 400.h,
                          left: 200.w,
                          child: AnimatedArrows(
                            controller: rightArrowController,
                            direction: ArrowDirection.right,
                          ),
                        ),
                        Positioned(
                          top: 350.h,
                          left: 150.w,
                          child: AnimatedArrows(
                            controller: topArrowController,
                            direction: ArrowDirection.up,
                          ),
                        ),
                        Positioned(
                          top: 450.h,
                          left: 150.w,
                          child: AnimatedArrows(
                            controller: bottomArrowController,
                            direction: ArrowDirection.down,
                          ),
                        ),
                        Positioned(
                          left: 11.w,
                          bottom: 135.h,
                          child: FormHintWidget(text: "Adjust your form: lower your hips slightly."),
                        ),
                        Positioned(
                          bottom: 10.h,
                          right: 10.w,
                          child: IconButton(
                            onPressed: controller.changeCamera,
                            enableFeedback: true,
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.black.withAlpha(150),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            icon: Icon(Icons.camera_rear, size: 30.h),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                });
              } else {
                return Center(child: Text('Camera permission denied'));
              }
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget _buildDegreeSelector(int value) {
    return Container(
      height: 90.h,
      width: 60.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.black.withValues(alpha: 0.3),
              Colors.black.withValues(alpha: 0.3),
              Colors.black,
            ],
          )),
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildDegreeText(value + 1, Colors.grey, -25.h),
          _buildDegreeText(value, Colors.greenAccent, 0),
          _buildDegreeText(value - 1, Colors.grey, 25.h),
        ],
      ),
    );
  }

  Widget _buildDegreeText(int value, Color color, double offset) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      top: 30.h + offset,
      child: Row(
        children: [
          SizedBox(width: 10.w),
          Text(
            '$value°',
            style: TextStyle(
              color: color,
              fontSize: 23.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(String label, dynamic value) {
    return Container(
      height: 90.h,
      width: 60.w,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.r,
        ),
        color: Colors.black.withValues(alpha: 0.42),
        borderRadius: BorderRadius.all(Radius.circular(100.r)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox2(String label, dynamic value) {
    return Container(
      height: 90.h,
      width: 60.w,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(100.r)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
            ),
          ),
          Text(
            value.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimer() {
    return Obx(
      () => Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 96.w,
            height: 96.w,
            child: CustomPaint(
              painter: TimerPainter(
                progress: controller.progress.value,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                controller.timeRemaining.value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              GestureDetector(
                onTap: controller.toggleTimer,
                child: Icon(
                  controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 32.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPressureIndicators() {
    return Obx(() => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              textAlign: TextAlign.center,
              'Force:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(width: 10.w),
            Container(
              width: 256.w,
              height: 24.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: Colors.grey[800],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildPressureBar(
                    isLeft: true,
                    value: controller.leftPressure.value,
                  ),
                  SizedBox(width: 5.w),
                  _buildPressureBar(
                    isLeft: false,
                    value: controller.rightPressure.value,
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildPressureBar({required bool isLeft, required double value}) {
    return Expanded(
      child: Container(
        height: 24.h,
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: Colors.grey[800],
        ),
        child: Row(
          children: [
            Container(
              width: 18.w,
              height: 18.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: Center(
                child: Text(
                  isLeft ? 'L' : 'R',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: LinearProgressIndicator(
                  value: value,
                  minHeight: 16.h,
                  backgroundColor: Colors.grey[600],
                  valueColor: AlwaysStoppedAnimation(
                    isLeft ? Colors.blue : Colors.grey[400],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menuBar() {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Align(
          alignment: Alignment.centerLeft,
          child: backButton(
            color: Colors.black,
            onTap: () {
              controller.isMenuOpen.value = false;
            },
          ),
        ),
        menuButton(label: "Profile", icon: Icons.person, onTap: () {}),
        menuButton(label: "Band Health", icon: Icons.health_and_safety, onTap: () {}),
        menuButton(
          label: "Band Colours",
          icon: Icons.color_lens,
          onTap: () {},
        ),
        menuButton(
          label: "Calliberate",
          icon: Icons.connect_without_contact,
          onTap: () {},
        ),
        SizedBox(height: 70.h),
        Container(
          height: 40.h,
          color: Colors.white,
          width: 178,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
            onPressed: () {
              Get.off(() => WorkoutCompletionScreen(duration: 30, reps: 47));
            },
            child: Text(
              "Finish Workout",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget menuButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        height: 50.h,
        width: 200.w,
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black,
              size: 32.sp,
            ),
            SizedBox(width: 10.w),
            Text(
              label,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  final double progress;

  TimerPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    // Background circle
    final bgPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(TimerPainter oldDelegate) => progress != oldDelegate.progress;
}
