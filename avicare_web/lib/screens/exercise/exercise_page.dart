import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:avicare_web/constants/custom_colors.dart';

import 'controller.dart';
import 'widget/grid_tile.dart';

class ExercisePage extends StatelessWidget {
  ExercisePage({super.key});

  final controller = Get.put(ExercisePageController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
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
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Manage Exercises',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 370.w,
              ),
              Row(
                children: [
                  Container(
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
                          labelText: 'Search by name',
                          labelStyle: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16.sp,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                          ),
                          isDense: true,
                          // Makes the field more compact
                          floatingLabelBehavior: FloatingLabelBehavior.never, // Prevents label from floating
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 30.w),
                  InkWell(
                    onTap: controller.handleAddExercise,
                    child: Container(
                      width: 54.h,
                      height: 54.h,
                      decoration: BoxDecoration(
                        color: CustomColors.grey,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Icon(
                        Icons.add_rounded,
                        size: 32.w,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30.h),
          Obx(
            () => SizedBox(
              width: 1060.w,
              child: GridView.builder(
                primary: false,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 20.h),
                itemCount: controller.exercises.value.length,
                itemBuilder: (context, index) {
                  return GridTileWidget(
                    exercise: controller.exercises.value[index],
                    handleDelete: (exercise) => controller.handleDeleteExercise(exercise),
                    handleUpdate: (exercise) => controller.handleUpdateExercise(exercise),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
