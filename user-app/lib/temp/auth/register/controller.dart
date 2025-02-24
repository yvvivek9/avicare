import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:avicare/temp/homePage/page.dart';
import 'package:avicare/temp/onBoarding/access_page.dart';
import 'package:avicare/utils/utils.dart';
import 'package:avicare/model/user.dart';

final decimalRegex = RegExp(r"[0-9]*\.*[0-9]*");

class ProfileController extends GetxController {
  final userType = Rxn<String>();
  final gender = Rxn<String>();
  final birthDate = Rxn<DateTime>();
  final weight = Rxn<String>();
  final height = Rxn<String>();
  final weightUnit = RxString('kgs');
  final heightUnit = RxString('cm');
  RxBool isPopupActive = false.obs;

  void setUserType(String? value) => userType.value = value;

  void setGender(String? value) => gender.value = value;

  void setBirthDate(DateTime? value) => birthDate.value = value;

  void setWeight(String value) => weight.value = value;

  void setHeight(String value) => height.value = value;

  void toggleWeightUnit(String unit) => weightUnit.value = unit;

  void toggleHeightUnit(String unit) => heightUnit.value = unit;
  
  
  Future<void> handleSubmit() async {
    try {
      if (!validateInputs()) return;

      Get.context!.loaderOverlay.show();
      final response = await httpPostRequest(route: "/user/details/get", body: {});
      final user = User.fromJSON(response);

      user.gender = gender.value;
      user.dob = "${birthDate.value!.day}/${birthDate.value!.month}/${birthDate.value!.year}";
      user.weight = "${weight.value} ${weightUnit.value}";
      user.height = "${height.value} ${heightUnit.value}";

      final response2 = await httpPostRequest(route: "/user/details/update", body: user.toJSON());
      checkPermissionsAndRedirect();
    } catch(e) {
      Fluttertoast.showToast(msg: "Unexpected error occurred, please try again!");
    } finally {
      Get.context!.loaderOverlay.hide();
    }
  }

  bool validateInputs() {
    if (userType.value == null) {
      Fluttertoast.showToast(msg: "Select user type");
      return false;
    }
    if (gender.value == null) {
      Fluttertoast.showToast(msg: "Select gender");
      return false;
    }
    if (birthDate.value == null) {
      Fluttertoast.showToast(msg: "Select date of birth");
      return false;
    }
    if (weight.value == null) {
      Fluttertoast.showToast(msg: "Enter valid weight");
      return false;
    }
    if (!decimalRegex.hasMatch(weight.value!)) {
      Fluttertoast.showToast(msg: "Enter valid weight");
      return false;
    }
    if (height.value == null) {
      Fluttertoast.showToast(msg: "Enter valid height");
      return false;
    }
    if (!decimalRegex.hasMatch(height.value!)) {
      Fluttertoast.showToast(msg: "Enter valid height");
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
