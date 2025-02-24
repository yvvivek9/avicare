import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:avicare_web/utils/utils.dart';
import 'package:avicare_web/screens/main_screen.dart';

class LoginScreenController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final errorWithEmail = "".obs;
  final errorWithPassword = "".obs;
  final obscurePassword = true.obs;
  void togglePasswordVisibility() => obscurePassword.value = !obscurePassword.value;

  Future<void> handleLogin() async {
    if (emailController.text != "admin@aviicare.com" && passwordController.text != "admin@123") {
      showErrorSnackBar(content: "Invalid credentials.");
      return;
    }

    try {
      final response = await httpPostRequest(route: "/admin/auth/login", body: {});
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", response["token"]);
      Get.offAll(() => MainScreen());
    } catch(e) {
      showErrorSnackBar(content: e.toString());
    }
  }

  Future<void> socialSignIn() async {
    showErrorSnackBar(content: "Unexpected error occurred, please try again.");
  }
}