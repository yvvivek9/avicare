import 'package:avicare/screens/auth/sign_in_screen.dart';
import 'package:avicare/screens/extra_screens/onboarding_screen_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'screens/main_screen/main_screen.dart';

void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        home: OnboardingScreen1(),
        // home: MainScreen(),
        // home: SplashScreen(),
      ),
    );
  }
}
