import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/custom_colors.dart';

Widget customSearchBar() {
  return Container(
    width: 358.w,
    height: 54.h,
    decoration: BoxDecoration(
      color: CustomColors.grey,
      borderRadius: BorderRadius.circular(8.r), // Added rounded corners
    ),
    child: Center(
      child: TextFormField(
        style: TextStyle(fontSize: 16.sp), // Added text style
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            size: 24.sp, // Specified icon size
            color: Colors.grey[600], // Added icon color
          ),
          border: InputBorder.none,
          labelText: 'Search by state',
          labelStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 16.sp,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          isDense: true,
          // Makes the field more compact
          floatingLabelBehavior:
              FloatingLabelBehavior.never, // Prevents label from floating
        ),
      ),
    ),
  );
}
