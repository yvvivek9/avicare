import 'package:avicare_web/screens/hardware/widget/hardware_configuration_table.dart';
import 'package:avicare_web/screens/hardware/widget/newProduct.dart';
import 'package:avicare_web/screens/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HardwarePage extends StatelessWidget {
  const HardwarePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        customAppBar(title: "Hardware", onTap: () {}),
        SizedBox(height: 70.h),
        newProduct(),
        SizedBox(height: 30.h),
        HardwareConfigurationTable(),
      ],
    );
  }
}
