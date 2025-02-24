import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customerTableHeading() {
  final size = 150;
  return Row(
    mainAxisSize: MainAxisSize.max,
    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: size.w,
        child: Text(
          'Customer',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.sp,
          ),
        ),
      ),
      SizedBox(
        width: size.w,
        child: Text(
          // textAlign: TextAlign.center,
          'Email',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.sp,
          ),
        ),
      ),
      SizedBox(
        width: size.w,
        child: Text(
          'Amount Paid',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.sp,
          ),
        ),
      ),
      SizedBox(
        width: size.w,
        child: Text(
          'Location',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.sp,
          ),
        ),
      ),
      SizedBox(
        width: size.w,
        child: Text(
          'Registered On',
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
