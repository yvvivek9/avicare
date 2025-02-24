import 'package:avicare/utils/utils.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';

class StoredFile {
  const StoredFile({required this.id, required this.mime, required this.content});

  final String id;
  final String mime;
  final String content;

  static List<StoredFile> list = [];

  static StoredFile? getFileByID(String id) => list.firstWhereOrNull((e) => e.id == id);

  static Future<void> updateFilesFromServer() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> temp = [];

      final response = await httpPostRequest(route: "/data/files/check", body: {});
      if (response == prefs.getString("files check")) {
        return;
      } else {
        prefs.setString("files check", response);
      }

      final uri = Uri.parse("ws://$ipAddress/ws/files/list");
      final channel = WebSocketChannel.connect(uri);
      await channel.ready;
      channel.sink.add('received!');
      final Completer<void> completer = Completer();
      channel.stream.listen(
        (message) {
          channel.sink.add('received!');
          temp.add(message);
        },
        onDone: () => completer.complete(),
        onError: (e) => completer.complete(),
      );
      await completer.future;
      safePrint("Files updated, current count: ${temp.length}");
      await prefs.setStringList("files", temp);
    } catch (e) {
      safePrint(e);
    }
  }

  static Future<void> getFilesFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final stringList = prefs.getStringList("files")!;
    final List<StoredFile> temp = [];
    for (final string in stringList) {
      temp.add(fromJSON(jsonDecode(string)));
    }
    list = temp;
  }

  Map<String, dynamic> toJSON() => {"_id": id, "mime": mime, "content": content};

  static StoredFile fromJSON(Map<String, dynamic> json) => StoredFile(id: json["_id"], mime: json["mime"], content: json["content"]);

  @override
  String toString() {
    return 'StoredFile{id: $id}';
  }
}
