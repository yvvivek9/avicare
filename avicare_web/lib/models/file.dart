import 'dart:convert';
import 'dart:typed_data';
import 'package:avicare_web/utils/utils.dart';

class File {
  static Future<Uint8List?> getFileByID(String id) async {
    try {
      final response = await httpPostRequest(route: "/data/files/get", body: {"file_id": id});
      return base64Decode(response["content"]);
    } catch(e) {
      return null;
    }
  }
}