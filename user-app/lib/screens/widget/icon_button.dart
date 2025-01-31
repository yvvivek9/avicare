import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

Widget backButton({
  required dynamic Function()? onTap,
  Color? color,
}) {
  return ZoomTapAnimation(
    onTap: () {
      onTap!();
    },
    child: Container(
      margin: EdgeInsets.only(left: 10.w),
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: color ?? Colors.white.withOpacity(0.5),
          width: 0.8.w,
        ),
      ),
      child: Center(
          child: Icon(
        Icons.arrow_back_ios_new,
        color: color ?? Colors.white,
      )),
    ),
  );
}
