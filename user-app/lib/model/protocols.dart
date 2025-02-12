import 'package:avicare/utils/utils.dart';

class Protocol {
  Protocol({required this.id, required this.name, required this.description, required this.image, required this.exercises});

  final String id;
  String name;
  String description;
  String image;
  List<String> exercises;


  static Future<List<Protocol>> listProtocols() async {
    final response = await httpPostRequest(route: "/data/protocol/list", body: {});
    return List.from(response).map((e) => fromJSON(e)).toList();
  }

  static Future<Protocol> fetchProtocolById(String id) async {
    final response = await httpPostRequest(
      route: "/data/protocol/get",
      body: {"protocol_id": id},
    );
    return fromJSON(response);
  }

  static Protocol fromJSON(Map<String, dynamic> json) => Protocol(
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    exercises: List<String>.from(json["exercises"]),
  );

  Map<String, dynamic> toJSON() => {
    "_id": id,
    "name": name,
    "description": description,
    "image": image,
    "exercises": exercises,
  };

  @override
  String toString() {
    return 'protocol{name: $name, description: $description, steps: $exercises}';
  }
}