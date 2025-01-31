// statistics_screen.dart
import 'package:avicare/controller/workout_controller.dart';
import 'package:avicare/screens/widget/bottom_sheet_button.dart';
import 'package:avicare/screens/widget/bottom_sheet_icon_button.dart';
import 'package:avicare/screens/widget/build_text_field.dart';
import 'package:avicare/screens/widget/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class StatisticsScreen extends StatelessWidget {
  final controller = Get.put(WorkoutController());

  StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 70.h,
        backgroundColor: Colors.black,
        leading: backButton(
          onTap: () {
            // Get.back();
          },
        ),
        actions: [
          Row(
            children: [
              ZoomTapAnimation(
                onTap: () {},
                child: Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: 0.5.w,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      size: 18.sp,
                      color: Colors.white,
                      Icons.more_horiz_outlined,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
        ],
        centerTitle: true,
        title: Text(
          'Statistics',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10.h),
                _buildTabBar(),
                SizedBox(height: 20.h),
                _buildWorkoutTimeCard(),
                SizedBox(height: 20.h),
                _buildWorkoutTimeCard(showValue: false),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 60.h,
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(),
                    onPressed: () {},
                    icon: Icon(
                      Icons.ios_share_rounded,
                      color: Colors.black,
                      size: 20.sp,
                    ),
                    label: Text(
                      "Share",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTab('All', 0),
            _buildTab('Repetition', 1),
            _buildTab('ROM', 2),
            _buildTab('Force', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    return Obx(() {
      final isSelected = controller.selectedTab.value == index;
      return GestureDetector(
        onTap: () => controller.selectedTab.value = index,
        child: Container(
          height: 34.h,
          width: 108.w,
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.grey[200],
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildWorkoutTimeCard({bool showValue = true}) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.grid_view_rounded, size: 24.sp),
                  SizedBox(width: 8.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Workout Time Total',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '5 hours',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ZoomTapAnimation(
                onTap: () {},
                child: Icon(
                  Icons.more_vert_outlined,
                  color: Colors.black,
                  size: 20.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 150.h,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true, drawVerticalLine: false),
                titlesData: FlTitlesData(
                  show: true,
                  leftTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          controller.weekDays[value.toInt()],
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.sp,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  _createLineData(Colors.blue, false,
                      data: controller.weeklyData1),
                  _createLineData(Colors.green, false,
                      data: controller.weeklyData2),
                  _createLineData(
                    Colors.red.withOpacity(0.5),
                    false,
                    isDashed: true,
                    data: controller.weeklyData3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  LineChartBarData _createLineData(
    Color color,
    bool isFilled, {
    bool isDashed = false,
    required List<double> data,
  }) {
    return LineChartBarData(
      spots: List.generate(
        data.length,
        (index) => FlSpot(index.toDouble(), data[index]),
      ),
      isCurved: true,
      color: color,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(
        show: isFilled,
        color: color.withOpacity(0.1),
      ),
      dashArray: isDashed ? [5, 5] : null,
    );
  }
}
