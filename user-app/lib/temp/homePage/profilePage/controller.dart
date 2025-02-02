import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

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
      Get.context!.loaderOverlay.show();
      final response = await httpPostRequest(route: "/user/details/get", body: {});
      user.value = User.fromJSON(response);
    } catch(e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      Get.context!.loaderOverlay.hide();
    }
  }

  String calculateAge() {
    if (user.value.dob == null) return " -- ";

    final currentYear = DateTime.now().year;
    final birthYear = int.parse(user.value.dob!.split("/").last);

    return (currentYear - birthYear).toString();
  }
}