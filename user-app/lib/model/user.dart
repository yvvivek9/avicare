import 'package:avicare/utils/utils.dart';

class User {
  User({required this.id, required this.name, required this.email, this.password, this.googleID, this.appleID, this.mobile, this.gender, this.dob, this.weight, this.height});

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

  static Future<void> updateUser(User user) async {
    final response = await httpPostRequest(
      route: "/user/details/update",
      body: user.toJSON(),
    );
  }

  static Future<User> getUser() async {
    final response = await httpPostRequest(route: "/user/details/get", body: {});
    return fromJSON(response);
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
    );
  }
}
