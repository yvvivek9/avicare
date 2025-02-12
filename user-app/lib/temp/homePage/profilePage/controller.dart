import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:avicare/temp/auth/signIn/page.dart';
import 'package:avicare/utils/utils.dart';
import 'package:avicare/model/user.dart';

class ProfilePageController extends GetxController {
  final isPopupActive = false.obs;
  final user = User(id: "", name: "--", email: "--").obs;

  @override
  void onInit() {
    fetchUserData();
    super.onInit();
  }

  Future<void> fetchUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getString("token") == null) return;

      final response = await httpPostRequest(route: "/user/details/get", body: {});
      user.value = User.fromJSON(response);
    } catch(e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  String calculateAge() {
    if (user.value.dob == null) return " -- ";

    final currentYear = DateTime.now().year;
    final birthYear = int.parse(user.value.dob!.split("/").last);

    return (currentYear - birthYear).toString();
  }

  Future<void> handleLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    Get.offAll(() => SignInScreen());
  }
}