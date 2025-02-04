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
    
    final response = await httpPostRequest(route: "/data/protocol/list", body: {});
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

  static Future<Protocol> fetchProtocolByID(String id) async {
    final response = await httpPostRequest(route: "/data/protocol/get", body: {"protocol_id": id});
    final temp = List.from(response["exercises"]);
    final List<ExerciseDataHolder> exeList = [];
    for (final t in temp) {
      exeList.add(ExerciseDataHolder(name: t["name"], exerciseID: t["exercise_id"]));
    }
    return Protocol(name: response["name"], exercises: exeList);
  }

  @override
  String toString() {
    return 'Protocol{name: $name, exercises: $exercises}';
  }
}