import 'package:avicare/constants/colors.dart';
import 'package:avicare/controller/battery_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BatteryIndicatorWithLink extends StatelessWidget {
  final double size;

  BatteryIndicatorWithLink({
    super.key,
    this.size = 44.0,
  }) {
    Get.lazyPut(() => BatteryController(), fenix: true);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BatteryController>();

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.linkIconBorder,
          width: size * 0.02,
        ),
      ),
      child: Stack(
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: BatteryPainter(
              percentage: controller.batteryPercentage.value / 100,
              color: controller.getBatteryColor(),
            ),
          ),
          const Center(
            child: ImageIcon(
              color: Colors.white,
              AssetImage("assets/images/link.png"),
            ),
          ),
        ],
      ),
    );
  }
}

class BatteryPainter extends CustomPainter {
  final double percentage;
  final Color color;

  BatteryPainter({
    required this.percentage,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final Paint batteryPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    // Draw background circle
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw battery level
    final Path batteryPath = Path();
    final double heightOffset = size.height * (1 - percentage);

    batteryPath.addOval(
      Rect.fromLTWH(
        0,
        heightOffset,
        size.width,
        size.height - heightOffset,
      ),
    );

    canvas.clipPath(batteryPath);
    canvas.drawCircle(center, radius, batteryPaint);
  }

  @override
  bool shouldRepaint(BatteryPainter oldDelegate) {
    return oldDelegate.percentage != percentage || oldDelegate.color != color;
  }
}
