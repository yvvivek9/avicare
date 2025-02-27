import 'package:avicare_web/utils/utils.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:avicare_web/models/exercise.dart';
import 'widget/new_exercise.dart';
import 'widget/update_exercise.dart';

class ExercisePageController extends GetxController {
  final exercises = Rx<List<Exercise>>([]);

  @override
  void onInit() {
    super.onInit();
    fetchExerciseList();
  }

  Future<void> fetchExerciseList() async {
    try {
      exercises.value = await Exercise.listExercises();
    } catch(e) {
      showErrorSnackBar(content: e.toString());
    }
  }

  Future<void> handleAddExercise() async {
    await showDialog(context: Get.context!, builder: (ctx) => NewExerciseDialog());
    fetchExerciseList();
  }

  Future<void> handleDeleteExercise(Exercise exercise) async {
    try {
      final confirmation = await requestConfirmation(title: "Confirm deletion", content: "${exercise.name} exercise will be permanently deleted.");
      if (!confirmation) return;
      await Exercise.deleteExercise(exercise);
      fetchExerciseList();
    } catch(e) {
      showErrorSnackBar(content: e.toString());
    }
  }

  Future<void> handleUpdateExercise(Exercise exercise) async {
    await showDialog(context: Get.context!, builder: (ctx) => UpdateExerciseDialog(exercise: exercise));
    fetchExerciseList();
  }
}