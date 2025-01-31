import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget bottomSheetButton({
  required String text,
  required VoidCallback onTap,
  Color? color,
  Color? buttonColor,
  Color? textColor,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
    color: color ?? Colors.black,
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        backgroundColor: buttonColor ?? Colors.white,
      ),
      onPressed: () {
        onTap();
      },
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? Colors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
