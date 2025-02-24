import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatisticsChartWidget extends StatelessWidget {
  const StatisticsChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Title and Month
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: const [
                    TextSpan(text: 'This month Statistics '),
                    TextSpan(
                      text: '(June)',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              // Dropdown Button
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Last 1 week',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(Icons.keyboard_arrow_down, size: 20.sp),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          // Legend
          Row(
            children: [
              _buildLegendItem('Current month', Colors.black),
              SizedBox(width: 16.w),
              _buildLegendItem('Previous month', Colors.lightGreen),
            ],
          ),
          SizedBox(height: 16.h),
          // Chart
          SizedBox(
            height: 230.h,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 120,
                minY: 0,
                groupsSpace: 12,
                barTouchData: BarTouchData(enabled: true),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                          meta: meta,
                          child: Text(
                            '${value.toInt() + 13}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black87,
                            ),
                          ),
                        );
                      },
                      reservedSize: 30,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value % 20 != 0) return const SizedBox();
                        return SideTitleWidget(
                          meta: meta,
                          child: Text(
                            value.toInt().toString(),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black87,
                            ),
                          ),
                        );
                      },
                      reservedSize: 40,
                    ),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 20,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey[300],
                      strokeWidth: 1,
                      dashArray: [5, 5],
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  _createBarGroup(0, 60, 40),
                  _createBarGroup(1, 60, 65),
                  _createBarGroup(2, 80, 65),
                  _createBarGroup(3, 40, 65),
                  _createBarGroup(4, 80, 40),
                  _createBarGroup(5, 100, 65),
                  _createBarGroup(6, 80, 65),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  BarChartGroupData _createBarGroup(int x, double value1, double value2) {
    return BarChartGroupData(
      x: x,
      groupVertically: false,
      barRods: [
        BarChartRodData(
          toY: value1,
          color: Colors.black,
          width: 16.w,
          borderRadius: BorderRadius.zero,
        ),
        BarChartRodData(
          toY: value2,
          color: Colors.lightGreen,
          width: 16.w,
          borderRadius: BorderRadius.zero,
        ),
      ],
    );
  }
}
