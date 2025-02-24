import 'dart:developer' as developer;
export 'requests.dart';
export 'file_storage.dart';

void safePrint(dynamic content) {
  developer.log(content.toString());
}