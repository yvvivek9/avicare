import 'package:avicare/dummy_data/individual_dates_data.dart';
import 'package:avicare/screens/home_page/widget/intro_card.dart';
import 'package:avicare/screens/home_page/widget/protocols.dart';
import 'package:avicare/screens/home_page/widget/top_app_bar.dart';
import 'package:avicare/screens/widget/individual_dates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const TopAppBar(),
          const IntroCard(),
          SizedBox(height: 18.h),
          Container(
            padding: EdgeInsets.only(left: 20.w),
            height: 80.h,
            child: ListView.builder(
              primary: false,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: individualDatesData.length,
              itemBuilder: (context, index) {
                return individualDates(
                    individualDatesModel: individualDatesData[index]);
              },
            ),
          ),
          SizedBox(height: 20.h),
          const Protocols(),
        ],
      ),
    );
  }
}
