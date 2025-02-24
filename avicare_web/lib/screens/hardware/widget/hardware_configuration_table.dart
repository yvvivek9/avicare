import 'package:avicare_web/screens/hardware/widget/hardware_table_heading.dart';
import 'package:avicare_web/screens/widget/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/custom_colors.dart';
import 'hardware_table_list_item.dart';

class HardwareConfigurationTable extends StatelessWidget {
  const HardwareConfigurationTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 0.3.sp,
        ),
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 3.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Hardware Configuration",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 300.w),
              Row(
                children: [
                  customSearchBar(),
                  SizedBox(width: 30.w),
                  InkWell(
                    onTap: () {},
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
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          hardwareTableHeading(),
          hardwareTableListItem(),
        ],
      ),
    );
  }
}
