// Controller

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BatteryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> levelAnimation;
  late Animation<double> opacityAnimation;
  final RxInt batteryPercentage = 10.obs;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    levelAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));

    opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.6, end: 1.0),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.6),
        weight: 1,
      ),
    ]).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));

    animationController.repeat(reverse: true);
    // updateBatteryPercentage();
  }

  // void updateBatteryPercentage() {
  //   Timer.periodic(const Duration(milliseconds: 1000), (timer) {
  //     if (batteryPercentage.value >= 99) {
  //       batteryPercentage.value = 0; // Reset after reaching 99
  //     } else {
  //       batteryPercentage.value++;
  //     }
  //     debugPrint('Battery Percentage: ${batteryPercentage.value}');
  //   });
  // }

  Color getBatteryColor() {
    if (batteryPercentage.value <= 20) {
      return Colors.red;
    } else if (batteryPercentage.value <= 50) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (Get.isRegistered<BatteryController>()) {
      Get.delete<BatteryController>();
    }
    super.dispose();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
