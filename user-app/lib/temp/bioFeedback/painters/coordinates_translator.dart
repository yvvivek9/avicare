import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

double translateX(
    double x,
    Size canvasSize,
    Size imageSize,
    InputImageRotation rotation,
    CameraLensDirection cameraLensDirection,
    ) {
  switch (rotation) {
    case InputImageRotation.rotation90deg:
      return x *
          canvasSize.width /
          (Platform.isIOS ? imageSize.width : imageSize.height);
    case InputImageRotation.rotation270deg:
      return canvasSize.width -
          x *
              canvasSize.width /
              (Platform.isIOS ? imageSize.width : imageSize.height);
    case InputImageRotation.rotation0deg:
    case InputImageRotation.rotation180deg:
      switch (cameraLensDirection) {
        case CameraLensDirection.back:
          return x * canvasSize.width / imageSize.width;
        default:
          return canvasSize.width - x * canvasSize.width / imageSize.width;
      }
  }
}

double translateY(
    double y,
    Size canvasSize,
    Size imageSize,
    InputImageRotation rotation,
    CameraLensDirection cameraLensDirection,
    ) {
  switch (rotation) {
    case InputImageRotation.rotation90deg:
    case InputImageRotation.rotation270deg:
      return y *
          canvasSize.height /
          (Platform.isIOS ? imageSize.height : imageSize.width);
    case InputImageRotation.rotation0deg:
    case InputImageRotation.rotation180deg:
      return y * canvasSize.height / imageSize.height;
  }
}

double calculateAngles(List<Pose> poses, PoseLandmarkType landmark1, PoseLandmarkType landmark2, PoseLandmarkType landmark3) {
  List<double> angles = [];
  for (final pose in poses) {
    final PoseLandmark joint1 = pose.landmarks[landmark1]!;
    final PoseLandmark joint2 = pose.landmarks[landmark2]!;
    final PoseLandmark joint3 = pose.landmarks[landmark3]!;

    double angle = _getAngle(joint1, joint2, joint3);
    angles.add(angle);
    // legAngle.value = angle.toStringAsFixed(2);
  }
  return angles.reduce((a, b) => a + b) / angles.length ;
}

double _getAngle(PoseLandmark firstPoint, PoseLandmark midPoint, PoseLandmark lastPoint) {
  double result = _degrees(atan2(lastPoint.y - midPoint.y, lastPoint.x - midPoint.x) - atan2(firstPoint.y - midPoint.y, firstPoint.x - midPoint.x));

  result = result.abs(); // Angle should never be negative
  if (result > 180) {
    result = 360.0 - result; // Always get the acute representation of the angle
  }
  return result;
}

double _degrees(double radians) {
  return radians * 180 / pi;
}