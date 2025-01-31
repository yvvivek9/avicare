import 'package:avicare/utils/utils.dart';

class ExerciseDataHolder {
  ExerciseDataHolder({required this.name, required this.exerciseID});

  final String name;
  final String exerciseID;

  @override
  String toString() {
    return 'ExerciseDataHolder{name: $name, exerciseID: $exerciseID}';
  }
}

class Protocol {
  Protocol({required this.name, required this.exercises});

  final String name;
  final List<ExerciseDataHolder> exercises;

  static Future<List<Protocol>> fetchProtocolList() async {
    final List<Protocol> protocolList = [];
    
    final response = await httpPostRequest(route: "/user/protocol/list", body: {});
    final tempList = List.from(response);

    for (final temp in tempList) {
      final exeTempList = List.from(temp["exercises"]);
      final List<ExerciseDataHolder> exeList = [];
      for (final exe in exeTempList) {
        exeList.add(ExerciseDataHolder(name: exe["name"], exerciseID: exe["exercise_id"]));
      }
      protocolList.add(Protocol(name: temp["name"], exercises: exeList));
    }
    
    return protocolList;
  }

  @override
  String toString() {
    return 'Protocol{name: $name, exercises: $exercises}';
  }
}