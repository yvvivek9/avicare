import 'package:avicare_web/screens/users/widget/customer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:avicare_web/models/user.dart';
import 'package:avicare_web/utils/utils.dart';
import '../widget/custom_app_bar.dart';
import 'widget/stats_card.dart';

class UsersPageController extends GetxController {
  final users = Rx<List<User>>([]);

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      users.value = await User.fetchUserList();
    } catch (e) {
      safePrint(e);
      showErrorSnackBar(content: "Error fetching user data");
    }
  }

  Future<void> handleUserDelete(String id) async {
    try {
      if (!await requestConfirmation(title: "Confirm user deletion", content: "User with id:$id will be deleted")) return;
      await User.deleteUserById(id);
      fetchUserData();
    } catch (e) {
      safePrint(e);
      showErrorSnackBar(content: "Error deleting user");
    }
  }
}

class UsersPage extends StatelessWidget {
  UsersPage({super.key});

  final controller = Get.put(UsersPageController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      children: [
        SizedBox(height: 20.h),
        customAppBar(title: "Users", onTap: () {}),
        SizedBox(height: 70.h),
        Row(
          spacing: 50.w,
          children: [
            StatsCard(
              title: "Total Customer",
              value: controller.users.value.length.toString(),
              iconImageAsset: 'assets/images/customers_icon.png',
              isIncrease: true,
              changePercentage: "10",
            ),
            StatsCard(
              title: "Total Members",
              value: controller.users.value.length.toString(),
              iconImageAsset: 'assets/images/customer_icon.png',
              isIncrease: true,
              changePercentage: "10",
            ),
            StatsCard(
              title: "Active Users",
              value: controller.users.value.length.toString(),
              iconImageAsset: 'assets/images/active_users_icon.png',
              isIncrease: false,
              changePercentage: "10",
            ),
          ],
        ),
        SizedBox(height: 40.h),
        CustomerList(usersList: controller.users.value, onDeleteCallback: controller.handleUserDelete,),
      ],
    ));
  }
}
