import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressStepsIndicator extends StatelessWidget {
  final int totalSteps;
  final int currentStep;

  const ProgressStepsIndicator({
    super.key,
    required this.totalSteps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final isCompleted = index < currentStep;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Progress bar
                Container(
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: isCompleted ? Colors.blue : Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                // Circular indicator
                Container(
                  width: 15.w,
                  height: 15.w, // Using width for perfect circle
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted ? Colors.blue : Colors.grey,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.w,
                    ),
                  ),
                  child: Icon(
                    Icons.check,
                    size: 10.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
