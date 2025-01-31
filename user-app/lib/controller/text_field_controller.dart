import 'package:get/get.dart';

class TextFieldController extends GetxController {
  final RxBool isObscured = false.obs;

  void toggleObscured() {
    isObscured.value = !isObscured.value;
  }
}
