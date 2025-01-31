import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget generalOption({
  required String title,
  required IconData prefixIcon,
  Widget? switchWidget,
}) {
  return ListTile(
    minTileHeight: 60.h,
    tileColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(60.r),
    ),
    leading: Icon(prefixIcon),
    title: Text(title),
    trailing: switchWidget ?? Icon(Icons.arrow_forward_ios),
  );
}
