import 'package:avicare/constants/colors.dart';
import 'package:avicare/model/old/individual_dates_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget individualDates({
  required IndividualDatesModel individualDatesModel,
}) {
  return Container(
    width: 50.w,
    height: 80.h,
    margin: EdgeInsets.symmetric(horizontal: 5.w),
    decoration: BoxDecoration(
      color: !individualDatesModel.isToday
          ? const Color(0xffEFEFEF)
          : Colors.black,
      border: Border.all(color: Colors.white, width: 1.w),
      borderRadius: BorderRadius.circular(60.r),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        individualDatesModel.isSelected
            ? Container(
                width: 5.w,
                height: 5.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: individualDatesModel.isToday
                      ? Colors.white
                      : Colors.black.withOpacity(0.2),
                ),
              )
            : Container(
                width: 5.w,
                height: 5.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
              ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          individualDatesModel.day,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: !individualDatesModel.isToday
                ? Colors.black.withOpacity(0.5)
                : AppColors.slightGrey.withOpacity(0.5),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          individualDatesModel.date,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: !individualDatesModel.isToday
                ? Colors.black.withOpacity(0.5)
                : AppColors.slightGrey.withOpacity(0.5),
          ),
        ),
      ],
    ),
  );
}
