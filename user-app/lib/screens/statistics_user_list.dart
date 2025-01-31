// statistics_screen.dart
import 'package:avicare/screens/widget/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class User {
  final String name;
  final String location;
  final String avatar;

  User({
    required this.name,
    required this.location,
    required this.avatar,
  });
}

class StatisticsController extends GetxController {
  var users = <User>[].obs;
  var searchQuery = ''.obs;
  var filteredUsers = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with dummy data
    users.value = [
      User(
          name: 'Rohan Somayaji',
          location: 'Gujarat',
          avatar: 'assets/avatar.png'),
      User(
          name: 'Rohan Bhattacharya',
          location: 'Kolkata',
          avatar: 'assets/avatar.png'),
      User(
          name: 'Rohan Adiga',
          location: 'Kolkata',
          avatar: 'assets/avatar.png'),
      User(
          name: 'Rohan Bhat', location: 'Kolkata', avatar: 'assets/avatar.png'),
      User(
          name: 'Rohan Khanna',
          location: 'Kolkata',
          avatar: 'assets/avatar.png'),
      User(
          name: 'Rohan Trivedi',
          location: 'Kolkata',
          avatar: 'assets/avatar.png'),
      User(
          name: 'Rohan Agarwal',
          location: 'Kolkata',
          avatar: 'assets/avatar.png'),
    ];
    filteredUsers.value = users;
  }

  void search(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredUsers.value = users;
    } else {
      filteredUsers.value = users
          .where(
              (user) => user.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}

class StatisticsUserList extends StatelessWidget {
  final StatisticsController controller = Get.put(StatisticsController());

  StatisticsUserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 100.h,
        backgroundColor: Colors.black,
        leading: backButton(onTap: () {
          Get.back();
        }),
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
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: TextField(
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  onChanged: controller.search,
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.search, color: Colors.grey, size: 20.w),
                    hintText: 'Rohan',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16.sp),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  ),
                ),
              ),
            ),

            // Users count
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Obx(() => Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${controller.filteredUsers.length} users found',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.sp,
                      ),
                    ),
                  )),
            ),

            // Users List
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: controller.filteredUsers.length,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemBuilder: (context, index) {
                      final user = controller.filteredUsers[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 8.h),
                        decoration: BoxDecoration(
                          color: index == 0
                              ? const Color(0xFF2196F3)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 0.h),
                          leading: CircleAvatar(
                            radius: 20.r,
                            backgroundColor: Colors.grey[800],
                            child: Icon(Icons.person,
                                color: Colors.white, size: 24.w),
                          ),
                          title: Text(
                            user.name,
                            style: TextStyle(
                              color: index == 0 ? Colors.white : Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            user.location,
                            style: TextStyle(
                              color: index == 0 ? Colors.white : Colors.grey,
                              fontSize: 14.sp,
                            ),
                          ),
                          trailing: index == 0
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 8.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  child: Text(
                                    'Request',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
