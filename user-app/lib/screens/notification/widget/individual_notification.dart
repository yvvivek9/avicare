import 'package:avicare/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget individualNotification({
  required String title,
  required String description,
  required String time,
  required String image,
  required Color color,
  required dynamic Function()? onTap,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
    child: ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.r),
      ),
      onTap: onTap,
      tileColor: Colors.grey[300],
      leading: CircleAvatar(
        radius: 18.r,
        backgroundColor: color,
        child: Image.asset(
          image,
          width: 30.w,
          height: 30.h,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            time,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      trailing: Icon(Icons.more_vert_outlined),
    ),
  );
}
