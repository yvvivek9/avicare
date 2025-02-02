import 'package:avicare/utils/utils.dart';

class ExerciseStep {
  ExerciseStep({required this.title, required this.detail});

  final String title;
  final String detail;

  @override
  String toString() {
    return 'ExerciseStep{title: $title, detail: $detail}';
  }
}

class Exercise {
  Exercise({required this.name, required this.description, required this.youtube, required this.steps});

  final String name;
  final String description;
  final String youtube;
  final List<ExerciseStep> steps;

  static Future<Exercise> fetchExerciseById(String id) async {
    final response = await httpPostRequest(
      route: "/data/exercise/get",
      body: {"exercise_id": id},
    );

    final List<ExerciseStep> steps = [];
    final temp = List.from(response["steps"]);
    for (final t in temp) {
      steps.add(ExerciseStep(title: t["title"], detail: t["detail"]));
    }

    return Exercise(name: response["name"], description: response["description"], youtube: response["youtube"], steps: steps);
  }

  @override
  String toString() {
    return 'Exercise{name: $name, description: $description, youtube: $youtube, steps: $steps}';
  }
}
