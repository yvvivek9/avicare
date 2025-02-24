import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:avicare/utils/utils.dart';
import 'package:avicare/model/user.dart';

final decimalRegex = RegExp(r"[0-9]*\.*[0-9]*");

class UpdateProfileController extends GetxController {
  late User user;
  final userType = TextEditingController();
  final gender = TextEditingController();
  final dob = TextEditingController();
  final weight = TextEditingController();
  final height = TextEditingController();
  final weightUnit = "kgs".obs;
  final heightUnit = "cm".obs;

  Future<void> handleSubmit() async {
    try {
      if (!validateInputs()) return;

      Get.context!.loaderOverlay.show();

      user.gender = gender.text;
      user.dob = dob.text;
      user.weight = "${weight.text} ${weightUnit.value}";
      user.height = "${height.text} ${heightUnit.value}";

      final response2 = await httpPostRequest(route: "/user/details/update", body: user.toJSON());
      Get.back();
    } catch(e) {
      Fluttertoast.showToast(msg: "Unexpected error occurred, please try again!");
    } finally {
      Get.context!.loaderOverlay.hide();
    }
  }

  bool validateInputs() {
    if (userType.text == "") {
      Fluttertoast.showToast(msg: "Select user type");
      return false;
    }
    if (gender.text == "") {
      Fluttertoast.showToast(msg: "Select gender");
      return false;
    }
    if (dob.text == "") {
      Fluttertoast.showToast(msg: "Select date of birth");
      return false;
    }
    if (weight.text == "") {
      Fluttertoast.showToast(msg: "Enter valid weight");
      return false;
    }
    if (!decimalRegex.hasMatch(weight.text)) {
      Fluttertoast.showToast(msg: "Enter valid weight");
      return false;
    }
    if (height.text == "") {
      Fluttertoast.showToast(msg: "Enter valid height");
      return false;
    }
    if (!decimalRegex.hasMatch(height.text)) {
      Fluttertoast.showToast(msg: "Enter valid height");
      return false;
    }

    return true;
  }
}