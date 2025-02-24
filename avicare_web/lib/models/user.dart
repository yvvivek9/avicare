import 'package:avicare_web/utils/utils.dart';

class User {
  User({required this.id, required this.name, required this.email, this.password, this.googleID, this.appleID, this.mobile, this.gender, this.dob, this.weight, this.height, this.latitude, this.longitude});

  String id;
  String name;
  String email;
  String? password;
  String? googleID;
  String? appleID;
  String? mobile;
  String? gender;
  String? dob;
  String? weight;
  String? height;
  String? latitude;
  String? longitude;

  static Future<List<User>> fetchUserList() async {
    final response = await httpPostRequest(route: "/admin/user/list", body: {});
    return List.from(response).map((r) => fromJSON(r)).toList();
  }

  Map<String, dynamic> toJSON() => {
    "_id": id,
    "name": name,
    "email": email,
    "password": password,
    "google_id": googleID,
    "apple_id": appleID,
    "mobile": mobile,
    "gender": gender,
    "dob": dob,
    "weight": weight,
    "height": height,
    "latitude": latitude,
    "longitude": longitude,
  };

  static User fromJSON(Map<String, dynamic> json) {
    return User(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
      password: json["password"],
      googleID: json["google_id"],
      appleID: json["apple_id"],
      mobile: json["mobile"],
      gender: json["gender"],
      dob: json["dob"],
      weight: json["weight"],
      height: json["height"],
      latitude: json["latitude"],
      longitude: json["longitude"],
    );
  }
}
