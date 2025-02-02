import 'package:avicare/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:avicare/temp/homePage/page.dart';

final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
final pswdRegex = RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$");

class SigninController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> handleEmailSigninIn() async {
    if (validateInputs()) {
      try {
        Get.context!.loaderOverlay.show();
        final response = await httpPostRequest(
          route: "/user/login/email",
          body: {
            "email": emailController.text,
            "password": passwordController.text,
          },
        );

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", response["token"]);

        Get.offAll(() => MainScreen());
      } catch(e) {
        Fluttertoast.showToast(msg: e.toString());
      } finally {
        Get.context!.loaderOverlay.hide();
      }
    }
  }

  bool validateInputs() {
    if (!emailRegex.hasMatch(emailController.text)) {
      Fluttertoast.showToast(msg: "Invalid email");
      return false;
    }
    if (!pswdRegex.hasMatch(passwordController.text)) {
      Fluttertoast.showToast(msg: "Invalid password");
      return false;
    }
    return true;
  }
}