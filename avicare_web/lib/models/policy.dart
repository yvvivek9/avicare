import 'package:avicare_web/utils/utils.dart';

class Policy {
  Policy({required this.id, required this.name, required this.content});
  
  final String id;
  final String name;
  String content;
  
  static Future<Policy> getPrivacyPolicy() async {
    final response = await httpPostRequest(route: "/policies/privacy/get", body: {});
    return fromJSON(response);
  }

  static Future<Policy> getTermsConditions() async {
    final response = await httpPostRequest(route: "/policies/terms/get", body: {});
    return fromJSON(response);
  }

  static Policy fromJSON(Map<String, dynamic> json) => Policy(id: json["_id"], name: json["name"], content: json["content"]);
  
  Map<String, dynamic> toJSON() => {"_id": id, "name": name, "content": content};

  @override
  String toString() {
    return "File id: $id, name: $name";
  }
}