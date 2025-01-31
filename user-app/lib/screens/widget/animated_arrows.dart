import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/arrow_animation_controller.dart';

class AnimatedArrows extends StatelessWidget {
  final ArrowDirection direction;

  AnimatedArrows({
    super.key,
    this.direction = ArrowDirection.left,
    required this.controller,
  });

  final ArrowAnimationController controller;

  IconData _getArrowIcon() {
    switch (direction) {
      case ArrowDirection.left:
        return Icons.keyboard_arrow_left;
      case ArrowDirection.right:
        return Icons.keyboard_arrow_right;
      case ArrowDirection.up:
        return Icons.keyboard_arrow_up;
      case ArrowDirection.down:
        return Icons.keyboard_arrow_down;
    }
  }

  Matrix4 _getTransform(double offset) {
    switch (direction) {
      case ArrowDirection.left:
        return Matrix4.translationValues(offset, 0, 0);
      case ArrowDirection.right:
        return Matrix4.translationValues(-offset, 0, 0);
      case ArrowDirection.up:
        return Matrix4.translationValues(0, offset, 0);
      case ArrowDirection.down:
        return Matrix4.translationValues(0, -offset, 0);
    }
  }

  double _getBaseOffset() {
    switch (direction) {
      case ArrowDirection.left:
      case ArrowDirection.right:
        return 20.w;
      case ArrowDirection.up:
      case ArrowDirection.down:
        return 20.h;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.startAnimation(direction),
      child: Container(
        width: 100.w,
        height: 100.h,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // First Arrow
            Obx(
              () => AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: controller.arrowOpacity1.value,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  transform: _getTransform(controller.arrowOffset1.value),
                  child: Icon(
                    _getArrowIcon(),
                    size: 80.sp,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            // Second Arrow
            Obx(
              () => AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: controller.arrowOpacity2.value,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  transform: _getTransform(
                      _getBaseOffset() + controller.arrowOffset2.value),
                  child: Icon(
                    _getArrowIcon(),
                    size: 80.sp,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            // Third Arrow
            Obx(
              () => AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: controller.arrowOpacity3.value,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  transform: _getTransform(
                      _getBaseOffset() * 2 + controller.arrowOffset3.value),
                  child: Icon(
                    _getArrowIcon(),
                    size: 80.sp,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
