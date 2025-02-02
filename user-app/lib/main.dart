import 'package:avicare/temp/auth/signIn/page.dart';
import 'package:avicare/temp/onBoarding/onboarding_screen_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/main_screen/main_screen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final userSession = await checkUserSession();
  runApp(MyApp(userSession: userSession));
}

Future<bool> checkUserSession() async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");
  return token == null ? false : true;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.userSession});

  final bool userSession;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          fontFamily: 'Poppins',
          textTheme: ThemeData.light().textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
                decorationColor: Colors.white,
              ),
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.black,
        ),
        debugShowCheckedModeBanner: false,
        home: userSession ? MainScreen() : OnboardingScreen1(),
        // home: MainScreen(),
      ),
    );
  }
}
