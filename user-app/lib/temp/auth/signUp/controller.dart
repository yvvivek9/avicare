import 'package:avicare/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:avicare/model/user.dart';

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
        final response = await httpPostRequest(route: "", body: body)
      } catch (e) {
        safePrint(e);
        Fluttertoast.showToast(msg: "Unexpected error occurred. Please try again!");
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
      Fluttertoast.showToast(msg: "Invalid password");
      return false;
    }
    return true;
  }
}