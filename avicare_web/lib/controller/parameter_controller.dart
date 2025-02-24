// parameters_controller.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ParametersController extends GetxController {
  final parameters = <String>[].obs;
  final textController = TextEditingController();

  void addParameter() {
    String input = textController.text.trim();
    // Convert first letter to uppercase to match with validParameters
    String capitalizedInput = input.isNotEmpty
        ? input[0].toUpperCase() + input.substring(1).toLowerCase()
        : '';
    parameters.add(capitalizedInput);
    textController.clear();
  }

  void removeParameter(String parameter) {
    parameters.remove(parameter);
  }
}
