import 'package:avicare/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:avicare/temp/auth/register/page.dart';

final nameRegEx = RegExp(r"\b([-,a-zA-ZÀ-ÿ. ']+[ ]*)+");
final phoneRegex = RegExp(r"[1-9][0-9]{9}");
final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
final pswdRegex = RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$");

class SignupController extends GetxController {
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isChecked = false.obs;
  final selectedCountry = Country(
    phoneCode: '91',
    countryCode: 'IN',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'India',
    example: 'India',
    displayName: 'India',
    displayNameNoCountryCode: 'IN',
    e164Key: '',
  ).obs;

  Future<void> handleSignUp() async {
    if (validateInputs()) {
      try {
        Get.context!.loaderOverlay.show();
        final response = await httpPostRequest(
          route: "/user/signup/email",
          body: {
            "name": fullNameController.text,
            "email": emailController.text,
            "mobile": "${selectedCountry.value.phoneCode}${phoneController.text}",
            "password": passwordController.text,
          },
        );

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", response["token"]);

        Get.offAll(() => RegisterScreen());
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      } finally {
        Get.context!.loaderOverlay.hide();
      }
    }
  }

  bool validateInputs() {
    if (!nameRegEx.hasMatch(fullNameController.text)) {
      Fluttertoast.showToast(msg: "Invalid name");
      return false;
    }
    if (!phoneRegex.hasMatch(phoneController.text)) {
      Fluttertoast.showToast(msg: "Invalid phone number");
      return false;
    }
    if (!emailRegex.hasMatch(emailController.text)) {
      Fluttertoast.showToast(msg: "Invalid email");
      return false;
    }
    if (!pswdRegex.hasMatch(passwordController.text)) {
      Fluttertoast.showToast(msg: "Weak password");
      return false;
    }
    if (!isChecked.value) {
      Fluttertoast.showToast(msg: "Accept terms and conditions!");
      return false;
    }
    return true;
  }
}
