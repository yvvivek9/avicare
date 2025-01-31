import 'package:avicare/screens/notification/widget/individual_acceptable_notification.dart';
import 'package:avicare/screens/notification/widget/individual_notification.dart';
import 'package:avicare/screens/widget/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100.h,
          leading: backButton(onTap: () {
            Get.back();
          }),
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'Notifications',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Text(
                    'Today',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Text(
                    'Clear all',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey,
                      decorationStyle: TextDecorationStyle.solid,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return individualAcceptableNotification(
                    color: Colors.blue,
                    title: 'Dr. Anuj Report Access',
                    description: 'Your appointment is scheduled for tomorrow',
                    time: '2 hours ago',
                    image: 'assets/images/knee.png',
                    onTap: () {},
                  );
                }
                return individualNotification(
                  color: Colors.blue,
                  title: 'Dr. John Doe',
                  description: 'Your appointment is scheduled for tomorrow',
                  time: '2 hours ago',
                  image: 'assets/images/knee.png',
                  onTap: () {},
                );
              },
            ),
          ],
        ));
  }
}
