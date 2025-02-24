import 'package:avicare_web/screens/dashboard/dashbord_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/protocols/page.dart';
import '../screens/exercise/exercise_page.dart';
import '../screens/hardware/hardware_page.dart';
import '../screens/users/users_page.dart';
import '../screens/policies/privacy.dart';
import '../screens/policies/terms.dart';

class MainController extends GetxController {
  List<Widget> screens = [
    DashboardPage(),
    UsersPage(),
    ExercisePage(),
    ProtocolsPage(),
    HardwarePage(),
    PrivacyPolicyPage(),
    TermsConditionsPage(),
  ];
  RxInt selectedIndex = 2.obs;
}
