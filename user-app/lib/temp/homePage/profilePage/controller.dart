import 'package:avicare/utils/confirmation.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'dart:math';

import 'package:avicare/temp/auth/signIn/page.dart';
import 'package:avicare/utils/utils.dart';
import 'package:avicare/model/user.dart';

class ProfilePageController extends GetxController {
  final isPopupActive = false.obs;
  final user = User(id: "", name: "--", email: "--").obs;
  final loggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    StoredFile.updateFilesFromServer().whenComplete(StoredFile.getFilesFromStorage);
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getString("token") == null) return;
      loggedIn.value = true;

      final response = await httpPostRequest(route: "/user/details/get", body: {});
      user.value = User.fromJSON(response);
      updateUserLocation();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> updateUserLocation() async {
    Location location = Location();

    // checking for location access
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.deniedForever) return;
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // checking if location is enabled
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    // getting local user location
    final LocationData locationData = await location.getLocation();

    try {
      if (user.value.latitude != null && user.value.longitude != null) {
        if (calculateDistance(double.parse(user.value.latitude!), double.parse(user.value.longitude!), locationData.latitude!, locationData.longitude!) < locationOffset) return;
      }
      user.value.latitude = locationData.latitude!.toString();
      user.value.longitude = locationData.longitude!.toString();
      await User.updateUser(user.value);
    } catch (e) {
      safePrint(e);
      Fluttertoast.showToast(msg: "Unable to update location!");
    }
  }

  String calculateAge() {
    if (user.value.dob == null) return " -- ";

    final currentYear = DateTime.now().year;
    final birthYear = int.parse(user.value.dob!.split("/").last);

    return (currentYear - birthYear).toString();
  }

  final double locationOffset = 30; // in km
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<void> handleLogout() async {
    final confirmation = await requestConfirmation(
      title: "Logout confirmation",
      content: "You will be logged out of your current device. Please note your credentials to login again.",
    );
    if (!confirmation) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    Get.deleteAll();
    Get.offAll(() => SignInScreen());
  }

  Future<void> handleAccountDelete() async {
    final confirmation = await requestConfirmation(
      title: "Confirm account deletion",
      content: "Please note this process is not reversible, deleting your account will delete all your personal data.",
    );
    if (!confirmation) return;
    try {
      final response = await httpPostRequest(route: "/user/account/delete", body: {});
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove("token");
      Get.deleteAll();
      Get.offAll(() => SignInScreen());
    } catch(e) {
      safePrint(e);
      Fluttertoast.showToast(msg: "Error deleting account!");
    }
  }
}
