import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildElevatedButton extends StatelessWidget {
  const BuildElevatedButton({
    super.key,
    required this.onTap,
    required this.background,
    required this.foreground,
    required this.child,
  });

  final Function onTap;
  final Color background;
  final Color foreground;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
        surfaceTintColor: Color.fromARGB(0, 0, 0, 0),
        foregroundColor: foreground,
        elevation: 5,
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 25,
        ),
        textStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      child: child,
    );
  }
}

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.readOnly = false,
  });

  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final int? maxLines;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: GoogleFonts.roboto(
        fontSize: 16,
        color: Colors.black,
      ),
      maxLines: maxLines,
      readOnly: readOnly,
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
      ),
    );
  }
}