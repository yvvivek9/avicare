import 'package:avicare_web/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:avicare_web/screens/login/page.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // final userSession = await checkUserSession();
  runApp(MyApp(userSession: false));
}

Future<bool> checkUserSession() async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");
  return token == null ? false : true;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.userSession});

  final bool userSession;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1024),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GlobalLoaderOverlay(
          overlayColor: Colors.grey.withAlpha(150),
          overlayWidgetBuilder: (_) {
            return Center(
              child: SpinKitSpinningLines(
                color: Colors.black,
                lineWidth: 3.0,
              ),
            );
          },
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            // home: MainScreen(),
            home: userSession ? MainScreen() : LoginScreen(),
          ),
        );
      },
      // child: GetMaterialApp(
      //   debugShowCheckedModeBanner: false,
      //   title: 'Flutter Demo',
      //   theme: ThemeData(
      //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //     useMaterial3: true,
      //   ),
      //   home: DashboardPage(),
      // ),
    );
  }
}
