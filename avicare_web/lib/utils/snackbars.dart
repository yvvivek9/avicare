import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

void showSuccessSnackBar({BuildContext? context, required String content}) {
  final currContext = context ?? Get.context!;

  final snackBar = SnackBar(
    backgroundColor: Colors.green,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(
      left: 20,
      right: 20,
      bottom: 10,
    ),
    padding: EdgeInsets.all(10),
    content: Text(
      content,
      style: GoogleFonts.roboto(
        fontSize: 17,
        color: Colors.white,
      ),
    ),
    action: SnackBarAction(
      label: 'Dismiss',
      textColor: Colors.green,
      backgroundColor: Colors.white,
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  if (!currContext.mounted) return;
  ScaffoldMessenger.of(currContext).clearSnackBars();
  ScaffoldMessenger.of(currContext).showSnackBar(snackBar);
}

void showErrorSnackBar({BuildContext? context, required String content}) {
  final currContext = context ?? Get.context!;

  final snackBar = SnackBar(
    backgroundColor: Colors.red,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(
      left: 20,
      right: 20,
      bottom: 10,
    ),
    content: Text(
      content,
      style: GoogleFonts.roboto(
        fontSize: 17,
        color: Colors.white,
      ),
    ),
    action: SnackBarAction(
      label: 'Dismiss',
      textColor: Colors.red,
      backgroundColor: Colors.white,
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  if (!currContext.mounted) return;
  ScaffoldMessenger.of(currContext).clearSnackBars();
  ScaffoldMessenger.of(currContext).showSnackBar(snackBar);
}