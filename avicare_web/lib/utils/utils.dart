import 'dart:developer' as developer;
export 'requests.dart';
export 'snackbars.dart';
export 'confirmation.dart';

void safePrint(dynamic content) {
  developer.log(content.toString());
}