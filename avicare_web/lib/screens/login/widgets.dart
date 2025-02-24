import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class WelcomeTextRow extends StatelessWidget {
  const WelcomeTextRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        Column(
          children: [
            Text(
              'TaaviCare',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'ADMIN LOGIN',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Spacer(),
      ],
    );
  }
}

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.controller,
    required this.icon,
    required this.label,
    this.error,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
  });

  final TextEditingController controller;
  final IconData icon;
  final String label;
  final bool readOnly;
  final String? error;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      style: GoogleFonts.roboto(
        fontSize: 20,
        color: Colors.black,
      ),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          gapPadding: 0,
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          gapPadding: 0,
          borderRadius: BorderRadius.circular(20),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          gapPadding: 0,
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          gapPadding: 0,
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Color(0xfff2f2f2),
        labelText: label,
        labelStyle: GoogleFonts.roboto(
          fontSize: 17,
          color: Colors.grey,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        errorText: error,
        errorStyle: GoogleFonts.roboto(
          fontSize: 15,
          color: Colors.red,
        ),
        prefixIcon: Icon(icon),
        prefixIconConstraints: BoxConstraints(
          minWidth: 60,
        ),
        prefixIconColor: Colors.grey,
      ),
    );
  }
}

class PasswordInputField extends StatelessWidget {
  const PasswordInputField({
    super.key,
    required this.controller,
    required this.icon,
    required this.label,
    required this.toggleVisbility,
    required this.obscureText,
    this.error,
    this.readOnly = false,
    this.keyboardType = TextInputType.visiblePassword,
  });

  final TextEditingController controller;
  final IconData icon;
  final String label;
  final bool readOnly;
  final String? error;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function toggleVisbility;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      style: GoogleFonts.roboto(
        fontSize: 20,
        color: Colors.black,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          gapPadding: 0,
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          gapPadding: 0,
          borderRadius: BorderRadius.circular(20),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          gapPadding: 0,
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          gapPadding: 0,
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Color(0xfff2f2f2),
        labelText: label,
        labelStyle: GoogleFonts.roboto(
          fontSize: 17,
          color: Colors.grey,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        errorText: error,
        errorStyle: GoogleFonts.roboto(
          fontSize: 15,
          color: Colors.red,
        ),
        prefixIcon: Icon(icon),
        prefixIconConstraints: BoxConstraints(
          minWidth: 60,
        ),
        prefixIconColor: Colors.grey,
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            toggleVisbility();
          },
        ),
        suffixIconConstraints: BoxConstraints(
          minWidth: 80,
        ),
        suffixIconColor: Colors.black,
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.onTap});

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onTap(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 5,
        padding: EdgeInsets.symmetric(vertical: 15),
        textStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      child: Row(
        children: const [
          Spacer(),
          Icon(Icons.login, color: Colors.white),
          SizedBox(width: 15),
          Text("Login"),
          Spacer(),
        ],
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key, required this.onTap});

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onTap(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xfff5f5f5),
        surfaceTintColor: Color(0xffffffff),
        foregroundColor: Color(0xff575757),
        elevation: 5,
        padding: EdgeInsets.symmetric(vertical: 15),
        textStyle: GoogleFonts.poppins(
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
      child: Row(
        children: const [
          Spacer(),
          Image(
            width: 20,
            height: 20,
            image: AssetImage('assets/google_logo.png'),
          ),
          SizedBox(width: 15),
          Text("Continue with Google"),
          Spacer(),
        ],
      ),
    );
  }
}

class DividerRow extends StatelessWidget {
  const DividerRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1.5,
            color: Colors.grey,
          ),
        ),
        SizedBox(width: 10),
        Text(
          'Or',
          style: GoogleFonts.roboto(
            fontSize: 15,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Divider(
            thickness: 1.5,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class LastLineRow extends StatelessWidget {
  const LastLineRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        Text(
          "Don't have an account yet? ",
          style: GoogleFonts.roboto(fontSize: 17),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              // Get.offAll(() => SignUpScreen());
            },
            child: Text(
              "Register",
              style: GoogleFonts.roboto(
                fontSize: 17,
                color: Colors.purpleAccent,
              ),
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}