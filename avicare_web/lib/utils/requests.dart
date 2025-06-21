import 'package:avicare_web/utils/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:avicare_web/screens/login/page.dart';

const String apiKey = "fnw4ua8bdueu5vckkhg56jaq8xy9m8";
const String domain = "http://52.66.134.203:5000";
// const String domain = "http://127.0.0.1:5000";

Future<dynamic> httpPostRequest({
  required String route,
  required Map<String, dynamic> body,
  int successCode = 200,
}) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    final response = await http.post(
      Uri.parse(domain + route),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
        'X-API-Key': apiKey,
        'Authorization': token != null ? 'Bearer $token' : '',
      },
      body: jsonEncode(body),
    );

    final decodedResponse = jsonDecode(response.body);
    if (response.statusCode == successCode) {
      return decodedResponse;
    } else if (response.statusCode == 400) {
      throw CustomException(decodedResponse["detail"]);
    } else if (response.statusCode == 401) {
      await prefs.remove("token");
      Get.offAll(() => LoginScreen());
      throw CustomException("Session expired! Please login again.");
    } else {
      throw CustomException("Unexpected error occurred!. Please try again");
    }
  } on CustomException catch (e) {
    rethrow;
  } catch (e) {
    safePrint(e);
    throw CustomException("Unexpected error occurred!. Please try again");
  }
}

class CustomException {
  CustomException(this.message);
  final String message;

  @override
  String toString() {
    return message;
  }
}