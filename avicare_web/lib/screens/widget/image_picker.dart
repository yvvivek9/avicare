import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget imagePicker(Color? border) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Image",
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      DottedBorder(
        color: border ?? Colors.black.withValues(alpha: 0.13),
        radius: Radius.circular(50.r),
        child: SizedBox(
          width: 392.w,
          height: 120.h,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/upload_icon.png",
                  height: 30.h,
                ),
                Text(
                  "Drag and drop your file here",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10.sp,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
