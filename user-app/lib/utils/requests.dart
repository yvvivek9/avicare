import 'package:avicare/utils/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:avicare/temp/auth/signIn/page.dart';

const String apiKey = "fnw4ua8bdueu5vckkhg56jaq8xy9m8";
const String domain = "http://34.47.250.183:5000";

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
        'X-API-Key': apiKey,
        'Authorization': token != null ? 'Bearer $token' : '',
      },
      body: jsonEncode(body),
    );

    final decodedResponse = jsonDecode(response.body);
    if (response.statusCode == successCode) {
      return decodedResponse;
    } else if (response.statusCode == 400) {
      throw Exception(decodedResponse["detail"]);
    } else if (response.statusCode == 401) {
      await prefs.remove("token");
      Get.offAll(() => SignInScreen());
      throw Exception("Session expired! Please login again.");
    } else {
      throw Exception("Unexpected error occurred!. Please try again");
    }
  } catch (e) {
    safePrint(e);
    throw Exception("Unexpected error occurred!. Please try again");
  }
}
