import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final RxString selectedCategory = "Category 1".obs;
  final items = ["Category 1", "Category 2", "Category 3"];
}
