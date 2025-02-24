import 'package:avicare/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:avicare/temp/homePage/page.dart';
import 'package:avicare/temp/onBoarding/access_page.dart';

final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
final pswdRegex = RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$");

class SigninController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> handleGoogleLogin() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: <String>[
          'email',
        ],
      );

      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) throw Exception();
      final response = await httpPostRequest(
        route: "/user/login/google",
        body: {
          "google_id": googleUser.id,
          "email": googleUser.email,
          "name": googleUser.displayName ?? "",
        },
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", response["token"]);
      await googleSignIn.signOut();
      checkPermissionsAndRedirect();
    } catch (e) {
      Fluttertoast.showToast(msg: "Unexpected error occurred, please try again!");
    }
  }

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

        checkPermissionsAndRedirect();
      } catch (e) {
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

  Future<void> checkPermissionsAndRedirect() async {
    final permissions = [
      Permission.nearbyWifiDevices,
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
      Permission.camera,
    ];
    for (final p in permissions) {
      if (!await p.status.isGranted) {
        Get.offAll(() => AccessPage());
        return;
      }
    }
    Get.offAll(() => MainScreen());
  }
}
