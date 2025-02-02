import 'package:avicare/screens/bio_feedback_screen.dart';
import 'package:avicare/temp/homePage/firstPage/page.dart';
import 'package:avicare/screens/statistics_screens/statistics_screen.dart';
import 'package:avicare/screens/statistics_screens/statistics_screen_2.dart';
import 'package:avicare/screens/widget/animated_arrows.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'exercise_screen/exercise_details_screen.dart';
import 'exercise_screen/exercise_screen_2.dart';
import 'extra_screens/end_screen.dart';
import 'extra_screens/end_screen_2.dart';
import 'extra_screens/error_screen.dart';
import 'extra_screens/error_screen_2.dart';
import 'exercise_screen/exercise_screen.dart';
import 'extra_screens/access_page.dart';
import 'extra_screens/workout_completed_screen.dart';
import 'statistics_user_list.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Demo Screen",
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20.h),
              ..._buttonList().map((data) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: _customButton(data['widget'], data['title']),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _buttonList() {
    return [
      {'widget': HomeScreen2(), 'title': "Home Screen 2"},
      {
        'widget': WorkoutCompletionScreen(duration: 60, reps: 38),
        'title': "Workout Completion"
      },
      {'widget': AccessPage(), 'title': "Access Page"},
      {'widget': ErrorScreen(), 'title': "Error Screen"},
      {'widget': ErrorScreen2(), 'title': "Error Screen 2"},
      {'widget': EndScreen(), 'title': "End Screen"},
      {'widget': EndScreen2(), 'title': "End Screen 2"},
      // {'widget': OnboardingScreen1(), 'title': "Onboarding 1"},
      // {'widget': OnboardingScreen2(), 'title': "Onboarding 2"},
      // {'widget': OnboardingScreen3(), 'title': "Onboarding 3"},
      {'widget': StatisticsUserList(), 'title': "Statistics"},
      // {'widget': SignupScreen(), 'title': "Signup"},
      {'widget': StatisticsScreen(), 'title': "Statistics screen"},
      {'widget': StatisticsScreen2(), 'title': "Statistics screen 2"},
      // {'widget': RegisterScreen(), 'title': "Register"},
      {'widget': ExerciseScreen(), 'title': "Exercise"},
      {
        'widget': ExerciseScreen2(
          title: "Exercise 2",
          numberOfExercises: 6,
        ),
        'title': "Exercise 2"
      },
      // {'widget': ExerciseDetailsScreen(), 'title': "Exercise Details"},
      {'widget': BioFeedbackScreen(), 'title': "Bio Feedback"},
    ];
  }

  Widget _customButton(Widget goto, String title) {
    return Card(
      elevation: 4,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          textStyle: TextStyle(fontSize: 18.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        onPressed: () => Get.to(() => goto),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_forward, size: 20.sp), // Example icon
            SizedBox(width: 8.w), // Space between icon and text
            Text(title),
          ],
        ),
      ),
    );
  }
}
