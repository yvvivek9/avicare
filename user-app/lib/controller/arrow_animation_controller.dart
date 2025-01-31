import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ArrowDirection { left, right, up, down }

class ArrowAnimationController extends GetxController {
  final arrowOpacity1 = 0.0.obs;
  final arrowOpacity2 = 0.0.obs;
  final arrowOpacity3 = 0.0.obs;
  final arrowOffset1 = 0.0.obs;
  final arrowOffset2 = 0.0.obs;
  final arrowOffset3 = 0.0.obs;

  void startAnimation(ArrowDirection direction) {
    // Reset values
    arrowOpacity1.value = 0.0;
    arrowOpacity2.value = 0.0;
    arrowOpacity3.value = 0.0;
    arrowOffset1.value = 0.0;
    arrowOffset2.value = 0.0;
    arrowOffset3.value = 0.0;

    // Animate first arrow (highest opacity)
    Future.delayed(const Duration(milliseconds: 0), () {
      arrowOpacity1.value = 1.0;
      arrowOffset1.value = -20.0;
    });

    // Animate second arrow (medium opacity)
    Future.delayed(const Duration(milliseconds: 200), () {
      arrowOpacity2.value = 0.7;
      arrowOffset2.value = -20.0;
    });

    // Animate third arrow (lowest opacity)
    Future.delayed(const Duration(milliseconds: 400), () {
      arrowOpacity3.value = 0.4;
      arrowOffset3.value = -20.0;
    });

    // Reset animation after completion
    Future.delayed(const Duration(milliseconds: 1000), () {
      arrowOpacity1.value = 0.0;
      arrowOpacity2.value = 0.0;
      arrowOpacity3.value = 0.0;
      arrowOffset1.value = 0.0;
      arrowOffset2.value = 0.0;
      arrowOffset3.value = 0.0;
    });
  }
}
