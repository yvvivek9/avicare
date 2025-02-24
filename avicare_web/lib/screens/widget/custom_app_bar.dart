import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/custom_colors.dart';
import 'custom_search_bar.dart';

Widget customAppBar({required String title, required onTap}) {
  return SizedBox(
    width: 1080.w,
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            customSearchBar(),
            SizedBox(width: 30.w),
            InkWell(
              onTap: onTap,
              child: Container(
                width: 54.h,
                height: 54.h,
                decoration: BoxDecoration(
                  color: CustomColors.grey,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Icon(
                  Icons.settings,
                  size: 32.w,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
