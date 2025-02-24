import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String changePercentage;
  final bool isIncrease;
  final String iconImageAsset;

  const StatsCard({super.key, required this.title, required this.iconImageAsset, required this.value, required this.isIncrease, required this.changePercentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330.w,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 0.3.sp,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  iconImageAsset,
                ),
              ),
              Icon(
                Icons.more_vert,
                size: 24.sp,
                color: Colors.black54,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: isIncrease ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      isIncrease ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 16.sp,
                      color: isIncrease ? Colors.green : Colors.red,
                    ),
                    Text(
                      changePercentage,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: isIncrease ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
