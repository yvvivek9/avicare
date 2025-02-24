import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget hardwareTableHeading() {
  final size = 160;
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: size.w,
        child: Text(
          'Product',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.sp,
          ),
        ),
      ),
      SizedBox(
        width: size.w,
        child: Text(
          'Categories',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.sp,
          ),
        ),
      ),
      SizedBox(
        width: size.w,
        child: Text(
          'Exercise',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.sp,
          ),
        ),
      ),
      SizedBox(
        width: size.w,
        child: Text(
          'Parameters',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.sp,
          ),
        ),
      ),
      SizedBox(
        width: (size * 2).w,
        child: Text(
          textAlign: TextAlign.center,
          'Actions',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.sp,
          ),
        ),
      ),
    ],
  );
}
