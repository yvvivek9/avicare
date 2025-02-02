import 'package:avicare/screens/exercise_screen/exercise_screen_2.dart';
import 'package:avicare/screens/widget/build_image.dart';
import 'package:avicare/screens/widget/icon_button.dart';
import 'package:avicare/screens/widget/progress_steps_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import 'controller.dart';
import 'widgets.dart';

class ExerciseScreen extends StatelessWidget {
  ExerciseScreen({super.key});

  final controller = Get.put(ProtocolListController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => DefaultTabController(
      length: controller.protocolsList.value.length,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.h,
          backgroundColor: Colors.black,
          title: Text(
            "Exercises",
            style: TextStyle(color: Colors.white),
          ),
          leading: backButton(onTap: () {
            Get.back();
          }),
          centerTitle: true,
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
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                _buildSearchBar(),
                SizedBox(height: 20.h),
                _buildMyExercises(),
                SizedBox(
                  height: 100.h,
                  child: _buildMyExerciseList(),
                ),
                SizedBox(height: 20.h),
                TabBar(
                  isScrollable: true,
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.blue,
                  tabs: controller.protocolsList.value.map((e) => Tab(text: "${e.name} (${e.exercises.length})")).toList(),
                  // tabs: [
                  //   Tab(text: 'All (98)'),
                  //   Tab(text: 'ACL (10)'),
                  //   Tab(text: 'PCL (10)'),
                  //   Tab(text: 'Hip Rehab (8)'),
                  // ],
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: TabBarView(
                    children: controller.protocolsList.value.map((e) => ExerciseList(exercises: e.exercises)).toList(),
                    // children: [
                    //   _buildExerciseList(),
                    //   _buildCategoryContent('ACL Exercises'),
                    //   _buildCategoryContent('PCL Exercises'),
                    //   _buildCategoryContent('Hip Rehab Exercises'),
                    // ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget _buildSearchBar() {
    return Container(
      height: 45.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          hintText: 'Search here..',
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          contentPadding:
          EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        ),
      ),
    );
  }

  Widget _buildMyExercises() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'My Exercises',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w300,
          ),
        ),
        Icon(
          Icons.arrow_forward,
          size: 25.sp,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget _buildMyExerciseList() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      itemBuilder: (context, index) => _buildMyExerciseItem(),
    );
  }

  Widget _buildMyExerciseItem() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: CachedNetworkImage(
        imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/blue-bit-simple.appspot.com/o/gym.jpeg?alt=media&token=e786b8ca-0d6c-4df9-9648-281ab2ef9877',
        imageBuilder: (context, imageProvider) {
          return Container(
            height: 100.h,
            width: 120.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        placeholder: (context, url) =>
            Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
      ),
      // child: Container(
      //   child: Image.network(
      //     'https://firebasestorage.googleapis.com/v0/b/blue-bit-simple.appspot.com/o/gym.jpeg?alt=media&token=e786b8ca-0d6c-4df9-9648-281ab2ef9877',
      //     height: 80.h,
      //     width: 100.w,
      //     fit: BoxFit.cover,
      //   ),
      // ),
    );
  }

  Widget _buildCategoryContent(String category) {
    return Center(
      child: Text(
        category,
        style: TextStyle(
          fontSize: 18.sp,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildExerciseList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => _buildExerciseItem(),
    );
  }

  Widget _buildExerciseItem() {
    return Container(
      height: 80.h,
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff898989).withValues(alpha: 0),
            Color(0xffefefef).withValues(alpha: 0.4),
          ],
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/blue-bit-simple.appspot.com/o/gym.jpeg?alt=media&token=e786b8ca-0d6c-4df9-9648-281ab2ef9877',
            imageBuilder: (context, imageProvider) {
              return Container(
                height: 80.h,
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
          ),
          // Image.network(
          //   'https://cdn.pixabay.com/photo/2017/07/02/19/24/dumbbells-2465478_1280.jpg',
          //   height: 80.h,
          //   width: 100.w,
          //   fit: BoxFit.cover,
          // ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Knee extension',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    '3:00 pm - 3:45 pm',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  ProgressStepsIndicator(totalSteps: 4, currentStep: 3),
                ],
              ),
            ),
          ),
          ZoomTapAnimation(
            onTap: () {
              Get.to(() => ExerciseScreen2(
                title: "Knee extension",
                numberOfExercises: 10,
              ));
            },
            child: Icon(
              Icons.arrow_forward,
              size: 20.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 15.w),
        ],
      ),
    );
  }
}
