import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controller.dart';
import 'widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginScreenController controller = Get.put(LoginScreenController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: const [
                  Colors.white,
                  Colors.white70,
                ],
              ),
            ),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.9,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      spreadRadius: 1,
                      blurRadius: 10,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: const [Colors.white, Colors.white],
                    stops: const [0, 0.15],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 25,
                    horizontal: 50,
                  ),
                  child: Obx(
                        () => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 15),
                        WelcomeTextRow(),
                        SizedBox(height: 70),
                        InputField(
                          controller: controller.emailController,
                          icon: Icons.email_outlined,
                          label: "Email address",
                          keyboardType: TextInputType.emailAddress,
                          error: controller.errorWithEmail.value == ""
                              ? null
                              : controller.errorWithEmail.value,
                        ),
                        SizedBox(height: 20),
                        PasswordInputField(
                          controller: controller.passwordController,
                          icon: Icons.lock,
                          label: "Password",
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: controller.obscurePassword.value,
                          toggleVisbility: controller.togglePasswordVisibility,
                          error: controller.errorWithPassword.value == ""
                              ? null
                              : controller.errorWithPassword.value,
                        ),
                        SizedBox(height: 20),
                        // Center(
                        //   child: MouseRegion(
                        //     cursor: SystemMouseCursors.click,
                        //     child: GestureDetector(
                        //       onTap: () {
                        //         Get.to(() => ForgotPasswordScreen());
                        //       },
                        //       child: Text(
                        //         'Forgot password?',
                        //         style: GoogleFonts.roboto(
                        //           color: Color(0xff666666),
                        //           fontSize: 16,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Spacer(),
                        LoginButton(
                          onTap: controller.handleLogin,
                        ),
                        SizedBox(height: 25),
                        DividerRow(),
                        SizedBox(height: 30),
                        GoogleButton(
                          onTap: controller.socialSignIn,
                        ),
                        SizedBox(height: 50),
                        // LastLineRow(),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}