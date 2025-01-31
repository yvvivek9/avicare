import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget bottomSheetIconButton({
  required void Function() onTap,
  Color? color,
  required String text,
  IconData? icon,
}) {
  return Container(
    color: Colors.black,
    child: ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: 6.h,
          horizontal: 10.w,
        ),
      ),
      onPressed: onTap,
      icon: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
      label: Container(
        height: 50.w,
        width: 50.w,
        padding: EdgeInsets.all(15.w),
        margin: EdgeInsets.only(left: 30.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color ?? Colors.white.withValues(alpha: 0.8),
        ),
        child: ImageIcon(
          AssetImage("assets/images/arrow.png"),
          color: Colors.black,
          size: 15.sp,
        ),
      ),
    ),
  );
}
