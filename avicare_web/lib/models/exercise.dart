import 'package:avicare_web/utils/utils.dart';

class Exercise {
  Exercise({required this.id, required this.name, required this.description, required this.youtube, required this.image, required this.steps});

  final String id;
  String name;
  String description;
  String youtube;
  String image;
  List<String> steps;

  static Future<void> addExercise(Exercise data) async {
    final response = await httpPostRequest(route: "/admin/exercise/add", body: data.toJSON());
  }

  static Future<void> updateExercise(Exercise data) async {
    final response = await httpPostRequest(route: "/admin/exercise/update", body: data.toJSON());
  }
  
  static Future<void> deleteExercise(Exercise data) async {
    final response = await httpPostRequest(route: "/admin/exercise/delete", body: {"exercise_id": data.id});
  }
  
  static Future<List<Exercise>> listExercises() async {
    final response = await httpPostRequest(route: "/data/exercise/list", body: {});
    return List.from(response).map((e) => fromJSON(e)).toList();
  }

  static Future<Exercise> fetchExerciseById(String id) async {
    final response = await httpPostRequest(
      route: "/data/exercise/get",
      body: {"exercise_id": id},
    );
    return fromJSON(response);
  }

  static Exercise fromJSON(Map<String, dynamic> json) => Exercise(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        youtube: json["youtube"],
        image: json["image"],
        steps: List<String>.from(json["steps"]),
      );

  Map<String, dynamic> toJSON() => {
    "_id": id,
    "name": name,
    "description": description,
    "youtube": youtube,
    "image": image,
    "steps": steps,
  };

  @override
  String toString() {
    return 'Exercise{name: $name, description: $description, youtube: $youtube, steps: $steps}';
  }
}

class CompactExerciseData {
  CompactExerciseData({required this.id, required this.name});

  final String id;
  final String name;

  static Future<List<CompactExerciseData>> list() async {
    final response = await httpPostRequest(route: "/data/exercise/list", body: {});
    return List.from(response).map((e) => fromJSON(e)).toList();
  }

  static CompactExerciseData fromJSON(Map<String, dynamic> json) => CompactExerciseData(id: json["_id"], name: json["name"]);

  @override
  String toString() {
    return name;
  }
}
